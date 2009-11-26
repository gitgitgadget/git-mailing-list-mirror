From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH 8/8] Document that merge strategies can now take their own options
Date: Wed, 25 Nov 2009 21:24:00 -0500
Message-ID: <accf3a5caae4cd73dd6c46e0ddd46eb8f566ad1c.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com> <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com> <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com> <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com> <1ff0b2f7e3fae4cc6c7610c92711f33df9a3d07c.1259201377.git.apenwarr@gmail.com> <c78d4c177f470e0f2f64314321df12e1a59077bf.1259201377.git.apenwarr@gmail.com> <3acdc84af78453622df67b8c7ce6763bd316db4b.1259201377.git.apenwarr@gmail.com>
Cc: <gitster@pobox.com>, "Avery Pennarun" <apenwarr@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 03:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUKO-0004ry-1x
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbZKZCmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbZKZCmx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:53 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbZKZCmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:37 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
X-Language-Identified: TRUE
X-Brightmail-Tracker: AAAAAQAAA+k=
thread-index: AcpuQAhcJ889uxm+TWyDEbo6rIHd7g==
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Wed, 25 Nov 2009 21:27:43 -0500
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Received: (qmail 6927 invoked from network); 26 Nov 2009 02:27:38 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:27:38 -0000
Received: (qmail 6787 invoked from network); 26 Nov 2009 02:27:32 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:27:32 -0000
Received: (qmail 6631 invoked from network); 26 Nov 2009 02:27:25 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:27:25 -0000
Received: (qmail 5769 invoked from network); 26 Nov 2009 02:25:49 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:49 -0000
Received: (qmail 5719 invoked from network); 26 Nov 2009 02:25:47 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:47 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:22 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
In-Reply-To: <3acdc84af78453622df67b8c7ce6763bd316db4b.1259201377.git.apenwarr@gmail.com>
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
X-OriginalArrivalTime: 26 Nov 2009 02:27:43.0074 (UTC) FILETIME=[085CC420:01CA6E40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133762>

Also document the recently added -Xtheirs, -Xours and -Xsubtree[=path]
options to the merge-recursive strategy.

(Patch originally by Junio Hamano <gitster@pobox.com>.)

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 Documentation/merge-options.txt    |    4 ++++
 Documentation/merge-strategies.txt |   29 ++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index fec3394..95244d2 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -74,3 +74,7 @@ option can be used to override --squash.
 -v::
 --verbose::
 	Be verbose.
+
+-X<option>::
+	Pass merge strategy specific option through to the merge
+	strategy.
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 42910a3..360dd6f 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -1,6 +1,11 @@
 MERGE STRATEGIES
 ----------------
 
+The merge mechanism ('git-merge' and 'git-pull' commands) allows the
+backend 'merge strategies' to be chosen with `-s` option.  Some strategies
+can also take their own options, which can be passed by giving `-X<option>`
+arguments to 'git-merge' and/or 'git-pull'.
+
 resolve::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using a 3-way merge
@@ -20,6 +25,27 @@ recursive::
 	Additionally this can detect and handle merges involving
 	renames.  This is the default merge strategy when
 	pulling or merging one branch.
++
+The 'recursive' strategy can take the following options:
+
+ours;;
+	This option forces conflicting hunks to be auto-resolved cleanly by
+	favoring 'our' version.  Changes from the other tree that do not
+	conflict with our side are reflected to the merge result.
++
+This should not be confused with the 'ours' merge strategy, which does not
+even look at what the other tree contains at all.  That one discards everything
+the other tree did, declaring 'our' history contains all that happened in it.
+
+theirs;;
+	This is opposite of 'ours'.
+
+subtree[=path];;
+	This option is a more advanced form of 'subtree' strategy, where
+	the strategy makes a guess on how two trees must be shifted to
+	match with each other when merging.  Instead, the specified path
+	is prefixed (or stripped from the beginning) to make the shape of
+	two trees to match.
 
 octopus::
 	This resolves cases with more than two heads, but refuses to do
@@ -33,7 +59,8 @@ ours::
 	merge is always that of the current branch head, effectively
 	ignoring all changes from all other branches.  It is meant to
 	be used to supersede old development history of side
-	branches.
+	branches.  Note that this is different from the -Xours option to
+	the 'recursive' merge strategy.
 
 subtree::
 	This is a modified recursive strategy. When merging trees A and
-- 
1.6.6.rc0.62.gaccf
