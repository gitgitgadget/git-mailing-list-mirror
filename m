Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A331F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeDSMYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:24:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:59149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeDSMYq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:24:46 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYLKn-1ewKs2045h-00V6RB; Thu, 19
 Apr 2018 14:24:39 +0200
Date:   Thu, 19 Apr 2018 14:24:22 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 17/17] rebase -i --rebase-merges: add a section to the
 man page
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <3fcb3ec73d3c9e638042ac3a39e655ba3664f58c.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pEY41WZkKKSDxuAxwtbDAi0I4/dRP75O+3sbTQdoDlMnXJ2c3C5
 rvSVelv3SS8B5jh3u23lgwegGlCBviJ4FvDNK5AEzt6Xk0lkUqJeWhEYqE+ZEyytjQwzWjJ
 7A8ZYz5KaH7uZzuuANLTyzVsCbcNH2OLlQ2NuY2DeEBpelw5Bmwx9JUkoqQWlV9Wl1YUyky
 ls03+t1nx1xD9oKumE9mQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DcGKBakmmhE=:UGMRD/JfZkbVuqg9ItwuUM
 tzaY5Fu1ziJ2pIvNs9GTISvuI2fVAnwiUrag0HIMMZg6g2MYr/tlaam+xl7982C1a+Jyxo6rh
 K/mgNNcYj/QH1d1K5FaqtTurJcTysCkgWpBVjWsEe0ozosaJNvOlJzTsy8CVOa6uuMW6+UNur
 ttcqoGDkvE18jzJWGKQPk2xoJjdQy8j2mQV80Z8rQbUoL9PUI1n3UrbuqpLNdsZ3/97DIJEGy
 xGVQ0mmiYvTiHf+97rgtHhAfyYs70JKR8hQ2psA2A9CbZrtAtzdW8cH/ygt/PpjfiLQAodUBQ
 scQshTbHxu+hOhamLAbZZImwfAMQQjkecOoWIAurmHHEelBtfolVCrViog7MWyAW9gnkgyjbY
 nW7Mz/9G7khveW38zPSF3Sz70c4PYQo6tcyjjktJk8tLOud3Lc2JhYU9M4zzsdatwIuXWL22i
 Zcza/jKJV4bfcFcNx0Ytwpf3PDHqGiqdkmmeYZIw70tzUlXZjxqMikuYzZglbihlVmS/pu0Wj
 Zr/zCqbgfL8RpI5nm4fSd7iOi8omrR4FhYswacMMJpv3K0bcx5AlwPvd8kY7DjYz+K4v7mkO6
 Yr0M1cN1tqvWf+7hLsER/HCrl7evvb8ibxThC/UtnhxEMo9Byd4YgP0BGwxdgKJthxXMVJa78
 blsUPlpTt0Kg6kaJwsvd3z+rkcSuo3Bq56xaWec9z5iSBsRLMjDVtqCXVfB+Lhj5X2Z7cnWDW
 0MzonCOrKC2OXqrjrIpUeLT9oXBr4xWR3156Ss10193XKf3Fv9PBDcEUPjjSkMDEwPSF4Q5vO
 EimD6TgbUgz2Zk6U0OY9xc+yWePR/hbLDZkHwwmKysvYYZH5zw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --rebase-merges mode is probably not half as intuitive to use as
its inventor hopes, so let's document it some.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 132 +++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8feadf6e663..0ff83b62821 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -389,6 +389,8 @@ By default, or when `no-rebase-cousins` was specified, commits which do not
 have `<upstream>` as direct ancestor will keep their original branch point.
 If the `rebase-cousins` mode is turned on, such commits are rebased onto
 `<upstream>` (or `<onto>`, if specified).
++
+See also REBASING MERGES below.
 
 -p::
 --preserve-merges::
@@ -787,6 +789,136 @@ The ripple effect of a "hard case" recovery is especially bad:
 'everyone' downstream from 'topic' will now have to perform a "hard
 case" recovery too!
 
+REBASING MERGES
+-----------------
+
+The interactive rebase command was originally designed to handle
+individual patch series. As such, it makes sense to exclude merge
+commits from the todo list, as the developer may have merged the
+current `master` while working on the branch, only to eventually
+rebase all the commits onto `master` (skipping the merge commits).
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
+In contrast to a regular interactive rebase, there are `label`, `reset` and
+`merge` commands in addition to `pick` ones.
+
+The `label` command associates a label with the current HEAD when that
+command is executed. These labels are created as worktree-local refs
+(`refs/rewritten/<label>`) that will be deleted when the rebase
+finishes. That way, rebase operations in multiple worktrees linked to
+the same repository do not interfere with one another. If the `label` command
+fails, it is rescheduled immediately, with a helpful message how to proceed.
+
+The `reset` command is essentially a `git read-tree -m -u` (think: `git
+reset --hard`, but refusing to overwrite untracked files) to the
+specified revision (typically a previously-labeled one). If the `reset`
+command fails, it is rescheduled immediately, with a helpful message how to
+proceed.
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
+`refs/rewritten/onto` would correspond to the label `onto`).
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
2.17.0.windows.1.4.g7e4058d72e3
