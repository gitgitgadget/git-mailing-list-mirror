From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 5 Jun 2008 15:54:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051548140.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 16:57:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Gtg-0005jl-F0
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 16:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbYFEO4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 10:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbYFEO4F
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 10:56:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:51696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753089AbYFEO4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 10:56:03 -0400
Received: (qmail invoked by alias); 05 Jun 2008 14:56:01 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 05 Jun 2008 16:56:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OfYBvFNXOZb/GHMPKL+1Q42bPI+HYxjZnKRpuS+
	VfD1PtHJQi1T51
X-X-Sender: gene099@racer
In-Reply-To: <4847F49F.8090004@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83938>

Hi,

On Thu, 5 Jun 2008, Johannes Sixt wrote:

> > Now, if you say they are _ignored_, would that not imply in plain 
> > English that they are left unchanged (in limbo, because those two 
> > types of numbers contradict each other)?
> 
> That you *internally* rewrite those numbers and then do *not* ignore 
> them is totally pointless for the user. It's an implementation detail. 
> The user doesn't see what is going on nor should he care. From the 
> user's perspective, the hunk header line counts are _ignored_ (because 
> if they were not ignored, then there would be an error message in the 
> contradicting case).
> 
> > Okay, how about shikebedding this to --adjust-line-counts?
> 
> From the user's perspective, nothing is "adjusted"; the hunk header line 
> counts are ... you guess it ... *ignored*.

Oh... I start to see what you mean.  It's just that for me, the line 
counts are the actual line counts, not what is recorded in the hunk 
header.

In any case, I really do not feel strongly about it, since I do not want 
to use it, except with git add -e.  Which I really grew fond of in these 
last hours ;-)

So how about --ignore-hunk-headers?  I think this is much more 
descriptive, and catches your complaint, IMHO.

Ciao,
Dscho
