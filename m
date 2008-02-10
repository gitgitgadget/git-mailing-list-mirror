From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 08:07:18 -0500
Message-ID: <20080210130718.GA1005@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net> <alpine.LSU.1.00.0802101219280.11591@racer.site> <20080210122321.GA31009@coredump.intra.peff.net> <alpine.LSU.1.00.0802101303140.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 14:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBuX-0002Rc-73
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 14:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbYBJNHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 08:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbYBJNHX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 08:07:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1343 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbYBJNHW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 08:07:22 -0500
Received: (qmail 27775 invoked by uid 111); 10 Feb 2008 13:07:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 10 Feb 2008 08:07:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2008 08:07:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802101303140.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73351>

On Sun, Feb 10, 2008 at 01:04:03PM +0000, Johannes Schindelin wrote:

> > IOW, I am not necessarily proposing to change the default for 
> > old-timers, but rather to allow differing behavior for "git push" 
> > without remote depending on a config variable. So different behavior for 
> > different people.
> 
> Hmm.  So that means that if an old-timer comes to help to a new-comer, 
> the old-timer will be surprised?

No, the old-timer will type what he means: "git push --matching origin"
or "git push origin refspec".

> You know I am a fan of consistency, so you know I cannot agree to your 
> suggestion.

I suspected you would say that. I agree that consistency has value, but
it can also get in the way when there really are two equally valid
approaches, and both should be available.

-Peff
