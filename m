From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] nbgit 0.1
Date: Wed, 10 Sep 2008 23:54:30 +0200
Message-ID: <20080910215430.GA24972@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: nbgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Sep 10 23:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdXf4-0007qm-RG
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 23:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbYIJVyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 17:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbYIJVyf
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 17:54:35 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:33783 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbYIJVyf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 17:54:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 662A919BC06;
	Wed, 10 Sep 2008 23:54:33 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26984-15; Wed, 10 Sep 2008 23:54:31 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id EB9F919BBAE;
	Wed, 10 Sep 2008 23:54:30 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A00BC6DF823; Wed, 10 Sep 2008 23:54:19 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id D80CD1A4001; Wed, 10 Sep 2008 23:54:30 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95560>

Hello,

Alexander Coles and I are very pleased to announce the first release of
nbgit, a git module for NetBeans. It uses the JGit library to interact
with Git repositories, which means that it should be as cross-platform
as it can get. Furthermore, both NetBeans 6.1 and 6.5beta should be
supported, the last one only slightly tested though.

The project is still in an early development phase and many features are
currently missing. However, nbgit 0.1 supports the most basic features
of a NetBeans versioning module. This includes showing annotations for
files and directories, viewing the status of tracked files, browsing
differences (both in diff view and in the editor), committing, and more
(see full list below).

Interested and *brave* people are encouraged to take it for a spin and
report first impressions, problems, or hurrahs in the nbgit forum or the
issue tracker on the Google Code project page.

Some useful resources
---------------------

 Homepage:      http://nbgit.org/
 Project:	http://nbgit.googlecode.com/
 Forum:		http://groups.google.com/group/nbgit
 Downloads:     http://code.google.com/p/nbgit/downloads/list
 Gitfeed:       git://github.com/myabc/nbgit.git
 Gitweb:        http://github.com/myabc/nbgit/commits/master
                http://repo.or.cz/w/nbgit.git (mirrored)

Changes in this release
-----------------------

New features:

 - init: Create a new git repository.
 - status: List the status of changed files.
 - diff: View changes to files (side-by-side).
 - commit: Commit a selected range of files.
 - log: Search and view revisions.
 - update: Revert individual file changes.
 - properties: Change repository specific options (i.e. user.name and
   user.email).
 - custom: User defined commands (e.g. to open gitk). (issue 16)

Resolved issues:

 - Prefill the history summary view when opened. (issue 5)
 - Optionally insert Signed-off-by line in commit messages. (issue 7)
 - Reorder class path extensions to allow nbgit to be opened in NetBeans
   6.5beta. (issue 14)

-- 
Jonas Fonseca
