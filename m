From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why's Git called Git ?
Date: Wed, 05 Jul 2006 21:33:33 +0200
Organization: At home
Message-ID: <e8h466$o4$1@sea.gmane.org>
References: <013001c69f04$ae4e2400$0200a8c0@amd2500> <Pine.LNX.4.64.0607032022050.12404@g5.osdl.org> <001001c6a06d$6e7b94b0$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jul 05 21:34:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyD8J-0005v7-GA
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 21:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWGETdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 15:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWGETdx
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 15:33:53 -0400
Received: from main.gmane.org ([80.91.229.2]:31433 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965002AbWGETdw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 15:33:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FyD81-0005sl-6l
	for git@vger.kernel.org; Wed, 05 Jul 2006 21:33:41 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 21:33:41 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 21:33:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23361>

Aaron Gray wrote:

> Anyway good going, I am glad Linux has an open source VCS again now.
> 
> I do not know how BitKeeper are going to fell knowing they have been 
> replaced by a Git :)
> 
> I am toying with using a VCS for a set of related projects, either CVS 
> because its well known, SubVersion for ease of use, or Git as it is new. 
> Lots to descide upon, any pointers would be appreciated.

CVS is showing it's age; mainly the fact that IIRC it began as a series of
scripts over RCS, file level version control system, extending version
control to sets of files, somewhat. Branching in CVS is serious PITA.
Renaming _with_ retaining full and correct history: forget about it.

Subversion is "better CVS": still centralized, CVS infernal branching
replaced by "cheap copy" branching. Well known, replaces CVS thorough OSS
projects.

Git, Mercurial, Monotone, Bazaar-NG, Darcs are new brand of distributed VCS.
I really like notion of branching in Git; but be warned about tracking and
not recording renames, and the need of explicit packing (the latter very
minor). Powerfull, perhaps too powerfull for newbie user: but that is what
Cogito is for (although now Git contains fairly large set of high-level
commands).

  http://git.or.cz/
  http://git.or.cz/gitwiki
  http://git.or.cz/gitwiki/Git
and "Other version control software" at
  http://git.or.cz/gitwiki/GitLinks

P.S. If you decide to use Git as VCS for your project, consider adding entry
about it on http://git.or.cz/gitwiki/GitProjects wiki page.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git (at FreeNode)
