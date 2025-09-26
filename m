Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7F72602
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846491; cv=none; b=NCkcPJRshk8N4QLKF4l5JquBy4sF2ZkkDYTKQkZ8UhY1D1jbaZZCuZqm2SOqy+sGhUf+qROgqgJzLfJsYZqJ2dupJO1VABXsA5MxVSK7iiscsPGsAlQJ31cW73TkTAA+mFHmfPPacuh1zfgmyQq3B0/WVrMwyXSN4SoSXsWlnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846491; c=relaxed/simple;
	bh=r9igLev33E/rFIZLoLqK95+s67YdOBXtW1d5GkQlhEU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=blIXVR3mrbv1h2Ly+/Z/0gP5Wogv35W2hyFMegLg1+X/2jNYKpbFugxlwD7ILmUWS1zHXplvFtYs2B0Mzjbk0XR75GV2+tH1KYuX6yTZs3FXLx06fXwT/qKcXAsMg/3wI7IVOjifJNxFLig4FMFeYsmSU5G0C2N17WgT8r/KJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Z8HLNP/q; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Z8HLNP/q"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1wJhvu1ZI2D8r1wJjvBTFX; Fri, 26 Sep 2025 01:28:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758846487; bh=WSboGYkUBJRKdCv6z20dC/og+ihEkCmwH/00pt501pQ=;
	h=Date:To:Cc:From:Subject;
	b=Z8HLNP/qMDdY6bTfady83c8Q9dlZzXdIh0tO5KQwTP08TWqWpd0AyLEacQA/MsT3E
	 YnBrJ9BQJYjngxWITNbIuuOVvlDDk4F1zNcJvowNGXUNVchiFvHh5Jd6r4eTq/hpP2
	 M3sf8yR4NJ1NzOTtGj34vqOMUYTeo6HYL43wqR4nKl3lEjr5Mp3adrwCpBfdZv3Fwd
	 aPpa9judW2ht1ulm4kf48j3kbEfW8b16Ra96lxtf2PLPnXQ4qJr0HWGImcBCpr5PKU
	 FKYMyrWluE1F4VySSULedmQvMrI9XMYULU/CDZGfV4e+632OKoHVftO03o+9mQTKb3
	 w8bBEMyXZ9KzA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68d5de17
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=cm27Pg_UAAAA:8 a=EBOSESyhAAAA:8 a=Vg5F4PhgkVHSLG9jODYA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <875fb7a0-6dd9-412b-a34a-21758c339871@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 01:28:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 4/4] doc: commit-graph.adoc: fix up some formatting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBWgNemBDKheOgq/yTCV0EjKvRcKOekmp/L2PIrTwNN9l1K5kpOcvMr9cLJ8756URVW3FIy8vRO3yUXyycYIR9RHnPXifGn6PnqMW3WXs7lErMpT5iQ9
 KmDOEjBjHlcEsMsTzjsQLxhS5uV59kRCnXoWdaFhIM84FV2qL2YE4n6MN2QcY2ZTdv+YCNEz9EiGhrXE8H30Lcc+++0MpTWsIDw=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/technical/commit-graph.adoc | 34 +++++++++++------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/Documentation/technical/commit-graph.adoc b/Documentation/technical/commit-graph.adoc
index 2c26e95e51..15396f58ab 100644
--- a/Documentation/technical/commit-graph.adoc
+++ b/Documentation/technical/commit-graph.adoc
@@ -1,5 +1,4 @@
-Git Commit-Graph Design Notes
-=============================
+= Git Commit-Graph Design Notes
 
 Git walks the commit graph for many reasons, including:
 
@@ -39,6 +38,7 @@ A consumer may load the following info for a commit from the graph:
 Values 1-4 satisfy the requirements of parse_commit_gently().
 
 There are two definitions of generation number:
+
 1. Corrected committer dates (generation number v2)
 2. Topological levels (generation number v1)
 
@@ -122,8 +122,7 @@ can be stored in the commit-graph file using the 30 bits available
 to topological levels. This presents another case where a commit can
 have generation number equal to that of a parent.
 
-Design Details
---------------
+== Design Details
 
 - The commit-graph file is stored in a file named 'commit-graph' in the
   .git/objects/info directory. This could be stored in the info directory
@@ -149,8 +148,7 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
-Commit-Graphs Chains
---------------------
+== Commit-Graphs Chains
 
 Typically, repos grow with near-constant velocity (commits per day). Over time,
 the number of commits added by a fetch operation is much smaller than the
@@ -158,7 +156,7 @@ number of commits in the full history. By creating a "chain" of commit-graphs,
 we enable fast writes of new commit data without rewriting the entire commit
 history -- at least, most of the time.
 
-## File Layout
+=== File Layout
 
 A commit-graph chain uses multiple files, and we use a fixed naming convention
 to organize these files. Each commit-graph file has a name
@@ -170,11 +168,11 @@ hashes for the files in order from "lowest" to "highest".
 
 For example, if the `commit-graph-chain` file contains the lines
 
-```
+----
 	{hash0}
 	{hash1}
 	{hash2}
-```
+----
 
 then the commit-graph chain looks like the following diagram:
 
@@ -213,7 +211,7 @@ specifying the hashes of all files in the lower layers. In the above example,
 `graph-{hash1}.graph` contains `{hash0}` while `graph-{hash2}.graph` contains
 `{hash0}` and `{hash1}`.
 
-## Merging commit-graph files
+=== Merging commit-graph files
 
 If we only added a new commit-graph file on every write, we would run into a
 linear search problem through many commit-graph files.  Instead, we use a merge
@@ -257,14 +255,14 @@ lock-file.  When the file is flushed, we rename it to `graph-{hash3}`
 according to the computed `{hash3}`. Finally, we write the new chain data to
 `commit-graph-chain.lock`:
 
-```
+----
 	{hash3}
 	{hash0}
-```
+----
 
 We then close the lock-file.
 
-## Merge Strategy
+=== Merge Strategy
 
 When writing a set of commits that do not exist in the commit-graph stack of
 height N, we default to creating a new file at level N + 1. We then decide to
@@ -289,7 +287,7 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
 number of commits) could be extracted into config settings for full
 flexibility.
 
-## Handling Mixed Generation Number Chains
+=== Handling Mixed Generation Number Chains
 
 With the introduction of generation number v2 and generation data chunk, the
 following scenario is possible:
@@ -318,7 +316,7 @@ have corrected commit dates when written by compatible versions of Git. Thus,
 rewriting split commit-graph as a single file (`--split=replace`) creates a
 single layer with corrected commit dates.
 
-## Deleting graph-{hash} files
+=== Deleting graph-\{hash\} files
 
 After a new tip file is written, some `graph-{hash}` files may no longer
 be part of a chain. It is important to remove these files from disk, eventually.
@@ -333,7 +331,7 @@ files whose modified times are older than a given expiry window. This window
 defaults to zero, but can be changed using command-line arguments or a config
 setting.
 
-## Chains across multiple object directories
+=== Chains across multiple object directories
 
 In a repo with alternates, we look for the `commit-graph-chain` file starting
 in the local object directory and then in each alternate. The first file that
@@ -369,8 +367,8 @@ their custom environment:
     access to the new chain until its chain is updated to reference those files.
     (This may change in the future [5].)
 
-Related Links
--------------
+== Related Links
+
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
     Chromium work item for: Serialized Commit Graph
 
-- 
2.51.0
