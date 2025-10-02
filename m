Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC527B35D
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443216; cv=none; b=jLl5VUmfOFHK0UhIvOhOQs2HycZFILLYySiJCQii6Dj7amxUjWf9bMIi1vAXVq3n3Ut3rxfv+cLzSfLVP2Bhdz8PXuo5ZGI8ANjvgcJYrh4KGhzA0prxYeUpnh2OP2vXH7CAEGvBdN74/hNmTj4e5yxrTtrqIFvNGO6qee6TH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443216; c=relaxed/simple;
	bh=22YUdpQlLh/AJ3CGydnShjo1zXQ/t3igahHOsYj6pAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdViufGSP0w42XXB4LDnx33jE5GjkF2QBjfo76AW2hWPyBTCie/FQdOFrsSV0a2aOHgpWT/BLVPehV8P7AW7bcTQCBkdxg0Gim+m68zrOUWdjjTBnZN9V2ZVAWCuq4TLkTo9/dP8PcXzWwu2deRtmQ5LEt7JS6qhWVWA1Qa5KF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=qRmZ2Ef0; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="qRmZ2Ef0"
Received: from inspiron-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id 4RXivYtrc2D8r4RYKvkVzr; Thu, 02 Oct 2025 23:13:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759443213; bh=d67ZN9WC1jm9d7b7CukkiMl9nTLGwP+sH3x93Vx4xdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qRmZ2Ef0gSqWPIE8PHq9GaFA7+YKpMN9Rg060Qo/WyL2ikhWUVszBhebcgtI1RJMG
	 Ie35aX46+rF4LCOCkaD60/4+quWEMIUWPr1RkjuLG5hVb5JJ+nk6gmXUzsDNGFt4He
	 7XEvdY0S40XfVOuSLUrQoc4lgdfuHOl7agzhz/EbXYUjhKUWsKKmxA5u9W8CGCTkkv
	 V3gfWPS9y+ZJ6nWfuKGrSDnTP1red4qlqFeqFB7A8+yyiS7Iqg+X2r8U8tcUADzP8E
	 IyBPvHgNXO+3G68pKpg/L0ABdJyc2emiKjlvLV70bKRmB1dvcss7zr95IuQ4Mq0ONF
	 0FpWWXqif6h8g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68def90d
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
Subject: [PATCH v2 4/4] doc: commit-graph.adoc: fix up some formatting
Date: Thu,  2 Oct 2025 23:12:16 +0100
Message-ID: <20251002221233.541844-5-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfB51bX+Jt9rPNrTZQ6bgl+Uwc8Njov3uwiQIlT/I6Fiq0cH55guzAGUfKkL0Byo/imPr6ZWnheynRm71odUCz0Q9rMgDTO0S1Y4cS2bja7jy+bgn+Umj
 KMX3qOY1vf/PKxgROpEQV8SJmZ9AIf68UvUeGKeOg14gJ13meTaMQGHRdMMFSF4N3mlErSdfTwg+KL+fkb0dLibI4uqGz1juKic=

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

