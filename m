Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5189D1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 12:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfJCMSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 08:18:40 -0400
Received: from mout.web.de ([212.227.15.14]:59023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfJCMSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 08:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570105114;
        bh=GYXsTRaoMobmCIqgnA71xGi/HVzs0neMzt+MrXXa4jY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=chJ3VxBgwZTe66PCT94KrLO9Ji7dS8PSkHA++B8IyFi36cePwDZ/+wx7PVBnKCCbs
         okXQJqTg048bTnflzoaKDPftFRmI1rd7D2VJC7tiEyt8kFwJsVi3mN0EOsLzLzcuHc
         /vdE5tI/xWzXGE50HClERmAv0GbRUyn/LtrLJOCc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbIiI-1hsBdo2vaU-00kvye; Thu, 03
 Oct 2019 14:18:34 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: PATCH] remove duplicate #include directives
Message-ID: <1133ae3b-81e8-4ec1-c2d7-d071e7e65ec1@web.de>
Date:   Thu, 3 Oct 2019 14:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8602afDDCUNArdc8MBAd877Ucp+nFmBS/rAvA5941TiwWYtTmbI
 W21gmTqe6ijiB/tOSiIC6+OzxxVT5WwuvqzJXjmL86wUYKtD6JeWVe+XlRb+OYatI6eZqz+
 qHF1DGRptwVHRaWLlcb/vO/ldh/ApCHuJNlcjMAPQ36wR3AJpmW/a8Z2Jl9GblPltoxvfll
 HCSMUs4OpPx1Qjw8D9gPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AiM+BtH9BJg=:uoXelojHgWYNr80tUzsZgR
 rmo6zo8fBOfB1g5+xRQqukMMsCmys2zzoA0SDNMgQ3kANUScTZWmKfJr+0TmDHW0I0q9RHFYh
 1eAhZExASzete0vRegO+4bZuQ/bX7gw0iIBx+cTB3ZL2EoSHHbOJn2I2sS3kyzNCIOoiF9gkp
 WKfGWrlQUAfLjaXSJtE17MLbqXeqcynY7z97MXQqbqoYFUnz+YQN00VaVx7e2I7B2h/yV7rAS
 UJpHnjCJpVPaTNWgPkdwbW9daSAMTJX+rwoJ1uk3ilmEyttRKQbgAxZWaU07wPbTKOmzK/TRZ
 tWHIlUlAtkp6Acoph8QCnPLtVV2GqlApDOiK7m9xmjXi7+jq0EmSa9HZAL3V5glHWtozmg9W6
 phuXr1yp8gK++XHHS9gvXNi8Qnl1zosfGygAWru0G4yI2dCx6Ny6PHieF9Gs62Hq4duyMQ1EH
 9Qg53BkLqnvAgvzszxwkNkmKt72NNtAAWmKTkjnduDXA2RPtloe45CvG6ezKxTofy3x4yboI8
 md7JOQv3g1n/wlL2UJhby1VtlrUry6rKFrKoQ2vie4iiv4XjcsbNZwM38hISQxEF6cEdSZZRz
 S0PoKL+ibXSohEfS4aHxAL4x9ESBGn6Ci6pgXc1skC9wr4Vz8G0xw8t3GGBIqa73UJNoIAU5J
 NtdlT2chIpM8u+PmObEd6+Rfy+DgyBuD3av2ER7SVceJA08fyvC/U83Qu7gnd9/tAQ5zgn7zJ
 tqE8ULx4/s+pd4jGdcn8vrwSemex4eCT4f2mLL1OZIyrXUGXBXIDAS9Hd/c8i32dd5y9+lQhU
 jJm7cu/jniWha48xYb5M+mDzT6o9c0GOYJkUB4z7SnsAl4nvYabd/TnsXDbqkHzB/MKkVAvFG
 P+ORddbqpAiy3XYTj51CmuXP8GaIGJ8JnzkFXZOKA3DUc9yHA5SnBNFJllN6UPW01Pl+2bt/7
 QLAUZLwoCVbmMh8ltLpFmNXxtP9yNjSh99VIbkCiXfBM5ZpqpNh8adcJ9io0jfAALKVTknzmK
 yolZco1gIYIThAt48COUicRs/NpVR+thF0cnf25gvKBIt3SIvtRmlksUsPyISRnEIeyEkGMkP
 cAreB2duMLW/YhbT4z8oP3SSPWMh2zjgzoLcOmV+uMKlBrjEHO6+Donz3nI0uaS1+w4iswpPA
 TjMGIwVvuuBzNVJ/dzaZsOln4zU64ik945o9Iyf6SQkst4AHKorU6c5GhRb7cDqVLNXGBeCcM
 urOsFlV1I1V0CNLQoSGkaa6WS1W82Es4ciZEPqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Found with "git grep '^#include ' '*.c' | sort | uniq -d".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with --function-context for easier review.

 builtin/am.c       | 1 -
 builtin/blame.c    | 1 -
 builtin/clone.c    | 1 -
 builtin/describe.c | 1 -
 builtin/rev-list.c | 1 -
 builtin/worktree.c | 1 -
 object.c           | 1 -
 packfile.c         | 1 -
 shallow.c          | 3 ---
 unpack-trees.c     | 1 -
 10 files changed, 12 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index ee7305eaa6..b015e1d7d1 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -1,40 +1,39 @@
 /*
  * Builtin "git am"
  *
  * Based on git-am.sh by Junio C Hamano.
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "parse-options.h"
 #include "dir.h"
 #include "run-command.h"
 #include "quote.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "refs.h"
 #include "commit.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "unpack-trees.h"
 #include "branch.h"
 #include "sequencer.h"
 #include "revision.h"
 #include "merge-recursive.h"
-#include "revision.h"
 #include "log-tree.h"
 #include "notes-utils.h"
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
 #include "apply.h"
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"

 /**
  * Returns the length of the first line of msg.
  */
diff --git a/builtin/blame.c b/builtin/blame.c
index bfd537b344..9858d6b269 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1,32 +1,31 @@
 /*
  * Blame
  *
  * Copyright (c) 2006, 2014 by its authors
  * See COPYING for licensing conditions
  */

 #include "cache.h"
 #include "config.h"
 #include "color.h"
 #include "builtin.h"
 #include "repository.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "quote.h"
 #include "string-list.h"
 #include "mailmap.h"
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "utf8.h"
 #include "userdiff.h"
 #include "line-range.h"
 #include "line-log.h"
 #include "dir.h"
 #include "progress.h"
 #include "object-store.h"
 #include "blame.h"
-#include "string-list.h"
 #include "refs.h"

 static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>] [<re=
v>] [--] <file>");
diff --git a/builtin/clone.c b/builtin/clone.c
index 2048b6760a..9d73102c42 100644
=2D-- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1,44 +1,43 @@
 /*
  * Builtin "git clone"
  *
  * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>,
  *		 2008 Daniel Barkalow <barkalow@iabervon.org>
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  *
  * Clone a repository into a different directory that does not yet exist.
  */

 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
 #include "refspec.h"
 #include "object-store.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "transport.h"
 #include "strbuf.h"
 #include "dir.h"
 #include "dir-iterator.h"
 #include "iterator.h"
 #include "sigchain.h"
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
-#include "object-store.h"

 /*
  * Overall FIXMEs:
  *  - respect DB_ENVIRONMENT for .git/objects.
  *
  * Implementation notes:
  *  - dropping use-separate-remote and no-separate-remote compatibility
  *
  */
diff --git a/builtin/describe.c b/builtin/describe.c
index e048f85484..90feab1120 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,22 +1,21 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
 #include "blob.h"
 #include "refs.h"
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "parse-options.h"
 #include "revision.h"
 #include "diff.h"
 #include "hashmap.h"
 #include "argv-array.h"
 #include "run-command.h"
 #include "object-store.h"
-#include "revision.h"
 #include "list-objects.h"
 #include "commit-slab.h"

 #define MAX_TAGS	(FLAG_BITS - 1)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b8dc2e1fba..fb8187fba5 100644
=2D-- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -1,24 +1,23 @@
 #include "cache.h"
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "object.h"
 #include "object-store.h"
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "builtin.h"
 #include "log-tree.h"
 #include "graph.h"
 #include "bisect.h"
 #include "progress.h"
 #include "reflog-walk.h"
 #include "oidset.h"
 #include "packfile.h"
-#include "object-store.h"

 static const char rev_list_usage[] =3D
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7f094f8170..0a53788151 100644
=2D-- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,16 +1,15 @@
 #include "cache.h"
 #include "checkout.h"
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
 #include "parse-options.h"
 #include "argv-array.h"
 #include "branch.h"
 #include "refs.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "submodule.h"
-#include "refs.h"
 #include "utf8.h"
 #include "worktree.h"

diff --git a/object.c b/object.c
index 07bdd5b26e..3b8b8c55c9 100644
=2D-- a/object.c
+++ b/object.c
@@ -1,13 +1,12 @@
 #include "cache.h"
 #include "object.h"
 #include "replace-object.h"
 #include "object-store.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
 #include "alloc.h"
-#include "object-store.h"
 #include "packfile.h"
 #include "commit-graph.h"

diff --git a/packfile.c b/packfile.c
index f3f962af4c..87512540f8 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -1,20 +1,19 @@
 #include "cache.h"
 #include "list.h"
 #include "pack.h"
 #include "repository.h"
 #include "dir.h"
 #include "mergesort.h"
 #include "packfile.h"
 #include "delta.h"
-#include "list.h"
 #include "streaming.h"
 #include "sha1-lookup.h"
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-store.h"
 #include "midx.h"
 #include "commit-graph.h"
 #include "promisor-remote.h"
diff --git a/shallow.c b/shallow.c
index 5fa2b15d37..ae813658fb 100644
=2D-- a/shallow.c
+++ b/shallow.c
@@ -1,21 +1,18 @@
 #include "cache.h"
 #include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
 #include "remote.h"
 #include "refs.h"
 #include "sha1-array.h"
 #include "diff.h"
 #include "revision.h"
 #include "commit-slab.h"
-#include "revision.h"
 #include "list-objects.h"
-#include "commit-slab.h"
-#include "repository.h"
 #include "commit-reach.h"

 void set_alternate_shallow_file(struct repository *r, const char *path, i=
nt override)
diff --git a/unpack-trees.c b/unpack-trees.c
index f0f56d40ac..33ea7810d8 100644
=2D-- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,27 +1,26 @@
 #include "cache.h"
 #include "argv-array.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
 #include "split-index.h"
-#include "dir.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "promisor-remote.h"

 /*
  * Error messages expected by scripts out of plumbing commands such as
  * read-tree.  Non-scripted Porcelain is not required to use these messag=
es
  * and in fact are encouraged to reword them to better suit their particu=
lar
  * situation better.  See how "git checkout" and "git merge" replaces
  * them using setup_unpack_trees_porcelain(), for example.
  */
=2D-
2.23.0

