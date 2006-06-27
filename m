From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of
 some adhocery
Date: Tue, 27 Jun 2006 12:54:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606271251440.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com> 
 <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com> 
 <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <44A06A8D.7080202@catalyst.net.nz>  <Pine.LNX.4.63.0606271016450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606270252p2beac88bo3cf7aa8d3845450c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 27 12:54:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvBDR-0002Kr-Nh
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933074AbWF0Kyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 06:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWF0Kym
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:54:42 -0400
Received: from mail.gmx.net ([213.165.64.21]:404 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933074AbWF0Kym (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 06:54:42 -0400
Received: (qmail invoked by alias); 27 Jun 2006 10:54:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 27 Jun 2006 12:54:40 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606270252p2beac88bo3cf7aa8d3845450c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22729>

Hi,

On Tue, 27 Jun 2006, Martin Langhoff wrote:

> On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > I just cloned your repo, and as far as I can tell, the latest commit is on
> > June 23rd. So your numbers should be the same as mine. But not all are.
> 
> Taht repo is on a machine at work, but it's possible that I've cherry
> picked a new commit onto master that isn't on the publc repo yet.

I hoped that much.

> > (Did not test here, since I do not have an old git-format-patch.sh 
> > handy, and am too lazy to get the last version from my git repo.)
> 
> I think I did something like
> 
>  git-cat-file blob v1.3.3:git-format-patch.sh > git-format-patch.sh
>  chmod ugo+x git-format-patch.sh

Yes, I am lazy.

> > But anyway, looking at your numbers I take it that the new format-patch
> > with --ignore-if-in-upstream has the same output as the old format-patch,
> > right?
> 
> It does, but it may be "right" even though it's not realising that
> some of the patches were cherry picked. git-cherry doesn't either. So
> that algorythm isn't so hot in this case :-/

What do you mean? Is the patch-id of the cherry-picked different? (If 
there was a conflict which was manually resolved, I think there is no way 
we can detect that that patch was cherry-picked, but if it applied 
cleanly, the patch-id should be equal both in upstream and downstream.)

Ciao,
Dscho
