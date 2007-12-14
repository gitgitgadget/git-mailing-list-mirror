From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [BUG] Failed to make install-info
Date: Fri, 14 Dec 2007 08:38:08 -0600
Message-ID: <E1J3Bg0-0004Ut-Ii@jdl.com>
References: <E1J2q92-0001YT-BZ@jdl.com> <200712140635.39311.chriscool@tuxfamily.org>  <7vejdpvmlw.fsf@gitster.siamese.dyndns.org>
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 15:39:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Bgk-0006Wz-9x
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 15:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbXLNOiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 09:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbXLNOiP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 09:38:15 -0500
Received: from jdl.com ([208.123.74.7]:56207 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbXLNOiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 09:38:14 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1J3Bg0-0004Ut-Ii; Fri, 14 Dec 2007 08:38:09 -0600
In-Reply-To: Your message of "Thu, 13 Dec 2007 22:03:55 PST."
             <7vejdpvmlw.fsf@gitster.siamese.dyndns.org> 
X-Spam-Score: -2.5 (--)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68310>

So, like, the other day Junio C Hamano mumbled:
> 
> I personally feel that calling "install-info" is a bit too distro-ish
> and should not be done in our Makefile vanilla build-and-install
> procedure.

Hmmm...  That's an interesting take on things
given the top of the INSTALL file:

		    Git installation

    Normally you can just do "make" followed by "make install", and that
    will install the git programs in your own ~/bin/ directory.  If you want
    to do a global install, you can do

	    $ make prefix=/usr all doc info ;# as yourself
	    # make prefix=/usr install install-doc install-info ;# as root

Granted, it's the first time I've actually tried
to install the docs on this (debian) machine too.
I've normally just read them straight out of the
doc directory. :-)

But I will have to agree with you on the problems
surrounding the One Install to Rule Them All (and
in the darkness bind9 them).

jdl
