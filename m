From: Ryan Anderson <ryan@michonline.com>
Subject: Git 1.0 Synopis (Draft v3
Date: Fri, 29 Jul 2005 04:29:41 -0400
Message-ID: <20050729082941.GD32263@mythryan2.michonline.com>
References: <20050727100123.GH19290@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 29 10:31:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQGj-00014F-9f
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 10:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVG2Iad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 04:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVG2Iaa
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 04:30:30 -0400
Received: from mail.autoweb.net ([198.172.237.26]:58545 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262463AbVG2I3m (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 04:29:42 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DyQFR-0003WU-NJ
	for git@vger.kernel.org; Fri, 29 Jul 2005 04:29:41 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DyQOo-0002hH-00
	for <git@vger.kernel.org>; Fri, 29 Jul 2005 04:39:22 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DyQFR-0000td-91
	for git@vger.kernel.org; Fri, 29 Jul 2005 04:29:41 -0400
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050727100123.GH19290@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Source Code Management with Git

"git" can mean anything, depending on your mood.

 - random three-letter combination that is pronounceable, and not
   actually used by any common UNIX command.  The fact that it is a
   mispronunciation of "get" may or may not be relevant.
 - stupid. contemptible and despicable. simple. Take your pick from the
   dictionary of slang.
 - "global information tracker": you're in a good mood, and it actually
   works for you. Angels sing, and a light suddenly fills the room. 
 - "goddamn idiotic truckload of sh*t": when it breaks

Git is a "directory content manager".  Git has been designed to handle
absolutely massive projects with speed and efficiency, and the release of the
2.6.12 and (soon) the 2.6.13 version of the Linux kernel would indicate that it
does this task well.

Git falls into the category of distributed source code management tools,
similar to Arch or Darcs (or, in the commercial world, BitKeeper).  Every Git
working directory is a full-fledged repository with full revision tracking
capabilities, not dependent on network access to a central server.

Git provides a content-addressable pseudo filesystem, complete with its own
version of fsck.

  o Speed of use, both for the project maintainer, and the end-users, is
    a key development principle.

  o The history is stored as a directed acyclic graph, making long-lived
    branches and repeated merging simple.

  o The core Git project considers itself to provide "plumbing" for other
     projects, as well as to serve to arbitrate for compatibility between them.
     The project built on top of the core Git are referred to as "porcelain".
     StGit, Cogito, qgit, gitk and gitweb are all building upon the core Git
     tools, and providing an easy to use interface to various pieces of
     functionality.

  o Some other projects have taken the concepts from the core Git project, and
    are either porting an existing toolset to use the Git tools, or
    reimplementing the concepts internally, to benefit from the performance
     improvements.  This includes both Arch 2.0, and Darcs-git.
  
  o Two, interchangeable, on-disk formats are used:
    o An efficient, packed format that saves space and network
      bandwidth.
    o An unpacked format, optimized for fast writes and incremental
      work.

To get a copy of Git:
	Daily snapshots are available at:
	http://www.codemonkey.org.uk/projects/git-snapshots/git/
	(Thanks to Dave Jones)

	Source tarballs and RPMs at:
	http://www.kernel.org/pub/software/scm/git/

	Deb packages at:
	<insert url here>

	Or via Git itself:
	git clone http://www.kernel.org/pub/scm/git/git.git/ <local directory>
	git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ <local directory>

	(rsync is generally faster for an initial clone, you can switch later
	by editing .git/branches/origin and changing the url)

To get the 'Porcelain' tools mentioned above:
	SCM Interface layers:
	cogito - http://www.kernel.org/pub/software/scm/cogito/
	StGIT - http://www.procode.org/stgit/

	History Visualization:
	gitk - http://ozlabs.org/~paulus/gitk/
	gitweb - http://www.kernel.org/pub/software/scm/gitweb/
	qgit - http://sourceforge.net/projects/qgit


Git distributions contain a tutorial in the Documentation subdirectory.
Additionally, the Kernel-Hacker's Git Tutorial at
http://linux.yyz.us/git-howto.html may be useful.  (Thanks to Jeff Garzik for
that document)

Git development takes place on the Git mailing list.  To subscribe, send an
email with just "subscribe git" in the body to majordomo@vger.kernel.org.
Mailing list archives are available at http://marc.theaimsgroup.com/?l=git

(This summary written by Ryan Anderson <ryan@michonline.com>.  Please bug him
with any corrections or complaints.)
