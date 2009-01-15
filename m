From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Q] git rebase -i -p conflicts with squash
Date: Thu, 15 Jan 2009 01:38:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150137070.3586@pacific.mpi-cbg.de>
References: <85647ef50901140813r6e62ae53u1dbcd48cc472dbcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:38:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGFu-00064q-0N
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759153AbZAOAhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758072AbZAOAhQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:37:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:48260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755766AbZAOAhP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:37:15 -0500
Received: (qmail invoked by alias); 15 Jan 2009 00:37:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 15 Jan 2009 01:37:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TnMk7LDXTSFssFfML2R6znUX0/sg5yJNmjc36Hy
	7Km4LvyaYTZ5Uh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85647ef50901140813r6e62ae53u1dbcd48cc472dbcc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105743>

Hi,

On Wed, 14 Jan 2009, Constantine Plotnikov wrote:

> If I run git rebase --interactive with --preserve-merges option and 
> select "squash" for one of the commit, the rebase process fails with the 
> message "Refusing to squash a merge: 
> 5e775c536654640c173ba71a0af7e84bf8bc618a". However the neither commit 
> participating in the squash is a merge commit. Even more, there are no 
> merge commits in the repository at all.
> 
> From my limited understanding of squash operation, it should fail only 
> if one of squashed commits is a merge commit, but it should be possible 
> to squash non-merge commits without problem as it looks like quite safe 
> and local operation (and I might want to preserve merges that happened 
> after squashed commits). Is it the current behaviour a bug or a feature?

>From your description, it seems that you are hitting an ordering bug of 
rebase -i -p.

But without a reproduction recipe (preferably as a patch against our 
testsuite), I cannot tell.

Ciao,
Dscho
