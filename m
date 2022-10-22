Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14276FA373E
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 22:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJVW1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 18:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJVW04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 18:26:56 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Oct 2022 15:26:50 PDT
Received: from smtp-out-5.talktalk.net (smtp-out-5.talktalk.net [62.24.135.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A11C96391
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 15:26:50 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id mMw7oFnZllLbymMw8oJF1F; Sat, 22 Oct 2022 23:25:48 +0100
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=OJpZIhSB c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=3GLR1-XzZKwA:10 a=ldyaYNNxDcoA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=ybZZDoGAAAAA:8 a=kfWkm18d2Z9nEhkLeBkA:9 a=pmvdLUBtQCMA:10 a=vMvttVU5AH4A:10
 a=ezPG0ZpnnpEA:10 a=4C4UOcFw-z2-v6qsfVe_:22 a=AjGcO6oz07-iQ99wixmX:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: [PATCH v2 0/3] Add some Glossary of terms information
Date:   Sat, 22 Oct 2022 23:25:36 +0100
Message-Id: <20221022222539.2333-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFxw3rxt4lgX98LpzQxx7gH2WbF3jpPUPBKcj0a3VXikvreD2sZ2INNj2qeOqUQeGexZAJkFP/JyE/AfwEh4k0D4PMcZXuqhfKWEJ6+3gsO1qVtScTs9
 jJkNFlAcJpT4SsUvtvTfW87BK0MjSqCcN2s8depHmztG2L32tOx+go1+gjcDhCq3Vxup7tOhZBlRjA5SPDiTwiyTTgvgDKj7bpBg8kMhGh5+/0VJgC1zwLuj
 eSPzOGaDsDioWtEfldptwScW9ZDZPWGPjUNXwvjk7vZ+6KW0idnxVETxxvBVSVBwNpQQ4boIiflbJUQjMK1X4g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

was GitGitGadget #1282,
(in reply to <pull.1282.git.1657385781.gitgitgadget@gmail.com>)

This short series looks to add the basics of the reachability bitmap
and commit graph phrases to the glossary of terms. While these
techniques are well known to their developers, for some, they are
just magic phrases.

[V2] .. since V1
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


Philip Oakley (3):
  doc: use 'object database' not ODB or abbreviation
  glossary: add "commit graph" description
  glossary: add reachability bitmap description

 Documentation/git-pack-redundant.txt          |  2 +-
 Documentation/glossary-content.txt            | 27 +++++++++++++++++--
 Documentation/technical/commit-graph.txt      |  2 +-
 Documentation/technical/parallel-checkout.txt |  2 +-
 4 files changed, 28 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  51b55828d5 ! 1:  dc0d934b00 glossary: add Object DataBase (ODB) abbreviation
    @@ Metadata
     Author: Philip Oakley <philipoakley@iee.email>
     
      ## Commit message ##
    -    glossary: add Object DataBase (ODB) abbreviation
    +    doc: use 'object database' not ODB or abbreviation
     
    -    ODB abbreviation is used in the technical section without expansion.
    -    Show the abbreviation in the Glossary.
    +    The abbreviation 'ODB' is used in the technical documentation
    +    sections for commit-graph and parallel-checkout, along with an
    +    'odb' option in `git-pack-redundant`, without expansion.
    +
    +    Use 'object database' in full, in those entries. The text has not
    +    been reflowed to keep the changes minimal.
    +
    +    While in the glossary for `object` terms, add the common`oid`
    +    abbreviation to its entry.
     
         Signed-off-by: Philip Oakley <philipoakley@iee.email>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +
    + ## Documentation/git-pack-redundant.txt ##
    +@@ Documentation/git-pack-redundant.txt: OPTIONS
    + 
    + --alt-odb::
    + 	Don't require objects present in packs from alternate object
    +-	directories to be present in local packs.
    ++	database (odb) directories to be present in local packs.
    + 
    + --verbose::
    + 	Outputs some statistics to stderr. Has a small performance penalty.
     
      ## Documentation/glossary-content.txt ##
     @@ Documentation/glossary-content.txt: This commit is referred to as a "merge commit", or sometimes just a
    - 	<<def_SHA1,SHA-1>> of its contents. Consequently, an
    - 	object cannot be changed.
    - 
    --[[def_object_database]]object database::
    -+[[def_object_database]]object database (ODB)::
    - 	Stores a set of "objects", and an individual <<def_object,object>> is
      	identified by its <<def_object_name,object name>>. The objects usually
      	live in `$GIT_DIR/objects/`.
    + 
    +-[[def_object_identifier]]object identifier::
    ++[[def_object_identifier]]object identifier (oid)::
    + 	Synonym for <<def_object_name,object name>>.
    + 
    + [[def_object_name]]object name::
    +
    + ## Documentation/technical/commit-graph.txt ##
    +@@ Documentation/technical/commit-graph.txt: There are two main costs here:
    + 
    + The commit-graph file is a supplemental data structure that accelerates
    + commit graph walks. If a user downgrades or disables the 'core.commitGraph'
    +-config setting, then the existing ODB is sufficient. The file is stored
    ++config setting, then the existing object database is sufficient. The file is stored
    + as "commit-graph" either in the .git/objects/info directory or in the info
    + directory of an alternate.
    + 
    +
    + ## Documentation/technical/parallel-checkout.txt ##
    +@@ Documentation/technical/parallel-checkout.txt: Rejected Multi-Threaded Solution
    + 
    + The most "straightforward" implementation would be to spread the set of
    + to-be-updated cache entries across multiple threads. But due to the
    +-thread-unsafe functions in the ODB code, we would have to use locks to
    ++thread-unsafe functions in the object database code, we would have to use locks to
    + coordinate the parallel operation. An early prototype of this solution
    + showed that the multi-threaded checkout would bring performance
    + improvements over the sequential code, but there was still too much lock
2:  6a88bdb7ed ! 2:  77fbf889a5 glossary: add commit graph description
    @@ Metadata
     Author: Philip Oakley <philipoakley@iee.email>
     
      ## Commit message ##
    -    glossary: add commit graph description
    +    glossary: add "commit graph" description
    +
    +    Git has an additional "commit graph" capability that supplements the
    +    normal commit object's directed acylic graph (DAG). The supplemental
    +    commit graph file is designed for speed of access.
    +
    +    Describe the commit graph both from the normative DAG view point and
    +    from the commit graph file perspective.
    +
    +    Also, clarify the link between the branch ref and branch tip
    +    by linking to the `ref` glossary entry, matching this commit graph
    +    entry.
     
         Signed-off-by: Philip Oakley <philipoakley@iee.email>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/glossary-content.txt ##
    +@@
    + [[def_branch]]branch::
    + 	A "branch" is a line of development.  The most recent
    + 	<<def_commit,commit>> on a branch is referred to as the tip of
    +-	that branch.  The tip of the branch is referenced by a branch
    ++	that branch.  The tip of the branch is <<def_ref,referenced>> by a branch
    + 	<<def_head,head>>, which moves forward as additional development
    + 	is done on the branch.  A single Git
    + 	<<def_repository,repository>> can track an arbitrary number of
     @@ Documentation/glossary-content.txt: state in the Git history, by creating a new commit representing the current
      state of the <<def_index,index>> and advancing <<def_HEAD,HEAD>>
      to point at the new commit.
      
    -+[[def_commit_graph]]commit graph::
    -+	The commit-graph file is a supplemental data structure that
    -+	accelerates commit graph walks. The existing Object Data Base (ODB)
    -+	is the definitive commit graph. The "commit-graph" file is stored
    ++[[def_commit_graph_general]]commit graph concept, representations and usage::
    ++	A synonym for the <<def_DAG,DAG>> structure formed by
    ++	the commits in the object database, <<def_ref,referenced>> by branch tips,
    ++	using their <<def_chain,chain>> of linked commits.
    ++	This structure is the definitive commit graph. The
    ++	graph can be represented in other ways, e.g. the
    ++	<<def_commit_graph_file,commit graph file>>.
    ++
    ++[[def_commit_graph_file]]commit graph file::
    ++	The commit-graph file is a supplemental representation of
    ++	the <<def_commit_graph_general,commit graph>> which accelerates
    ++	commit graph walks. The "commit-graph" file is stored
     +	either in the .git/objects/info directory or in the info directory
     +	of an alternate object database.
     +
3:  564de4c68f ! 3:  fde2c58153 glossary: add reachability bitmap description
    @@ Metadata
      ## Commit message ##
         glossary: add reachability bitmap description
     
    +    Describe the purpose of the reachability bitmap.
    +
         Signed-off-by: Philip Oakley <philipoakley@iee.email>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/glossary-content.txt ##
     @@ Documentation/glossary-content.txt: exclude;;
    @@ Documentation/glossary-content.txt: exclude;;
      	that they contain.
      
     +[[def_reachability_bitmap]]reachability bitmaps::
    -+	Reachability bitmaps store information about the set of objects in
    -+	a packfile, or a multi-pack index (MIDX). A repository may have at
    ++	Reachability bitmaps store information about the
    ++	<<def_reachable,reachability>> of a selected set of objects in
    ++	a packfile, or a multi-pack index (MIDX) to speed up object search.
    ++	A repository may have at
     +	most one bitmap. The bitmap may belong to either one pack, or the
     +	repository's multi-pack index (if it exists).
     +

-- 
2.38.1.windows.1

