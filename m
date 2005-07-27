From: Ryan Anderson <ryan@michonline.com>
Subject: Git 1.0 Synopis (Draft v2)
Date: Wed, 27 Jul 2005 06:01:23 -0400
Message-ID: <20050727100123.GH19290@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 27 12:05:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DximP-0003EL-9G
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 12:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVG0KEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 06:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVG0KBv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 06:01:51 -0400
Received: from mail.autoweb.net ([198.172.237.26]:41413 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262115AbVG0KBY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 06:01:24 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dxij6-00084o-Du
	for git@vger.kernel.org; Wed, 27 Jul 2005 06:01:24 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dxis6-0000uY-00
	for <git@vger.kernel.org>; Wed, 27 Jul 2005 06:10:42 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1Dxij5-0001DC-QL
	for git@vger.kernel.org; Wed, 27 Jul 2005 06:01:23 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[This is still a draft, but I think I incorporated the suggestons from
the last attempt.]

Source Code Management with Git

Git, sometimes called "global information tracker", is a "directory
content manager".  Git has been designed to handle absolutely massive
projects with speed and efficiency, and the release of the 2.6.12 and
(soon) the 2.6.13 version of the Linux kernel would indicate that it
does this task well.

Git falls into the category of distributed source code management tools,
similar to Arch or Darcs (or, in the commercial world, BitKeeper).  Every Git
working directory is a full-fledged repository with full revision tracking
capabilities, not dependent on network access to a central server.

Git uses the SHA1 hash algorithm to provide a content-addressable pseudo
filesystem, complete with its own version of fsck.
  o Speed of use, both for the project maintainer, and the end-users, is
    a key development principle.
  o The history is stored as a directed acyclic graph, making long-lived
    branches and repeated merging simple.
  o A collection of related projects are building on the core Git project,
    either to provide an easier to use interface on top (StGit, Cogito, qgit,
    gitk, gitweb), or to take some of the underlying concepts and reimplement
    them directly into another system (Arch 2.0, Darcs-git).
  o Two, interchangeable, on-disk formats are used:
    o An efficient, packed format that saves spaced and network
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
	git clone http://www.kernel.org/pub/scm/git/git.git/
	git clone rsync://rsync.kernel.org/pub/scm/git/git.git/
	(rsync is generally faster for an initial pull)

Git distributions contain a tutorial in the Documentation subdirectory.
Additionally, the Kernel-Hacker's Git Tutorial at
http://linux.yyz.us/git-howto.html may be useful.  (Thanks to Jeff Garzik for
that document)

Git development takes place on the Git mailing list.  To subscribe, send an
email with just "subscribe git" in the body to majordomo@vger.kernel.org.
Mailing list archives are available at http://marc.theaimsgroup.com/?l=git

Git results from the inspiration and frustration of Linus Torvalds, and
the enthusiastic help of over 300 participants on the development
mailing list.[1]  It is maintained by Junio C Hamano <junkio@cox.net>.

1 - Generated with the following, in a maildir folder:
        find . -type f | xargs grep -h "^From:" | perl -ne \
        'tr#A-Z#a-z#; m#<(.*)># && print $1,"\n";' | sort -u | wc -l

(This summary written by Ryan Anderson <ryan@michonline.com>.  Please bug him
with any corrections or complaints.)




-- 

Ryan Anderson
  sometimes Pug Majere
