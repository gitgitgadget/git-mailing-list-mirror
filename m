From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl/Makefile: handle paths with spaces in the
 NO_PERL_MAKEMAKER section
Date: Tue, 05 Aug 2008 16:46:12 -0700
Message-ID: <7v8wvbuit7.fsf@gitster.siamese.dyndns.org>
References: <mLu74vNKfH1vFZlC7N_lRX3WekWReoVjWY42voUDUBUnAGVpDNYWndWqlaHoqVAkxOaCdYV6uDk@cipher.nrlssc.navy.mil> <osgPH47FO7h-zLUMqwCv-i9BWln2-_AK5T6TI-5mLGFjwAhJ4Bg_lw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 06 01:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQWFX-0004XN-6W
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 01:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222AbYHEXqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 19:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113AbYHEXqU
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 19:46:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbYHEXqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 19:46:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3CE604C7F6;
	Tue,  5 Aug 2008 19:46:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D6DB74C7F4; Tue,  5 Aug 2008 19:46:14 -0400 (EDT)
In-Reply-To: <osgPH47FO7h-zLUMqwCv-i9BWln2-_AK5T6TI-5mLGFjwAhJ4Bg_lw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue, 05 Aug 2008 18:23:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2F6B3FE-6348-11DD-BE39-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91471>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Use double quotes to protect against paths which may contain spaces.
> ...
> +	echo '	mkdir -p "$(instdir_SQ)"' >> $@

Is this sufficient?  We seem to apply double-sq when writing shell
scriptlet in GIT-BUILD-OPTIONS from the main Makefile, and I suspect you
would need to do something similar.
