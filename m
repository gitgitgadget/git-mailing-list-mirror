Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D609C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 16:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJ2Qld (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2QlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 12:41:25 -0400
Received: from smtp-out-6.talktalk.net (smtp-out-6.talktalk.net [62.24.135.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2C04507A
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 09:41:23 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id ootdodzgpnO7EootdoWf22; Sat, 29 Oct 2022 17:41:21 +0100
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=X8gs11be c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=3GLR1-XzZKwA:10 a=ldyaYNNxDcoA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=ybZZDoGAAAAA:8 a=Z0Tt0bPqZ-fUM5ICyKoA:9 a=Y04Gx_GTNEYA:10 a=pmvdLUBtQCMA:10
 a=vMvttVU5AH4A:10 a=ezPG0ZpnnpEA:10 a=4C4UOcFw-z2-v6qsfVe_:22
 a=AjGcO6oz07-iQ99wixmX:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Subject: [PATCH v3 0/4] Add some Glossary of terms information
Date:   Sat, 29 Oct 2022 17:41:08 +0100
Message-Id: <20221029164112.2097-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20221022222539.2333-1-philipoakley@iee.email>
References: <20221022222539.2333-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD9Bj+hYmfFgCiNETA+RHPkhKWnVrxfk+s9D8dcUh0IOf++2HDpdsH0eaPQIa2Ktmc9B/xGBBhPd5P99DTutT/CIAYkFJQKA9+9kypQWU8kZiMoXVoWK
 aBDYbFssfYsbPBHGkvv1sUTmk1gE/Cez50m2Z/iAva1SKMEfJk1Kj6zPe0lfZlNKp48z649bB2b5elnxAHRAAqq9fsX+DrdXji9/qfs0gcRSJv/zXtmD5dSU
 oXMrbUJ2NMC0HvUv3b3+Gg+xjvOp1/tW5OkrbxfWWHmxLpayXsOOrjmswSxgMrXnXX32WBX+bB2zCbzEw6JOO3oqZ9lsIfPtAPbGdazzytaQLQj85DKmn1Qe
 dPJg/iBQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(in reply to <20221022222539.2333-1-philipoakley@iee.email>

This short series looks to add the basics of the reachability bitmap
and commit graph phrases to the glossary of terms. While these
techniques are well known to their developers, for some, they are
just magic phrases.

[V3] .. since V2

1/4 Unchanged.
2/4 The distinction between the generic 'commit graph' of the DAG and
the implementation specifics of 'commit-graph' file has been retained
for the glossary. 
However the deliberate hyphenation has been included, and a fourth patch
added to maintain the consistency of 'commit-graph' in other documents.

3/4 Tweaks & links applied to Reachability patch.
4/4 New - maintain the consistency of 'commit-graph' in other documents.

[V2] .. since V1
was GitGitGadget #1282,
(in reply to <pull.1282.git.1657385781.gitgitgadget@gmail.com>)
Patch 4/4 has been taken upstream independently, and hence dropped
here so we're now just [n/3].

Patch 1/3 Dropped the glossary addition in favour of changing the
locations that used ODB (Junio's suggestion). Kept the git
pack-redundant's `--alt-odb` but spelt out 'object database' in full
in the man page. The only remaining `odb`s are within `goodbye` ;-).

While here, add the (oid) abbreviation to its adjacent entry.

Patch 2/3 Split the 'commit-graph' explanation into two parts to
distinguish the speed-up option, from Git's core graph concept of
object traversal. Included links to existing terms.

Patch 3/3 Added links to existing terms. Statement for the
reachability bitmaps.

added cc: for Stolee (commit-graph) and Abhradeep Chakraborty
(Bitmaps) review.


[V1] [GGG PR #1282] 
https://lore.kernel.org/git/pull.1282.git.1657385781.gitgitgadget@gmail.com/

The first patch [1/4] is to show OBD as an abbreviation to avoid a UNA [0]

Patch [2/4] provides a basic statement for the Commit-Graph's purpose.

Patch [3/4] provides a similar statement for the reachability bitmaps.

These two patches maybe misses out on some linking information as to
the benefits these have and the basics of their heuristic.

Patch [4/4] follows up on a bug report about the lack of idempotence
for the `--renormalise' command. See commit message for details.

[0] UNA Un-Named Abbreviation.

Signed-off-by: Philip Oakley philipoakley@iee.email
cc: Philip Oakley philipoakley@iee.email


Philip Oakley (4):
  doc: use 'object database' not ODB or abbreviation
  glossary: add "commit graph" description
  glossary: add reachability bitmap description
  doc: use "commit-graph" hyphenation consistently

 Documentation/config/core.txt                 |  2 +-
 Documentation/git-pack-redundant.txt          |  2 +-
 Documentation/gitformat-commit-graph.txt      |  6 ++---
 Documentation/glossary-content.txt            | 27 +++++++++++++++++--
 Documentation/technical/commit-graph.txt      |  8 +++---
 Documentation/technical/parallel-checkout.txt |  2 +-
 6 files changed, 35 insertions(+), 12 deletions(-)

Range-diff against remotes/gitster/po/glossary-around-traversal (v2?):
1:  de164ab78b ! 1:  748b15345e doc: use 'object database' not ODB or abbreviation
    @@ Commit message
         abbreviation to its entry.
     
         Signed-off-by: Philip Oakley <philipoakley@iee.email>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/git-pack-redundant.txt ##
     @@ Documentation/git-pack-redundant.txt: OPTIONS
2:  f677d57699 ! 2:  052a9568e7 glossary: add "commit graph" description
    @@ Commit message
         glossary: add "commit graph" description
     
         Git has an additional "commit graph" capability that supplements the
    -    normal commit object's directed acylic graph (DAG). The supplemental
    +    normal commit object's directed acyclic graph (DAG). The supplemental
         commit graph file is designed for speed of access.
     
         Describe the commit graph both from the normative DAG view point and
    @@ Commit message
         by linking to the `ref` glossary entry, matching this commit graph
         entry.
     
    +    The commit-graph file is also distinguished by its hyphenation.
    +
    +    Subsequent commit catches the few cases where the hyphenation of
    +    commit-graph was missing.
    +
         Signed-off-by: Philip Oakley <philipoakley@iee.email>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/glossary-content.txt ##
     @@
    @@ Documentation/glossary-content.txt: state in the Git history, by creating a new
      to point at the new commit.
      
     +[[def_commit_graph_general]]commit graph concept, representations and usage::
    -+	A synonym for the <<def_DAG,DAG>> structure formed by
    -+	the commits in the object database, <<def_ref,referenced>> by branch tips,
    ++	A synonym for the <<def_DAG,DAG>> structure formed by the commits
    ++	in the object database, <<def_ref,referenced>> by branch tips,
     +	using their <<def_chain,chain>> of linked commits.
     +	This structure is the definitive commit graph. The
     +	graph can be represented in other ways, e.g. the
    -+	<<def_commit_graph_file,commit graph file>>.
    ++	<<def_commit_graph_file,"commit-graph" file>>.
     +
    -+[[def_commit_graph_file]]commit graph file::
    -+	The commit-graph file is a supplemental representation of
    -+	the <<def_commit_graph_general,commit graph>> which accelerates
    -+	commit graph walks. The "commit-graph" file is stored
    -+	either in the .git/objects/info directory or in the info directory
    -+	of an alternate object database.
    ++[[def_commit_graph_file]]commit-graph file::
    ++	The "commit-graph" (normally hyphenated) file is a supplemental
    ++	representation of the <<def_commit_graph_general,commit graph>>
    ++	which accelerates commit graph walks. The "commit-graph" file is
    ++	stored either in the .git/objects/info directory or in the info
    ++	directory of an alternate object database.
     +
      [[def_commit_object]]commit object::
      	An <<def_object,object>> which contains the information about a
3:  39e9a282fc ! 3:  d56234b70c glossary: add reachability bitmap description
    @@ Commit message
         Describe the purpose of the reachability bitmap.
     
         Signed-off-by: Philip Oakley <philipoakley@iee.email>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/glossary-content.txt ##
     @@ Documentation/glossary-content.txt: exclude;;
    @@ Documentation/glossary-content.txt: exclude;;
      
     +[[def_reachability_bitmap]]reachability bitmaps::
     +	Reachability bitmaps store information about the
    -+	<<def_reachable,reachability>> of a selected set of objects in
    -+	a packfile, or a multi-pack index (MIDX) to speed up object search.
    -+	A repository may have at
    -+	most one bitmap. The bitmap may belong to either one pack, or the
    -+	repository's multi-pack index (if it exists).
    ++	<<def_reachable,reachability>> of a selected set of commits in
    ++	a packfile, or a multi-pack index (MIDX), to speed up object search.
    ++	The bitmaps are stored in a ".bitmap" file. A repository may have at
    ++	most one bitmap file in use. The bitmap file may belong to either one
    ++	pack, or the repository's multi-pack index (if it exists).
     +
      [[def_rebase]]rebase::
      	To reapply a series of changes from a <<def_branch,branch>> to a
-:  ---------- > 4:  87686e63f9 doc: use "commit-graph" hyphenation consistently
-- 
2.38.1.windows.1

