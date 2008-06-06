From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Fri, 6 Jun 2008 15:31:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061528270.1783@racer>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net> <200806010241.51464.trast@student.ethz.ch> <20080605014618.GA27381@sigill.intra.peff.net> <7vprqw2t64.fsf@gitster.siamese.dyndns.org>
 <20080605085605.GA16624@sigill.intra.peff.net> <alpine.DEB.1.00.0806051126060.21190@racer> <20080606051026.GA18257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:34:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4d0y-0001N5-81
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbYFFOdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 10:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756579AbYFFOdG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 10:33:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:34046 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755925AbYFFOdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 10:33:03 -0400
Received: (qmail invoked by alias); 06 Jun 2008 14:33:02 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 06 Jun 2008 16:33:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HKFMClfHHBPOF6DEJKU/4j7Z+UYoxwmdYRqv5QQ
	hLlBkrB31TgPhF
X-X-Sender: gene099@racer
In-Reply-To: <20080606051026.GA18257@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84076>

Hi,

On Fri, 6 Jun 2008, Jeff King wrote:

> On Thu, Jun 05, 2008 at 11:28:53AM +0100, Johannes Schindelin wrote:
> 
> > We have a tradition of giving the users plenty of rope.
> > 
> > And I actually like having the power at my finger tips.  You would not 
> > believe how I enjoyed using "git add -e" to commit the final version of 
> > that very patch.
> 
> I looked at your patch, and here are my complaints (versus what Thomas
> has been working on):
> 
>   1. You edit the whole diff, not just a hunk. Actually, I think this is
>      probably not a big deal, as any decent editor lets you find the
>      spot you're looking for pretty trivially.

Actually, this is exactly what I wanted.  I positively _hate_ all the key 
presses I have to go through until I am finally where I want to be.  I 
cannot just search for a term and be done with it.  Reminds me of 
Windows-like dialog based configurations.

>   2. It's not integrated into the git-add--interactive loop at all. That
>      is, I don't start out saying "I want to edit this diff." I look at
>      the diff while staging with "git add -p" and say "Oops, I need to
>      edit this hunk." So I think it is better implemented as an "e"
>      option in the hunk adding loop, with "git add -e" as a shortcut.
>      Or maybe there is simply room for both (and "git add -e", rather
>      than being a shortcut, just means "do this on the _whole_ file").

This is very much on purpose.  I do not like "git add -i" at all.  It 
limits my work unduly.  That's why I tried to change the hunk editing in 
git-gui once upon a time, but I never got round to fix that, and it does 
not work well with ssh either.

So no, I do not want to use that perl script with that menu.  I want to 
have the raw diff in a raw editor, where I can change the things I need to 
change.

Ciao,
Dscho
