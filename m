From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Update packedGit config option documentation.
Date: Sat, 30 Dec 2006 22:13:43 -0500
Message-ID: <20061231031343.GB5620@spearce.org>
References: <298445c23601229930799536790f548b0572a92b.1167534738.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 04:13:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0r8z-0005E8-Ef
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 04:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWLaDNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 22:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbWLaDNr
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 22:13:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40747 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbWLaDNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 22:13:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0r8e-0003Y3-NM; Sat, 30 Dec 2006 22:13:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 57E7D20FB65; Sat, 30 Dec 2006 22:13:43 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <298445c23601229930799536790f548b0572a92b.1167534738.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35661>

Corrected minor typos and documented the new k/m/g suffix for
core.packedGitWindowSize and core.packedGitLimit.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 For sp/mmap.  Replaces my prior patch in the same area.

 Documentation/config.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d71653d..8f41fcf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -123,21 +123,25 @@ core.packedGitWindowSize::
 	single mapping operation.  Larger window sizes may allow
 	your system to process a smaller number of large pack files
 	more quickly.  Smaller window sizes will negatively affect
-	performance due to increased calls to the opreating system's
+	performance due to increased calls to the operating system's
 	memory manager, but may improve performance when accessing
 	a large number of large pack files.  Default is 32 MiB,
 	which should be reasonable for all users/operating systems.
 	You probably do not need to adjust this value.
 
+	Common unit suffixes of 'k', 'm', or 'g' are supported.
+
 core.packedGitLimit::
 	Maximum number of bytes to map simultaneously into memory
 	from pack files.  If Git needs to access more than this many
 	bytes at once to complete an operation it will unmap existing
 	regions to reclaim virtual address space within the process.
 	Default is 256 MiB, which should be reasonable for all
-	users/operating systems, except on largest Git projects.
+	users/operating systems, except on the largest projects.
 	You probably do not need to adjust this value.
 
+	Common unit suffixes of 'k', 'm', or 'g' are supported.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
-- 
1.5.0.rc0.g6bb1
