From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Distributing revisions to patches in a series
Date: Fri, 7 Sep 2007 12:04:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709071202570.28586@racer.site>
References: <Pine.LNX.4.64.0709062219320.13907@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITbdR-0000wa-58
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbXIGLEU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 07:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbXIGLEU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:04:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:41176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965163AbXIGLES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 07:04:18 -0400
Received: (qmail invoked by alias); 07 Sep 2007 11:04:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 07 Sep 2007 13:04:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+M42gXhDaMK8f77GgDlG/YEFHDZ8fYiO4ruuRalT
	SmlcWDL4QzYv7c
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709062219320.13907@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58024>

Hi,

On Thu, 6 Sep 2007, Daniel Barkalow wrote:

> I was wondering if anybody's got a good process for the following 
> situation: I've just rebased a series onto the new origin/next. In the 
> afterwards, I determined that some of the intermediate merges weren't 
> right (the patch to split bundle-handling out of builtin-bundle didn't 
> pick up fixes to builtin-bundle). I also found and fixed a warning added 
> by my series. I want to take these changes, split them into individual 
> hunks, and apply each hunk to the appropriate commit from the series 
> before that commit, generating a new series.
> 
> I know how to do it by figuring out where the hunk should go myself and 
> branching, fixing, and rebasing, but I was wondering if there was a 
> magic script to just do it. It seems like it should be an automatable 
> operation (take the last commit as a set of hunks, and walk back up the 
> history, leaving each one at the oldest commit to which it applies 
> cleanly; when all of the hunks are allocated, generate a new history by 
> amending commits).

Sounds like you want to read the new section "splitting commits" in 
git-rebase.txt ;-)

Hth,
Dscho
