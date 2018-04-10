Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6B51F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeDJMak (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:30:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:57623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753176AbeDJMah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:30:37 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MIu7d-1f3wbu0SAj-002YLC; Tue, 10 Apr 2018 14:30:31 +0200
Date:   Tue, 10 Apr 2018 14:30:30 +0200 (DST)
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
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to the
 man page
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FGQFlJZ2eZiKpWLny4zh6y+RsKVe0UPLjjisqkYCb68/Oz3Ugue
 rPanLgJab51Q2M0vLuSNlodHXs4h5gW5I6OoGvCB9hnCepGBM/MIEf7Rq+ecGXy3OrU0X+o
 b+YDZUbkLX9mJInapB5xIWT0wOy+ABhA6Il+P8NPyv0DWLzVpK4Tg0XdhgM9zrx4zLLYBSy
 6M+N9vHdG8KWdvUWJfR3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wFevj2A8Q5s=:la/D0HoSA+dwR2VrrFRm2e
 U5bfIT13L5QxPtqkEHJLllahWIXw1NqiRp6Ik5qqYMU9jJZ6zh+9rjf534QIRFfG9e4uOWF3F
 XkLSXrgwY8yXagXDSg35N3ydQ0l2d22f9RJfxgCuQnPalvNGqu+1DXOtnr5/48Jri2mdDQgnP
 WN8JyuueDmtUdDgCd5QkxaUgf9F+YXyVc19xKKYchhpWwwTFpzGfpWlxIqD16/X81DukppD6H
 yowOGqxzVnpsvVec65sk18LqIQ8L8daEXuUHShf9BYg+5dEL068JeipQSRQbID2mAkUgM4Gik
 GXjuaH2x9ec4pLP9B92ovreRqtsuo1/QpxB3uX9PoA/BWbh2N6ULaYNwd0IBcw329oJ3bk+41
 jCKrH8ZlYfgTLSZtDhJU7TrPyLqZei0g14w7glklwccvFvo+ZaSQh3Xhe0JrtVyer9dxemr2a
 ZlDeLc4bBdPuvda/NxEQOwibxvcfpQ7uvag/GVxPJsvMouJBGu2jd6Nv9cZBPAMlD1xHiTc6u
 uOFEna1uXNRNu/RhBFCftuTvEiKeg27DQvvw6Z8leY4PxZhAhmhoQvbjbs2YVt7AxX06eqV2p
 ql3ZekiIIIZrF5GeEkAtlAl/Aj/a5QMU2loGQwHsMdvy1CIs19Ssuu1iBAC1rPHUbhfhttohX
 2j6wFcIrNYxsKggZvWs74BXTI3dGLusrhFUsGtLMdPwfaOoK+EYNiS+UYLuojnC1EltpQv+ld
 IptWEvMYI13b+s+kdDwukhV8HVGDkpFwnyQMP1o4XGWwKaCZOhdHgEl3hW2OtvapEijelGdP9
 QuqX9iJ3rhfB0JzcJP0V1NqTS+DsA300lvBmrakyvSfVHUHHGY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --rebase-merges mode is probably not half as intuitive to use as
its inventor hopes, so let's document it some.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 125 +++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8feadf6e663..be946de2efb 100644
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
@@ -787,6 +789,129 @@ The ripple effect of a "hard case" recovery is especially bad:
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
+The `label` command puts a label to whatever will be the current
+revision when that command is executed. Internally, these labels are
+worktree-local refs that will be deleted when the rebase finishes or
+when it is aborted. That way, rebase operations in multiple worktrees
+linked to the same repository do not interfere with one another.
+
+The `reset` command is essentially a `git reset --hard` to the specified
+revision (typically a previously-labeled one).
+
+The `merge` command will merge the specified revision into whatever is
+HEAD at that time. With `-C <original-commit>`, the commit message of
+the specified merge commit will be used. When the `-C` is changed to
+a lower-case `-c`, the message will be opened in an editor after a
+successful merge so that the user can edit the message.
+
+At this time, the `merge` command will *always* use the `recursive`
+merge strategy, with no way to choose a different one. To work around
+this, an `exec` command can be used to call `git merge` explicitly,
+using the fact that the labels are worktree-local refs (the ref
+`refs/rewritten/onto` would correspond to the label `onto`).
+
+Note: the first command (`reset onto`) labels the revision onto which
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
