Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEld73Rr"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE6FF9
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so1335635e9.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585695; x=1702190495; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqb9knrlfUb7YhUuQR1MxrWluSV1cN886PjCysScI4s=;
        b=UEld73RroVBpVIjdsGUG94Ehz5B4bjYcPVu8+1RKuWSooTb3g1wxC7zPxoJLkIJZGl
         HWKLEljiHdi8+zZKolm/xZE6fIbGGk8tUjYfAfEdMuIrx+0jZhFfTXkQXCENWkbdjxKJ
         wK/RrZ0eVDxXouUDpGXU6onuRerCSF+gIkqqnIOCL7lbYCj/I+aLqSk5emzg97ustp8v
         pcBZkoVkoFfxcj17OvA0SaarQlfckamJpXO3Fyp5XSZ9XvJNW/qu+QPyWhur1Ny58J+n
         18CPygBwasvKeLGWN2hmzhur9T0PPXMD9r3YX5Ivr9Hd7zVBJlAaQNMFEkbtn2Jyx4JC
         06fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585695; x=1702190495;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aqb9knrlfUb7YhUuQR1MxrWluSV1cN886PjCysScI4s=;
        b=WsO3Sid3TX2eZLshnlJ8ZXE90Qihxl/KBkF5X9KOd9BTQQ03dtOO5YRqdGh+9c/rBI
         v3Sgy1XHLRx0fZUoJVFE3Ce8KG6eTcRMzQfB4VaPAMLrv2Hd4zzk3vksQhW1YEOb4pz3
         9M5hCOXnIhUweI+N8xmvuXjifFJY14VDJs4I0VdUH1VUSvIx5FuANkE2o5uqmmvBz8Jc
         VKgyqLZHN3aXl03201vSgMImlxeCpLchvOavKHKuwtKVPzibSN5f+CpQ6L6kjQ8iqX5s
         qnCUJ2eHUCn5/dTha7/g24ja1Hb8l5U1795zzxiHL+EEYx9w/RZsrQTA0dgEcq5Id/lU
         vXKw==
X-Gm-Message-State: AOJu0Yw9k+6mde3NnKHKAoINodR8N+XCU0bzOa41ubAd2ITJKMa7WNiT
	SGXfR0trN4EsNBlYUSBOmaY8UVQZSbE=
X-Google-Smtp-Source: AGHT+IGaVNVmDtFE9UgUjYWUYi4ffIHhTs+sRGQjcTRzT8P3RGoM5+IISueY6gv8TqhMa0R0COceuA==
X-Received: by 2002:a05:600c:4448:b0:40b:5464:b23d with SMTP id v8-20020a05600c444800b0040b5464b23dmr1036337wmn.37.1701585694636;
        Sat, 02 Dec 2023 22:41:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1-20020adfe501000000b003332f1f51f4sm6541714wrm.94.2023.12.02.22.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:34 -0800 (PST)
Message-ID: <57f9da7bba01af1e35d737460ae2bba0bb826cce.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:21 +0000
Subject: [PATCH 12/12] treewide: remove unnecessary includes in source files
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/archive.c                   | 1 -
 builtin/commit-graph.c              | 1 -
 builtin/fsck.c                      | 1 -
 builtin/fsmonitor--daemon.c         | 2 --
 builtin/grep.c                      | 1 -
 builtin/mktag.c                     | 1 -
 builtin/rev-list.c                  | 1 -
 builtin/send-pack.c                 | 1 -
 commit-graph.c                      | 1 -
 compat/simple-ipc/ipc-shared.c      | 3 ---
 compat/simple-ipc/ipc-unix-socket.c | 1 -
 fsmonitor-ipc.c                     | 1 -
 http.c                              | 1 -
 line-log.c                          | 1 -
 merge-ort.c                         | 1 -
 notes-utils.c                       | 1 -
 ref-filter.c                        | 1 -
 remote-curl.c                       | 1 -
 repo-settings.c                     | 1 -
 t/helper/test-repository.c          | 1 -
 trace2/tr2_ctr.c                    | 1 -
 trace2/tr2_tmr.c                    | 1 -
 22 files changed, 25 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 90761fdfee0..15ee1ec7bb7 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -9,7 +9,6 @@
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "repository.h"
-#include "sideband.h"
 
 static void create_output_file(const char *output_file)
 {
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 81a28c6fcdd..666ad574a46 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -4,7 +4,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "lockfile.h"
 #include "parse-options.h"
 #include "repository.h"
 #include "commit-graph.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9317b7b841d..a7cf94f67ed 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -10,7 +10,6 @@
 #include "refs.h"
 #include "pack.h"
 #include "cache-tree.h"
-#include "tree-walk.h"
 #include "fsck.h"
 #include "parse-options.h"
 #include "progress.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 9f80b9eaff5..1593713f4cb 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,7 +7,6 @@
 #include "parse-options.h"
 #include "fsmonitor-ll.h"
 #include "fsmonitor-ipc.h"
-#include "fsmonitor-path-utils.h"
 #include "fsmonitor-settings.h"
 #include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
@@ -15,7 +14,6 @@
 #include "repository.h"
 #include "simple-ipc.h"
 #include "khash.h"
-#include "pkt-line.h"
 #include "run-command.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index f076cc705b4..c8e33f97755 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -14,7 +14,6 @@
 #include "parse-options.h"
 #include "string-list.h"
 #include "run-command.h"
-#include "userdiff.h"
 #include "grep.h"
 #include "quote.h"
 #include "dir.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index d8e0b5afc07..4767f1a97e6 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -3,7 +3,6 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "strbuf.h"
-#include "tag.h"
 #include "replace-object.h"
 #include "object-file.h"
 #include "object-store-ll.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 460ba7cbaa7..b3f47838580 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -12,7 +12,6 @@
 #include "object-name.h"
 #include "object-file.h"
 #include "object-store-ll.h"
-#include "pack.h"
 #include "pack-bitmap.h"
 #include "log-tree.h"
 #include "graph.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 395f2e490d4..0b839f583a0 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -2,7 +2,6 @@
 #include "config.h"
 #include "hex.h"
 #include "pkt-line.h"
-#include "sideband.h"
 #include "run-command.h"
 #include "remote.h"
 #include "connect.h"
diff --git a/commit-graph.c b/commit-graph.c
index e7212400da3..15980cf9492 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -4,7 +4,6 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "pack.h"
 #include "packfile.h"
 #include "commit.h"
 #include "object.h"
diff --git a/compat/simple-ipc/ipc-shared.c b/compat/simple-ipc/ipc-shared.c
index e5e1dda8ccd..cb176d966f2 100644
--- a/compat/simple-ipc/ipc-shared.c
+++ b/compat/simple-ipc/ipc-shared.c
@@ -1,8 +1,5 @@
 #include "git-compat-util.h"
 #include "simple-ipc.h"
-#include "strbuf.h"
-#include "pkt-line.h"
-#include "thread-utils.h"
 
 #ifndef SUPPORTS_SIMPLE_IPC
 /*
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index b2f4f22ce44..9b3f2cdf8c9 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -2,7 +2,6 @@
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
-#include "pkt-line.h"
 #include "thread-utils.h"
 #include "trace2.h"
 #include "unix-socket.h"
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 153918cf768..45471b5b741 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "fsmonitor-ll.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "fsmonitor-ipc.h"
diff --git a/http.c b/http.c
index a64005ceb80..3565c4ec611 100644
--- a/http.c
+++ b/http.c
@@ -4,7 +4,6 @@
 #include "http.h"
 #include "config.h"
 #include "pack.h"
-#include "sideband.h"
 #include "run-command.h"
 #include "url.h"
 #include "urlmatch.h"
diff --git a/line-log.c b/line-log.c
index c276ccec549..8ff6ccb7724 100644
--- a/line-log.c
+++ b/line-log.c
@@ -12,7 +12,6 @@
 #include "xdiff-interface.h"
 #include "strbuf.h"
 #include "log-tree.h"
-#include "userdiff.h"
 #include "line-log.h"
 #include "setup.h"
 #include "strvec.h"
diff --git a/merge-ort.c b/merge-ort.c
index 2a0be468505..77ba7f3020c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -41,7 +41,6 @@
 #include "revision.h"
 #include "sparse-index.h"
 #include "strmap.h"
-#include "submodule.h"
 #include "trace2.h"
 #include "tree.h"
 #include "unpack-trees.h"
diff --git a/notes-utils.c b/notes-utils.c
index 97c031c26ec..08e5dbc6073 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -5,7 +5,6 @@
 #include "gettext.h"
 #include "refs.h"
 #include "notes-utils.h"
-#include "repository.h"
 #include "strbuf.h"
 
 void create_notes_commit(struct repository *r,
diff --git a/ref-filter.c b/ref-filter.c
index 96959a3762c..01b90e325c2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -29,7 +29,6 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "hashmap.h"
-#include "strvec.h"
 
 static struct ref_msg {
 	const char *gone;
diff --git a/remote-curl.c b/remote-curl.c
index 55eefa70f97..7f81bf3fafc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -11,7 +11,6 @@
 #include "run-command.h"
 #include "pkt-line.h"
 #include "string-list.h"
-#include "sideband.h"
 #include "strvec.h"
 #include "credential.h"
 #include "oid-array.h"
diff --git a/repo-settings.c b/repo-settings.c
index 525f69c0c77..30cd4787627 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -2,7 +2,6 @@
 #include "config.h"
 #include "repository.h"
 #include "midx.h"
-#include "compat/fsmonitor/fsm-listen.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index c925655c648..0c7c5aa4dd7 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -3,7 +3,6 @@
 #include "commit.h"
 #include "environment.h"
 #include "hex.h"
-#include "object-store-ll.h"
 #include "object.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index 87cf9034fba..d3a33715c14 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "thread-utils.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_ctr.h"
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
index 31d0e4d1bd1..51f564b07a4 100644
--- a/trace2/tr2_tmr.c
+++ b/trace2/tr2_tmr.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "thread-utils.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
-- 
gitgitgadget
