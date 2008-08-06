From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl/Makefile: handle paths with spaces in the
 NO_PERL_MAKEMAKER section
Date: Wed, 06 Aug 2008 13:15:26 -0700
Message-ID: <7vy739nbmp.fsf@gitster.siamese.dyndns.org>
References: <mLu74vNKfH1vFZlC7N_lRX3WekWReoVjWY42voUDUBUnAGVpDNYWndWqlaHoqVAkxOaCdYV6uDk@cipher.nrlssc.navy.mil> <osgPH47FO7h-zLUMqwCv-i9BWln2-_AK5T6TI-5mLGFjwAhJ4Bg_lw@cipher.nrlssc.navy.mil> <7v8wvbuit7.fsf@gitster.siamese.dyndns.org> <klGWkbWGpsUHZpuNwl9WvZs5UGGfYVAngWbiM3eippaejrXLNyLpRA@cipher.nrlssc.navy.mil> <7v7iaurwe4.fsf@gitster.siamese.dyndns.org> <lh6XIUcjpbjj8G8Ot7RQFlDitUn1njsc350QhnNmQkcgxlfluBPGZw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:16:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQpR5-0000Eb-7I
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 22:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760533AbYHFUPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 16:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760229AbYHFUPg
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 16:15:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758236AbYHFUPf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 16:15:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 730504DF31;
	Wed,  6 Aug 2008 16:15:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B18BD4DF2F; Wed,  6 Aug 2008 16:15:29 -0400 (EDT)
In-Reply-To: <lh6XIUcjpbjj8G8Ot7RQFlDitUn1njsc350QhnNmQkcgxlfluBPGZw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 06 Aug 2008 14:31:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BE949C0-63F4-11DD-9985-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91537>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> There are problems here with spaces, single quotes, and double quotes.
> I'll follow up in another email.

I guess we've opened up a large can of worms.  Let's have the minimum fix
that says "We do support whitespace in these paths but no other funnies"
and leave the more intrusive one for post 1.6.0, for now.
