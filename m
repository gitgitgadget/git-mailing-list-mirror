Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651561D68F
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmddrJSM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336746c7b6dso2373591f8f.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351714; x=1703956514; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqb9knrlfUb7YhUuQR1MxrWluSV1cN886PjCysScI4s=;
        b=VmddrJSMlpAS9TeZFw9FpVWiYuMm01fQ3olp8bUXF07F1ZuFCXqK+ZkL2DxjMAGsKp
         jrxDpe+et1AvNh3BswwjTtUaY7+MnEeW7xGp5oSXg/Gq10IEfApalSNZvlxgg454E8Uu
         xCjFp5O3RpUAC50Tb3IxdFJ4/41wdaWOmVrgiZ13c96O3bcYChkoDbjPs+DY8Bi+Yd3+
         Yg0+3WPNlPPI95cae16v3Fe4eSD1Uq4nRi3nV61xrhzyvqdwJWU6jGj+CiPk50AK30WY
         N3ad6a5gWyFk1/dNzieQHi04XZ/j4pgaEnXI2V7/HDr2I2l+xs5qApxDxc9UiaxVZo7a
         r37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351714; x=1703956514;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aqb9knrlfUb7YhUuQR1MxrWluSV1cN886PjCysScI4s=;
        b=vSPIRs2gzHgwb24lDHtVJHBC8du05anMCW5GV+R3RPfGyGjoDrbHsS37H2XYuqh03G
         QnpLQwYJ+RpUrVO/jYLapMRH3SRiti71OkDxKq9NtnhIvAwSZ2QSa205TL2n+tmc7Ea5
         /NbrKTu8tvVdsM3YDtQC3UowoD7Vi/J6hUrfWcRyFLwJWB3R3zzGLgCbqvfUxQaqGzVc
         tLmqyD2hjUVSRB2231Jyex76VTrTppeDRpYIScEZwGtWpm6mt8aCdl7oTldR4Mzg2xfa
         B1uitAmBxVXhti5h5pPNV6rCH403JO8EftaGXy9z3LiWwaOUJkzOWcp+f7g6Ol6ygM0Q
         cg9Q==
X-Gm-Message-State: AOJu0YyxwuUPyI7/wxC5Oxb4tQOmkzBeaX/z2r3BNkw32hEQIXxU11H4
	iJvGdPetqbWmu+O/fwN2g2RSS0vdlO0=
X-Google-Smtp-Source: AGHT+IF5+ry1UK14RsDs5mTuKrCXMp3imqb5tp/OmoS61JvT5OgbYlqotiFZPo3e3k9IHm3EIJW2Jw==
X-Received: by 2002:a5d:55c9:0:b0:336:873b:2ae6 with SMTP id i9-20020a5d55c9000000b00336873b2ae6mr1592822wrw.124.1703351714556;
        Sat, 23 Dec 2023 09:15:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a5d49d1000000b00336614e25d0sm6852357wrs.56.2023.12.23.09.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:13 -0800 (PST)
Message-ID: <45f893e8e12b6023c935051495f2764e80029223.1703351702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:15:00 +0000
Subject: [PATCH v2 12/12] treewide: remove unnecessary includes in source
 files
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
    Elijah Newren <newren@gmail.com>,
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
