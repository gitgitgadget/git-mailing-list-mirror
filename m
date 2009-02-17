From: Jeff King <peff@peff.net>
Subject: Re: send-email sending shallow threads by default
Date: Tue, 17 Feb 2009 14:28:55 -0500
Message-ID: <20090217192855.GB15625@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net> <mj+md-20090216.103512.5791.nikam@ucw.cz> <499A769B.2080308@op5.se> <mj+md-20090217.090514.32275.nikam@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Mares <mj@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:30:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZVeN-0004Ne-6D
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 20:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbZBQT26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 14:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbZBQT25
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 14:28:57 -0500
Received: from peff.net ([208.65.91.99]:47558 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZBQT25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 14:28:57 -0500
Received: (qmail 31452 invoked by uid 107); 17 Feb 2009 19:29:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Feb 2009 14:29:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2009 14:28:55 -0500
Content-Disposition: inline
In-Reply-To: <mj+md-20090217.090514.32275.nikam@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110443>

On Tue, Feb 17, 2009 at 10:06:18AM +0100, Martin Mares wrote:

> > There's no need to have the date field be set to the time the mails
> > were actually sent though. AFAIR, they get the AUTHOR_DATE now, and
> > I doubt more than one commit can be authored every second.
> 
> Is it really so?  Last time I have used git send-email, they got the
> current date. It was in Git 1.5.5, though, so it is possible that it
> has changed since then.

send-email does write a new date header. Which is actually desirable,
IMHO, because otherwise rebased patches would get sent with their
original date, which might very well long in the past (and not only is
that confusing, but it would probably trip spam filters).

-Peff
