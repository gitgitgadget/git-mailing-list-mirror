Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5252DF139
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645202; cv=none; b=HLK8EK3qmAaiVJLwLKKf5eZbIxYYY3kzfOQcN4rPW0z4bfGfMvcrVzLRitfg+h97z7N3dw+aYIcSxgKm2jt9Mraw8JzW2MF52YnP4H5qSjrOV0knkxRIAxEOEYqzsK2kvPqsiFqCIJP6G5DfS2uQc90F5sOPgrFS3i6vzG9vAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645202; c=relaxed/simple;
	bh=22YUdpQlLh/AJ3CGydnShjo1zXQ/t3igahHOsYj6pAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POugRNeMc6M53EX0e61KkmLpygpFoYAZsmKDCTov7RDI87l9s5XQkJDILi+rWwCTUYa/xMc06FPTaByQmu58T6nx1GRXN4mtkFUbhq6O5Qf+iPtXvnqrfVbReqeSwqJUxHScK/gG9zzJCJ9gRCBE//o69DIF+vUcwpyKv/GRMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=m46knVeU; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="m46knVeU"
Received: from inspiron-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id 9UBovzPFx9u4D9UCJvvPbJ; Thu, 16 Oct 2025 21:03:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1760645019; bh=d67ZN9WC1jm9d7b7CukkiMl9nTLGwP+sH3x93Vx4xdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m46knVeU+jZF9DMZGpw3cmCT8pFdQi+irX4uWjgio6Os0bRqj9+u1gZ60Cppv8aM2
	 iv+q6ZQux03vjB1wP8bsTDTmIJ18UjzuCcFHFnly4h67AW4Lks0E1s+O2/VC2QvJtF
	 BPBi+mMmFquygPB0xRe0teR+yHC5HV+tiYP49n1fYTZRnz7P9vxygDVV53OgkRAyT4
	 pTCcQQHCVV9t4oKPSBYn0J44hsjRInkOD5YdbKZoMffd7yFqVlvbND/qWAkOTh/5Vt
	 mBTMgER3rP8ZN7A2B5NAlJIag5FOyXjFgRROPhwFEAF7YElBj5NRmRG5Y5KqIoZLUX
	 sgXUR+kf/SadA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UKJ+Hzfy c=1 sm=1 tr=0 ts=68f14f9b
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=bdAdcbO9dCHdLQEpdRsA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 3/4] doc: commit-graph.adoc: fix up some formatting
Date: Thu, 16 Oct 2025 21:03:00 +0100
Message-ID: <20251016200301.1595204-4-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016200301.1595204-1-ramsay@ramsayjones.plus.com>
References: <1a72434f-7935-4d0c-868f-03bd24601d4d@ramsayjones.plus.com>
 <20251016200301.1595204-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO9F9d3Q3TsXtQa1UaFwzsogbg/WurLG7WRHOKX0cwvCXWOlKh+apMQhIG7uiYBy7PHw8Zq8DHx/CztnYQwJJPdLiMLNAWV1RT/x52GgkUlTP+GaarZb
 Zud7/7hUxGSY87BuG9uPo3HVKWklk3PJgHeVjUP7DSWt+vrE72p5kyAGyCJ32Rgkey7QVB00hJnFtURDQKzG7unl0qeL7fT3cKg=

The formatting markup syntax used in this document (markdown?) is not
interpreted correctly by asciidoc or asciidoctor. The main problem is
the use of a '## ' prefix markup for some sub-headings, along with the
use of '```' code markup and some missing literal blocks.

In order to improve the (html) document formatting:

  - replace the '## ' prefix sub-title syntax with the '~~' underlining
    syntax for the relevant sub-headings.
  - replace the '```' code markup, which causes asciidoc(tor) to simply
    remove the marked up text, with a literal block '----' markup.
  - the second ascii diagram, in the 'Merging commit-graph files'
    section, is not rendered correctly by asciidoctor (asciidoc is fine)
    so enclose it in a '....' block.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/technical/commit-graph.adoc | 29 +++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/commit-graph.adoc b/Documentation/technical/commit-graph.adoc
index 2c26e95e51..a259d1567b 100644
--- a/Documentation/technical/commit-graph.adoc
+++ b/Documentation/technical/commit-graph.adoc
@@ -39,6 +39,7 @@ A consumer may load the following info for a commit from the graph:
 Values 1-4 satisfy the requirements of parse_commit_gently().
 
 There are two definitions of generation number:
+
 1. Corrected committer dates (generation number v2)
 2. Topological levels (generation number v1)
 
@@ -158,7 +159,8 @@ number of commits in the full history. By creating a "chain" of commit-graphs,
 we enable fast writes of new commit data without rewriting the entire commit
 history -- at least, most of the time.
 
-## File Layout
+File Layout
+~~~~~~~~~~~
 
 A commit-graph chain uses multiple files, and we use a fixed naming convention
 to organize these files. Each commit-graph file has a name
@@ -170,11 +172,11 @@ hashes for the files in order from "lowest" to "highest".
 
 For example, if the `commit-graph-chain` file contains the lines
 
-```
+----
 	{hash0}
 	{hash1}
 	{hash2}
-```
+----
 
 then the commit-graph chain looks like the following diagram:
 
@@ -213,7 +215,8 @@ specifying the hashes of all files in the lower layers. In the above example,
 `graph-{hash1}.graph` contains `{hash0}` while `graph-{hash2}.graph` contains
 `{hash0}` and `{hash1}`.
 
-## Merging commit-graph files
+Merging commit-graph files
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If we only added a new commit-graph file on every write, we would run into a
 linear search problem through many commit-graph files.  Instead, we use a merge
@@ -225,6 +228,7 @@ is determined by the merge strategy that the files should collapse to
 the commits in `graph-{hash1}` should be combined into a new `graph-{hash3}`
 file.
 
+....
 			    +---------------------+
 			    |                     |
 			    |    (new commits)    |
@@ -250,6 +254,7 @@ file.
  |                       |
  |                       |
  +-----------------------+
+....
 
 During this process, the commits to write are combined, sorted and we write the
 contents to a temporary file, all while holding a `commit-graph-chain.lock`
@@ -257,14 +262,15 @@ lock-file.  When the file is flushed, we rename it to `graph-{hash3}`
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
+Merge Strategy
+~~~~~~~~~~~~~~
 
 When writing a set of commits that do not exist in the commit-graph stack of
 height N, we default to creating a new file at level N + 1. We then decide to
@@ -289,7 +295,8 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
 number of commits) could be extracted into config settings for full
 flexibility.
 
-## Handling Mixed Generation Number Chains
+Handling Mixed Generation Number Chains
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 With the introduction of generation number v2 and generation data chunk, the
 following scenario is possible:
@@ -318,7 +325,8 @@ have corrected commit dates when written by compatible versions of Git. Thus,
 rewriting split commit-graph as a single file (`--split=replace`) creates a
 single layer with corrected commit dates.
 
-## Deleting graph-{hash} files
+Deleting graph-\{hash\} files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 After a new tip file is written, some `graph-{hash}` files may no longer
 be part of a chain. It is important to remove these files from disk, eventually.
@@ -333,7 +341,8 @@ files whose modified times are older than a given expiry window. This window
 defaults to zero, but can be changed using command-line arguments or a config
 setting.
 
-## Chains across multiple object directories
+Chains across multiple object directories
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In a repo with alternates, we look for the `commit-graph-chain` file starting
 in the local object directory and then in each alternate. The first file that
-- 
2.51.0

