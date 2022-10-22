Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5728AC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 22:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJVW0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJVW0x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 18:26:53 -0400
Received: from smtp-out-5.talktalk.net (smtp-out-5.talktalk.net [62.24.135.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2C963A6
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 15:26:50 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id mMw7oFnZllLbymMw8oJF1K; Sat, 22 Oct 2022 23:25:48 +0100
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=OJpZIhSB c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=vfaYcDn82YOBLiSa2CoA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: [PATCH v2 1/3] doc: use 'object database' not ODB or abbreviation
Date:   Sat, 22 Oct 2022 23:25:37 +0100
Message-Id: <20221022222539.2333-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20221022222539.2333-1-philipoakley@iee.email>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <20221022222539.2333-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFxw3rxt4lgX98LpzQxx7gH2WbF3jpPUPBKcj0a3VXikvreD2sZ2INNj2qeOqUQeGexZAJkFP/JyE/AfwEh4k0D4PMcZXuqhfKWEJ6+3gsO1qVtScTs9
 jJkNFlAcJpT4SsUvtvTfW87BK0MjSqCcN2s8depHmztG2L32tOx+go1+gjcDhCq3Vxup7tOhZBlRjA5SPDiTwiyTTgvgDKj7bpBg8kMhGh5+/0VJgC1zwLuj
 eSPzOGaDsDioWtEfldptwScW9ZDZPWGPjUNXwvjk7vZ+6KW0idnxVETxxvBVSVBwNpQQ4boIiflbJUQjMK1X4g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The abbreviation 'ODB' is used in the technical documentation
sections for commit-graph and parallel-checkout, along with an
'odb' option in `git-pack-redundant`, without expansion.

Use 'object database' in full, in those entries. The text has not
been reflowed to keep the changes minimal.

While in the glossary for `object` terms, add the common`oid`
abbreviation to its entry.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/git-pack-redundant.txt          | 2 +-
 Documentation/glossary-content.txt            | 2 +-
 Documentation/technical/commit-graph.txt      | 2 +-
 Documentation/technical/parallel-checkout.txt | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index ee7034b5e5..1132c73956 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -34,7 +34,7 @@ OPTIONS
 
 --alt-odb::
 	Don't require objects present in packs from alternate object
-	directories to be present in local packs.
+	database (odb) directories to be present in local packs.
 
 --verbose::
 	Outputs some statistics to stderr. Has a small performance penalty.
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index aa2f41f5e7..947ac49606 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -262,7 +262,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	identified by its <<def_object_name,object name>>. The objects usually
 	live in `$GIT_DIR/objects/`.
 
-[[def_object_identifier]]object identifier::
+[[def_object_identifier]]object identifier (oid)::
 	Synonym for <<def_object_name,object name>>.
 
 [[def_object_name]]object name::
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index f05e7bda1a..5a4e1eba8b 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -17,7 +17,7 @@ There are two main costs here:
 
 The commit-graph file is a supplemental data structure that accelerates
 commit graph walks. If a user downgrades or disables the 'core.commitGraph'
-config setting, then the existing ODB is sufficient. The file is stored
+config setting, then the existing object database is sufficient. The file is stored
 as "commit-graph" either in the .git/objects/info directory or in the info
 directory of an alternate.
 
diff --git a/Documentation/technical/parallel-checkout.txt b/Documentation/technical/parallel-checkout.txt
index e790258a1a..47c9b6183c 100644
--- a/Documentation/technical/parallel-checkout.txt
+++ b/Documentation/technical/parallel-checkout.txt
@@ -56,7 +56,7 @@ Rejected Multi-Threaded Solution
 
 The most "straightforward" implementation would be to spread the set of
 to-be-updated cache entries across multiple threads. But due to the
-thread-unsafe functions in the ODB code, we would have to use locks to
+thread-unsafe functions in the object database code, we would have to use locks to
 coordinate the parallel operation. An early prototype of this solution
 showed that the multi-threaded checkout would bring performance
 improvements over the sequential code, but there was still too much lock
-- 
2.38.1.windows.1

