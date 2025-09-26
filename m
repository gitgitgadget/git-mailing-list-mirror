Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB768DDA9
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846379; cv=none; b=YQFEpJEiSCaPtBTzhjbVVs0V1wB5cTtwf5DrKC9DzcWzZvQmFkwMDxX7W7fMOlKecAEaElxig478np7dqlR9B9fSlTijRHYeR+04XFyq9GFe7k+pOfcOX/oGo6trLq4ngfTKx0BkYBDlPAxfpauqtyKD7sCSXIoDxzmTALFm+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846379; c=relaxed/simple;
	bh=Hy+2TBm8ZG+iWBnAszLkQfGa4GbGTHAkmxGIRVXyHcc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iEhxcKPhqPG8ZdzvgYpxz/0O77c9PBV+TFjvVLvxhAhqTJS5xPBsLO8eBT9M2Cr/K9t+n5p/TfqG1Vgf7lCSqWhzYxQTS3r4X64t4vtnmnufmyfDm4KH2UIcKS+13P80GUA9bqTL4LUZnS9+JW9ZQgTqsoUT84dwCvj3lBDNJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=T7CoKeh5; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="T7CoKeh5"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1wHuvu19t2D8r1wHvvBSwV; Fri, 26 Sep 2025 01:26:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758846375; bh=41qYSr/u8/BF8huB8WU3pC10eaVS6vhfkifXZEtYM08=;
	h=Date:To:Cc:From:Subject;
	b=T7CoKeh5b86ELGuTV56vg3qXfGsgSimVT0nE1htoMGDi9cJvkcduUKpTawkkuRK/o
	 izBCACkuZM8tEEW6nkMKAHjZVjCY13B9fWx/5gEVDLZ4WUI9P8zn2AzNkZIWQKdHip
	 LvtRAiGS+/rqakhiQ8/yQXKJHrBPs4hY5h183palDCiOZcRzUoCltqw+eAkLGoK1PW
	 AL619DBRSdAEGayKWPDR+/mRzYwPgYNKpf4CxfbZav3oquZ+n0NIX0n5Kvb/L+mgIL
	 sFJrCjLmujkpix+B4Jej5rfkl+Zfcdt4Ff/2jPbkc+BnWCHUb6GnjkTWedyX2XjIdo
	 CrKvBinzEM93A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68d5dda7
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8
 a=EpNwF9wgQfMGozLllNgA:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <19964f5e-f553-4eda-8a62-7d0aa3017657@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 01:26:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 3/4] doc: sparse-checkout.adoc: fix asciidoc warnings
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH0mHrn811fcMdaGLb/6/6JDRsQt8WaxgV6aWS5o7dVrk6wmP7qy2Cq+//zOD6HBVDebpIwRvYekRMTQCi8VnFbnnIyoNqcp2pNmr0hHT8xkGtNTp/is
 yDp+/Ayl3EM9wLc8ce3z+Y/+ApcaBnKdnYpSFkmTW+I8NFFp8C6HtF76D2Um87jeJVa2WNd2nveqhlmunxXf9U46nv73X3QvItI=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/technical/sparse-checkout.adoc | 38 ++++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/technical/sparse-checkout.adoc b/Documentation/technical/sparse-checkout.adoc
index 0f750ef3e3..0701c0f90d 100644
--- a/Documentation/technical/sparse-checkout.adoc
+++ b/Documentation/technical/sparse-checkout.adoc
@@ -14,7 +14,7 @@ Table of contents:
   * Reference Emails
 
 
-=== Terminology ===
+== Terminology ==
 
 cone mode: one of two modes for specifying the desired subset of files
 	in a sparse-checkout.  In cone-mode, the user specifies
@@ -92,7 +92,7 @@ vivifying: When a command restores a tracked file to the working tree (and
 	file), this is referred to as "vivifying" the file.
 
 
-=== Purpose of sparse-checkouts ===
+== Purpose of sparse-checkouts ==
 
 sparse-checkouts exist to allow users to work with a subset of their
 files.
@@ -255,7 +255,7 @@ will perceive the checkout as dense, and commands should thus behave as if
 all files are present.
 
 
-=== Usecases of primary concern ===
+== Usecases of primary concern ==
 
 Most of the rest of this document will focus on Behavior A and Behavior
 B.  Some notes about the other two cases and why we are not focusing on
@@ -300,7 +300,7 @@ Behavior C do not assume they are part of the Behavior B camp and propose
 patches that break things for the real Behavior B folks.
 
 
-=== Oversimplified mental models ===
+== Oversimplified mental models ==
 
 An oversimplification of the differences in the above behaviors is:
 
@@ -313,7 +313,7 @@ An oversimplification of the differences in the above behaviors is:
 	      they can later lazily be populated instead.
 
 
-=== Desired behavior ===
+== Desired behavior ==
 
 As noted previously, despite the simple idea of just working with a subset
 of files, there are a range of different behavioral changes that need to be
@@ -542,7 +542,7 @@ understanding these differences can be beneficial.
   * gitk?
 
 
-=== Behavior classes ===
+== Behavior classes ==
 
 From the above there are a few classes of behavior:
 
@@ -609,7 +609,7 @@ From the above there are a few classes of behavior:
     specification.
 
 
-=== Subcommand-dependent defaults ===
+== Subcommand-dependent defaults ==
 
 Note that we have different defaults depending on the command for the
 desired behavior :
@@ -749,7 +749,7 @@ desired behavior :
     implemented.
 
 
-=== Sparse specification vs. sparsity patterns ===
+== Sparse specification vs. sparsity patterns ==
 
 In a well-behaved situation, the sparse specification is given directly
 by the $GIT_DIR/info/sparse-checkout file.  However, it can transiently
@@ -821,7 +821,7 @@ under behavior B index operations are lumped with history and tend to
 operate full-tree.
 
 
-=== Implementation Questions ===
+== Implementation Questions ==
 
   * Do the options --scope={sparse,all} sound good to others?  Are there better
     options?
@@ -892,7 +892,7 @@ operate full-tree.
     is seamless for them.
 
 
-=== Implementation Goals/Plans ===
+== Implementation Goals/Plans ==
 
  * Get buy-in on this document in general.
 
@@ -920,15 +920,15 @@ operate full-tree.
      commands.  IMPORTANT: make sure diff machinery changes don't mess with
      format-patch, fast-export, etc.
 
-=== Known bugs ===
+== Known bugs ==
 
 This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
 been working on it.
 
-0. Behavior A is not well supported in Git.  (Behavior B didn't used to
+1. Behavior A is not well supported in Git.  (Behavior B didn't used to
    be either, but was the easier of the two to implement.)
 
-1. am and apply:
+2. am and apply:
 
    apply, without `--index` or `--cached`, relies on files being present
    in the working copy, and also writes to them unconditionally.  As
@@ -948,7 +948,7 @@ been working on it.
    files and then complain that those vivified files would be
    overwritten by merge.
 
-2. reset --hard:
+3. reset --hard:
 
    reset --hard provides confusing error message (works correctly, but
    misleads the user into believing it didn't):
@@ -971,13 +971,13 @@ been working on it.
     `git reset --hard` DID remove addme from the index and the working tree, contrary
     to the error message, but in line with how reset --hard should behave.
 
-3. read-tree
+4. read-tree
 
    `read-tree` doesn't apply the 'SKIP_WORKTREE' bit to *any* of the
    entries it reads into the index, resulting in all your files suddenly
    appearing to be "deleted".
 
-4. Checkout, restore:
+5. Checkout, restore:
 
    These command do not handle path & revision arguments appropriately:
 
@@ -1030,7 +1030,7 @@ been working on it.
     S tracked
     H tracked-but-maybe-skipped
 
-5. checkout and restore --staged, continued:
+6. checkout and restore --staged, continued:
 
    These commands do not correctly scope operations to the sparse
    specification, and make it worse by not setting important SKIP_WORKTREE
@@ -1046,11 +1046,11 @@ been working on it.
    the sparse specification, but then it will be important to set the
    SKIP_WORKTREE bits appropriately.
 
-6. Performance issues; see:
+7. Performance issues; see:
     https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
 
 
-=== Reference Emails ===
+== Reference Emails ==
 
 Emails that detail various bugs we've had in sparse-checkout:
 
-- 
2.51.0
