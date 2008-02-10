From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 05:17:56 -0500
Message-ID: <20080210101756.GB26568@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 11:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO9Ga-0002eo-Vp
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 11:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbYBJKR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 05:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbYBJKR7
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 05:17:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3979 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbYBJKR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 05:17:58 -0500
Received: (qmail 25747 invoked by uid 111); 10 Feb 2008 10:17:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 10 Feb 2008 05:17:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2008 05:17:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802100213330.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73330>

On Sun, Feb 10, 2008 at 02:15:50AM +0000, Johannes Schindelin wrote:

> I'm no longer that sure.  It seems that quite a lot of people do not read 
> manuals, and have no clue what they are doing when they just try
> 
> 	$ git push
> 
> to see what the synopsis is.
> 
> If there are enough of those people out there, we might want to change our 
> default action to "-h".
> 
> Yes, that hurts old-timers.  Yes, it's not a perfect world.  No, I don't 
> want to bend over for just a few people.

I am still not convinced that an option to change the default behavior
is unreasonable. Yes, it means that "git push" will do different things
depending on your confi$g. But "git push" is a _shorthand_, and if you
want to say things definitely, then say them: "git push --matching
origin" or "git push HEAD" (assuming that a "--matching" option would
exist to specify what is now the default behavior).

-Peff
