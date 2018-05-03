Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CB9200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeECPbW (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:58073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbeECPbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:31:12 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LsPwa-1eCd0u1Y9w-0120Ys; Thu, 03 May 2018 17:31:08 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/18] branch-diff: add a man page
Date:   Thu,  3 May 2018 17:31:07 +0200
Message-Id: <edb34bd4f8da7437efb20e442780f17e9f84fc73.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YyyfzvKUEA7lUwDiKS886LilHEnOuUnkus+8kHWdfHfC7q7+T78
 U26nx0p+2yKlolYJdCdvrMUCgCFyNspyZ7HtFjijkqQnlnrXDGXOHPze8Xo5HD+1F0qUjT1
 HNDcBAmWsSsIgAyHkoYQUs0y5aofG8lXTlUY9xGnDf7xyDSupgVM0AbTY2o7CGFqV6GWPcW
 o5WyiRF1/dflSCbuCwOlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7akkpr9A0ZY=:RQZS4YvXCOqLB/+JuWQjgi
 7fzKqp8IHLJuUzxyh5DQD0682HBvHGU8TuZpINQwGr4qaHPv7mrrZRREUhu9uhDgiBWn3jI4Z
 mMPDYcqdSfr3YZGQuA+r8vZkvJFjJ1vJ3KnkLEjHHUqVK3zR7yJYNdh9JoR+/c/2aVPu373jU
 9VIlnMluhKmrpOeXD+whr+PYQGA8fhBiKRv5AjM32hYL1f8hdg9Rv2BksmfXBYC8l4K0/G3wM
 x0RH5MA01eNfDPkaXia/nKLKmGQWbUqQHfKKrp1kooqVS8ugzHTWVZ/dvq9fEeT9PLFYQl/pD
 4jjNr5wRsLjflg9cDJmOvPdiO+LKFVQpwz827CWw12ypf5GMMTD+9xKm7wJyV7x4zlW1Q7s+9
 RYSqmROgBabxOpl188VcpZWxFa8j36Iodtsuz1z3WChhn7vblvZxjHNtSwqeVSLAQd1IXUpgZ
 dl0xSqiheo5wjflAhmHWpozPxv59DySiTePGBaoTDCDqEySrVj6YH5L914yMrDN2Rc391hxr9
 TxIkC/+pG0ybTkorVakItitjVEdddb4EfT4VKD9fW6sGJScv1z+vk1sn1RN0D+ZGRLaVT5ohx
 4IuUzYXM4Ml95nP0UGBNMiSB+OjLfvtyFuOGZRSXHv3Pud3zenNusX1kcG7J+ncSqDa5+CjK7
 GmAEsQtlBYHKxSBzJGxaBAfFHMI2Bia9qsbFhgXNzjJPbGAEvKwIpY5VMSWYehS5VRmESGHou
 2jxbEmR0nBkVBwFPdNIN8XnxHUz+qd8h65MqLQquVb3m4D0In5pVj+LHBJlbG15BTBRgFdNPl
 x8V13+s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a heavily butchered version of the README written by Thomas
Rast and Thomas Gummerer, lifted from https://github.com/trast/tbdiff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-branch-diff.txt | 239 ++++++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)
 create mode 100644 Documentation/git-branch-diff.txt

diff --git a/Documentation/git-branch-diff.txt b/Documentation/git-branch-diff.txt
new file mode 100644
index 00000000000..b841586735c
--- /dev/null
+++ b/Documentation/git-branch-diff.txt
@@ -0,0 +1,239 @@
+git-branch-diff(1)
+==================
+
+NAME
+----
+git-branch-diff - Compare two versions of a branch
+
+SYNOPSIS
+--------
+[verse]
+'git branch-diff' [--color=[<when>]] [--no-color] [<diff-options>]
+	[--dual-color] [--no-patches] [--creation-weight=<weight>]
+	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
+
+DESCRIPTION
+-----------
+
+This command shows the differences between two versions of a patch
+series, or more generally, two commit ranges (ignoring merges).
+
+To that end, it first finds pairs of commits from both commit ranges
+that correspond with each other. Two commits are said to correspond when
+the diff between their patches (i.e. the author information, the commit
+message and the commit diff) is reasonably small compared to the
+patches' size. See ``Algorithm` below for details.
+
+Finally, the list of matching commits is shown in the order of the
+second commit range, with unmatched commits being inserted just after
+all of their ancestors have been shown.
+
+
+OPTIONS
+-------
+--no-patches::
+	Suppress the diffs between commit pairs that were deemed to
+	correspond; only show the pairings.
+
+--dual-color::
+	When the commit diffs differ, recreate the original diffs'
+	coloring, and add outer -/+ diff markers with the *background*
+	being red/green to make it easier to see e.g. when there was a
+	change in what exact lines were added.
+
+--creation-weight=<factor>::
+	Set the creation/deletion cost fudge factor to `<factor>`.
+	Defaults to 0.6. Try a larger value if `git branch-diff`
+	erroneously considers a large change a total rewrite (deletion
+	of one commit and addition of another), and a smaller one in
+	the reverse case. See the ``Algorithm`` section below for an
+	explanation why this is needed.
+
+<range1> <range2>::
+	Compare the commits specified by the two ranges, where
+	`<range1>` is considered an older version of `<range2>`.
+
+<rev1>...<rev2>::
+	Equivalent to passing `<rev2>..<rev1>` and `<rev1>..<rev2>`.
+
+<base> <rev1> <rev2>::
+	Equivalent to passing `<base>..<rev1>` and `<base>..<rev2>`.
+	Note that `<base>` does not need to be the exact branch point
+	of the branches. Example: after rebasing a branch `my-topic`,
+	`git branch-diff my-topic@{u} my-topic@{1} my-topic` would
+	show the differences introduced by the rebase.
+
+`git branch-diff` also accepts the regular diff options (see
+linkgit:git-diff[1]), most notably the `--color=[<when>]` and
+`--no-color` options. These options are used when generating the "diff
+between patches", i.e. to compare the author, commit message and diff of
+corresponding old/new commits. There is currently no means to tweak the
+diff options passed to `git log` when generating those patches.
+
+
+CONFIGURATION
+-------------
+This command uses the `diff.color.*` and `pager.branch-diff` settings
+(the latter is on by default).
+See linkgit:git-config[1].
+
+
+Examples
+--------
+
+When a rebase required merge conflicts to be resolved, compare the changes
+introduced by the rebase directly afterwards using:
+
+------------
+$ git branch-diff @{u} @{1} @
+------------
+
+
+A typical output of `git branch-diff` would look like this:
+
+------------
+-:  ------- > 1:  0ddba11 Prepare for the inevitable!
+1:  c0debee = 2:  cab005e Add a helpful message at the start
+2:  f00dbal ! 3:  decafe1 Describe a bug
+    @@ -1,3 +1,3 @@
+     Author: A U Thor <author@example.com>
+
+    -TODO: Describe a bug
+    +Describe a bug
+    @@ -324,5 +324,6
+      This is expected.
+
+    -+What is unexpected is that it will also crash.
+    ++Unexpectedly, it also crashes. This is a bug, and the jury is
+    ++still out there how to fix it best. See ticket #314 for details.
+
+      Contact
+3:  bedead < -:  ------- TO-UNDO
+------------
+
+In this example, there are 3 old and 3 new commits, where the developer
+removed the 3rd, added a new one before the first two, and modified the
+commit message of the 2nd commit as well its diff.
+
+When the output goes to a terminal, it is color-coded by default, just
+like regular `git diff`'s output. In addition, the first line (adding a
+commit) is green, the last line (deleting a commit) is red, the second
+line (with a perfect match) is yellow like the commit header of `git
+show`'s output, and the third line colors the old commit red, the new
+one green and the rest like `git show`'s commit header.
+
+The color-coded diff is actually a bit hard to read, though, as it
+colors the entire lines red or green. The line that added "What is
+unexpected" in the old commit, for example, is completely red, even if
+the intent of the old commit was to add something.
+
+To help with that, use the `--dual-color` mode. In this mode, the diff
+of diffs will retain the original diff colors, and prefix the lines with
+-/+ markers that have their *background* red or green, to make it more
+obvious that they describe how the diff itself changed.
+
+
+Algorithm
+---------
+
+The general idea is this: we generate a cost matrix between the commits
+in both commit ranges, then solve the least-cost assignment.
+
+To avoid false positives (e.g. when a patch has been removed, and an
+unrelated patch has been added between two iterations of the same patch
+series), the cost matrix is extended to allow for that, by adding
+fixed-cost entries for wholesale deletes/adds.
+
+Example: let commits `1--2` be the first iteration of a patch series and
+`A--C` the second iteration. Let's assume that `A` is a cherry-pick of
+`2,` and `C` is a cherry-pick of `1` but with a small modification (say,
+a fixed typo). Visualize the commits as a bipartite graph:
+
+------------
+    1            A
+
+    2            B
+
+		 C
+------------
+
+We are looking for a "best" explanation of the new series in terms of
+the old one. We can represent an "explanation" as an edge in the graph:
+
+
+------------
+    1            A
+	       /
+    2 --------'  B
+
+		 C
+------------
+
+This explanation comes for "free" because there was no change. Similarly
+`C` could be explained using `1`, but that comes at some cost c>0
+because of the modification:
+
+------------
+    1 ----.      A
+	  |    /
+    2 ----+---'  B
+	  |
+	  `----- C
+	  c>0
+------------
+
+In mathematical terms, what we are looking for is some sort of a minimum
+cost bipartite matching; `1` is matched to `C` at some cost, etc. The
+underlying graph is in fact a complete bipartite graph; the cost we
+associate with every edge is the size of the diff between the two
+commits' patches. To explain also new commits, we introduce dummy nodes
+on both sides:
+
+------------
+    1 ----.      A
+	  |    /
+    2 ----+---'  B
+	  |
+    o     `----- C
+	  c>0
+    o            o
+
+    o            o
+------------
+
+The cost of an edge `o--C` is the size of `C`'s diff, modified by a
+fudge factor that should be smaller than 1.0. The cost of an edge `o--o`
+is free. The fudge factor is necessary because even if `1` and `C` have
+nothing in common, they may still share a few empty lines and such,
+possibly making the assignment `1--C`, `o--o` slightly cheaper than
+`1--o`, `o--C` even if `1` and `C` have nothing in common. With the
+fudge factor we require a much larger common part to consider patches as
+corresponding.
+
+The overall time needed to compute this algorithm is the time needed to
+compute n+m commit diffs and then n*m diffs of patches, plus the time
+needed to compute the least-cost assigment between n and m diffs. Git
+uses an implementation of the Jonker-Volgenant algorithm to solve the
+assignment problem, which has cubic runtime complexity. The matching
+found in this case will look like this:
+
+------------
+    1 ----.      A
+	  |    /
+    2 ----+---'  B
+       .--+-----'
+    o -'  `----- C
+	  c>0
+    o ---------- o
+
+    o ---------- o
+------------
+
+
+SEE ALSO
+--------
+linkgit:git-log[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.17.0.395.g6a618d6010f.dirty


