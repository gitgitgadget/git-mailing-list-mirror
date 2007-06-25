From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Check for IO errors after running a command
Date: Mon, 25 Jun 2007 14:20:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706251413530.4059@racer.site>
References: <87abuq1z6f.fsf@rho.meyering.net> <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org>
 <7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 15:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2oVe-0000pM-1l
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 15:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbXFYNVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 09:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754422AbXFYNVI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 09:21:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:34743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754114AbXFYNVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 09:21:06 -0400
Received: (qmail invoked by alias); 25 Jun 2007 13:21:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 25 Jun 2007 15:21:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AltYo1IYALkjk1OicIqra5G1OUk+ZDZeNQisZGO
	2CCSHHamVJQwAc
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50892>

Hi Junio,

On Mon, 25 Jun 2007, Junio C Hamano wrote:

> I took the liberty of munging your two patches to follow your comments 
> above (it was a perfect guinea-pig opportunity for Johannes's "rebase 
> -i").

And? How was that experience?

I am actually quite pleased how it worked out in the end; I never 
understood the syntax of rebase, and stayed away from it for that reason. 
By reworking patch-series into rebase -i, I learnt it on the way, and find 
it actually quite useful.

One thing we might consider, however: when rebasing, the current branch 
gets updated at each step. Some might consider this a bug, and prefer 
rebase to work on a detached HEAD, and only update the branch at the end, 
so that <branchname>@{1} refers to the state _before_ rebase.

Thoughts?

Ciao,
Dscho
