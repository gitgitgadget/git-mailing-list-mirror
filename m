Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78F81F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeDYMaG (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:30:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:36393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753272AbeDYM34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:29:56 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LcmN9-1eVLMB3A6Z-00k8bX; Wed, 25 Apr 2018 14:29:49 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 17/17] rebase -i --rebase-merges: add a section to the man page
Date:   Wed, 25 Apr 2018 14:29:47 +0200
Message-Id: <673fb9cb8b5c7d57cb560b6ade45e419c8dd09fc.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:L9Cv8GO0oOFazBimztCYmblT9+CV6AV47AW86Ahka//6oJmMIWi
 PXOjfFfuLSMXhYO/DWngC1Fl+0kJPGXgRBtRi/fp8HszCOP2eQdEdZMYsywSWO6idIh6hnW
 5cu/XHCRfg9tOeE4Zu/4Gw2m5IyAVS0RSUcTjjWZVX8/yW9RKDxXDS53YWNn0hfDDL8cGpB
 vcL/Dlc7QqXzVjcQPcvTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E2yRZqStmkI=:wJ2fSVS90jRZvIH1Gb/TIg
 phIzg6JaAsaZd39sePdBm1zpci3Zz5/YVBGSP0+y0fzSrwENWEdAinnxBE98RznkJnJW7zSm3
 78NfGzP5bh898t0pzmj7oXOpnNtaTia0kHroKl/7vdaRbP/YvfCwXXIAViOOXak/OgPSqcCOH
 sSpQBQVBHhuOY4+lNjETNFxqmVke/2QnQihB7gGAsF3jCzaDywCuA0SKX9nJ+1jaQVf/NmSvM
 SwCXj84pqwzorznQGg60VG2ibf9E7dUq+sbyfp3XDj5JURd/FQ3dq0Qi06+SY5dwYJiU7+8Kx
 PbGH5T7hri6p171NCguCz2LCD3PymWsuRVKMk9EJpouwEIjRwD18qm67m3JN5GO9L8fmdddQc
 tPvJQcyXl6ZbFbnaLR0oXLp31qn2t3auDS21WBtEQuwi8TVaqQzo47nHVthXVwyfZQ9x1USNi
 dYq7j6lhXVL7X3a5PmF+UgG6CQV3iUhrgjJu9U6/Fh8Ay/XS8nxQd5hqeiZ75b+N3YMvRMDc1
 UVdG4bj3d5soJNoUFY5kLN87Wu1AePaUC0J4z/lxGHrzvixq8i1gj/o//myB9VccFk1bJ9j5c
 y4sQt7OvIz1T3C9aw9bQpjT8Ma9c7oP4Par6t5ND/0WZkD+vkDIfeNzdxVkU6zHvJvAvAEBS4
 097vnMixeUJDttq11xHnaw95P3HuuHcmHo77q7XVIOCFEKQ3EW9dZecXdqhoEvqmJpSt3N2oM
 33mKJS9KoibJabjBthiokKM5J3Z9ZNPrdMj7g014wsBgs7v+IYhZjRkO2gyflz0MQfZfHJBF4
 9yHYAv+AsDY6DttXXvEXiHqoT4AaqrZ7Zz88mLUDJnEicm7C8KOaWWPaspoREE81KaPG/Af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --rebase-merges mode is probably not half as intuitive to use as
its inventor hopes, so let's document it some.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 135 +++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index fe681d69281..bd5ecff980e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -403,6 +403,8 @@ reordered, inserted and dropped at will.
 It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
++
+See also REBASING MERGES below.
 
 -p::
 --preserve-merges::
@@ -801,6 +803,139 @@ The ripple effect of a "hard case" recovery is especially bad:
 'everyone' downstream from 'topic' will now have to perform a "hard
 case" recovery too!
 
+REBASING MERGES
+-----------------
+
+The interactive rebase command was originally designed to handle
+individual patch series. As such, it makes sense to exclude merge
+commits from the todo list, as the developer may have merged the
+then-current `master` while working on the branch, only to rebase
+all the commits onto `master` eventually (skipping the merge
+commits).
+
+However, there are legitimate reasons why a developer may want to
+recreate merge commits: to keep the branch structure (or "commit
+topology") when working on multiple, inter-related branches.
+
+In the following example, the developer works on a topic branch that
+refactors the way buttons are defined, and on another topic branch
+that uses that refactoring to implement a "Report a bug" button. The
+output of `git log --graph --format=%s -5` may look like this:
+
+------------
+*   Merge branch 'report-a-bug'
+|\
+| * Add the feedback button
+* | Merge branch 'refactor-button'
+|\ \
+| |/
+| * Use the Button class for all buttons
+| * Extract a generic Button class from the DownloadButton one
+------------
+
+The developer might want to rebase those commits to a newer `master`
+while keeping the branch topology, for example when the first topic
+branch is expected to be integrated into `master` much earlier than the
+second one, say, to resolve merge conflicts with changes to the
+DownloadButton class that made it into `master`.
+
+This rebase can be performed using the `--rebase-merges` option.
+It will generate a todo list looking like this:
+
+------------
+label onto
+
+# Branch: refactor-button
+reset onto
+pick 123456 Extract a generic Button class from the DownloadButton one
+pick 654321 Use the Button class for all buttons
+label refactor-button
+
+# Branch: report-a-bug
+reset refactor-button # Use the Button class for all buttons
+pick abcdef Add the feedback button
+label report-a-bug
+
+reset onto
+merge -C a1b2c3 refactor-button # Merge 'refactor-button'
+merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
+------------
+
+In contrast to a regular interactive rebase, there are `label`, `reset`
+and `merge` commands in addition to `pick` ones.
+
+The `label` command associates a label with the current HEAD when that
+command is executed. These labels are created as worktree-local refs
+(`refs/rewritten/<label>`) that will be deleted when the rebase
+finishes. That way, rebase operations in multiple worktrees linked to
+the same repository do not interfere with one another. If the `label`
+command fails, it is rescheduled immediately, with a helpful message how
+to proceed.
+
+The `reset` command resets the HEAD, index and worktree to the specified
+revision. It is isimilar to an `exec git reset --hard <label>`, but
+refuses to overwrite untracked files. If the `reset` command fails, it is
+rescheduled immediately, with a helpful message how to edit the todo list
+(this typically happens when a `reset` command was inserted into the todo
+list manually and contains a typo).
+
+The `merge` command will merge the specified revision into whatever is
+HEAD at that time. With `-C <original-commit>`, the commit message of
+the specified merge commit will be used. When the `-C` is changed to
+a lower-case `-c`, the message will be opened in an editor after a
+successful merge so that the user can edit the message.
+
+If a `merge` command fails for any reason other than merge conflicts (i.e.
+when the merge operation did not even start), it is rescheduled immediately.
+
+At this time, the `merge` command will *always* use the `recursive`
+merge strategy, with no way to choose a different one. To work around
+this, an `exec` command can be used to call `git merge` explicitly,
+using the fact that the labels are worktree-local refs (the ref
+`refs/rewritten/onto` would correspond to the label `onto`, for example).
+
+Note: the first command (`label onto`) labels the revision onto which
+the commits are rebased; The name `onto` is just a convention, as a nod
+to the `--onto` option.
+
+It is also possible to introduce completely new merge commits from scratch
+by adding a command of the form `merge <merge-head>`. This form will
+generate a tentative commit message and always open an editor to let the
+user edit it. This can be useful e.g. when a topic branch turns out to
+address more than a single concern and wants to be split into two or
+even more topic branches. Consider this todo list:
+
+------------
+pick 192837 Switch from GNU Makefiles to CMake
+pick 5a6c7e Document the switch to CMake
+pick 918273 Fix detection of OpenSSL in CMake
+pick afbecd http: add support for TLS v1.3
+pick fdbaec Fix detection of cURL in CMake on Windows
+------------
+
+The one commit in this list that is not related to CMake may very well
+have been motivated by working on fixing all those bugs introduced by
+switching to CMake, but it addresses a different concern. To split this
+branch into two topic branches, the todo list could be edited like this:
+
+------------
+label onto
+
+pick afbecd http: add support for TLS v1.3
+label tlsv1.3
+
+reset onto
+pick 192837 Switch from GNU Makefiles to CMake
+pick 918273 Fix detection of OpenSSL in CMake
+pick fdbaec Fix detection of cURL in CMake on Windows
+pick 5a6c7e Document the switch to CMake
+label cmake
+
+reset onto
+merge tlsv1.3
+merge cmake
+------------
+
 BUGS
 ----
 The todo list presented by `--preserve-merges --interactive` does not
-- 
2.17.0.windows.1.33.gfcbb1fa0445
