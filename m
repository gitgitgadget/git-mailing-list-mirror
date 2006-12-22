From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git-svn throwing assertion on old svn tracking branch
Date: Fri, 22 Dec 2006 10:43:38 +0100
Message-ID: <20061222094337.GC9595@hermes>
References: <20061220235551.GA2974@hermes.lan.home.vilz.de> <20061221010520.GB3901@localdomain> <20061222013510.GA9595@hermes> <20061222021613.GB9595@hermes> <20061222083803.GD26800@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 10:43:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxgw4-0008GH-Ds
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 10:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946016AbWLVJnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 04:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946015AbWLVJnZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 04:43:25 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:1461 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946010AbWLVJnZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 04:43:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 066F83EE9;
	Fri, 22 Dec 2006 10:43:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fHQ7bft6y75; Fri, 22 Dec 2006 10:43:03 +0100 (CET)
Received: from localhost (dslb-088-066-037-196.pools.arcor-ip.net [88.66.37.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 533733EDC;
	Fri, 22 Dec 2006 10:43:03 +0100 (CET)
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20061222083803.GD26800@hand.yhbt.net>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35157>

On Fri, Dec 22, 2006 at 12:38:03AM -0800, Eric Wong wrote:
> Nicolas Vilz <niv@iaglans.de> wrote:
> > On Fri, Dec 22, 2006 at 02:35:10AM +0100, Nicolas Vilz wrote:
> > > On Wed, Dec 20, 2006 at 05:05:20PM -0800, Eric Wong wrote:
> > > > Nicolas Vilz <niv@iaglans.de> wrote:
> > [...]
> > > beneath there is svn, version 1.4.2 (r22196) ... on that repository is
> > > Subversion version 1.1.4 (r13838).
> > 
> > i should ammend, that the same error message comes, when i want to
> > dcommit something in this repository...
> 
> Weird, so you have the SVN:: libraries installed? (dcommit requires it).
> Is the repository you're tracking public?  If so, I'd like to have a
> look...
unfortunatelly, its not public...

I noticed, it is not the step of committing anything, but the step to
fetch the revisions in the svn tree. I had a workaround last night... I
used the documentation on Advanced Example: Tracking a Reorganized
Repository to reorganize my tree from broken old repository to
reorganized fresh tree that is working... that all because time was
running out this night and i had to work something.

I keep the old one as a souvenier... The problem lies somewhere there in
the old branch. The history is not lost here in any case.

I backuped my repository and pruned my tree as you suggested it... I
connected to that remote repository... and then the assertion came down
on me. Personally i can live with that reorganized repository. If you
are really keen on digging the error down to ground, i could try to
setup something.

Perhaps back were i worked on that repository, git-svn accessed a little
different from now....

If you are still interested in digging, I think about a private solution
for that.

Sincerly
Nicolas Vilz
