From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 07:23:21 -0500
Message-ID: <20080210122321.GA31009@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net> <alpine.LSU.1.00.0802101219280.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:24:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBE6-0000XT-VU
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850AbYBJMXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbYBJMXZ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:23:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2135 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756850AbYBJMXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:23:24 -0500
Received: (qmail 27336 invoked by uid 111); 10 Feb 2008 12:23:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 10 Feb 2008 07:23:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2008 07:23:21 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802101219280.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73345>

On Sun, Feb 10, 2008 at 12:20:23PM +0000, Johannes Schindelin wrote:

> > I am still not convinced that an option to change the default behavior 
> > is unreasonable. Yes, it means that "git push" will do different things 
> > depending on your confi$g. But "git push" is a _shorthand_, and if you 
> > want to say things definitely, then say them: "git push --matching 
> > origin" or "git push HEAD" (assuming that a "--matching" option would 
> > exist to specify what is now the default behavior).
> 
> Well, I am not completely opposed to changing the default behaviour, be 
> that showing the synopsis or pushing HEAD to origin.
> 
> But _do_ give old-timers some time to adjust, _if_ you want to change the 
> default behaviour.

Sorry, I should have been more clear. By "default" I mean "what happens
when you type "git push" not "the behavior with no config options set."

IOW, I am not necessarily proposing to change the default for
old-timers, but rather to allow differing behavior for "git push"
without remote depending on a config variable. So different behavior for
different people.

-Peff
