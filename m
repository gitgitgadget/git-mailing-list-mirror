From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to know where a reference name comes from?
Date: Thu, 27 Nov 2008 01:47:11 -0800
Message-ID: <7v4p1tbiw0.fsf@gitster.siamese.dyndns.org>
References: <vpqk5ap5xy1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 27 10:49:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5dUm-0007lx-3R
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 10:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYK0Jrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 04:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbYK0Jrz
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 04:47:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYK0Jry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 04:47:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A1F7C81FE6;
	Thu, 27 Nov 2008 04:47:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 943EA81FC6; Thu,
 27 Nov 2008 04:47:13 -0500 (EST)
In-Reply-To: <vpqk5ap5xy1.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 27 Nov 2008 10:18:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7593CCDA-BC68-11DD-9F8F-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101804>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> (I ended up doing "strace -e open git rev-parse git-svn", and found
> out I had a .git/git-svn file lying around)

This has been proposed for a couple of times now but I think it might be
time to start insisting on a ref directly underneath $GIT_DIR to be in all
caps (plus underscore) to avoid issues like this while still allowing
traditional MERGE_HEAD, ORIG_HEAD and friends.
