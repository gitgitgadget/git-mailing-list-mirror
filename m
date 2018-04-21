Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6501F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeDUJt7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:49:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:60789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbeDUJt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:49:58 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBFBB-1fJUCi44Pd-00AIz3; Sat, 21
 Apr 2018 11:49:54 +0200
Date:   Sat, 21 Apr 2018 11:49:38 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 07/11] Deprecate support for .git/info/grafts
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <1d96f3e3aad44df4d0dd93863d5d1a5157e38999.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GTF1tFh5XZgemZeXuVXI7AaJDSt1/CtWv3TqlNToPyyn/eiNv/X
 qGUZUC7o7CchJDSmtwT+zr2jn5aO2yq8Lt4dwQAQ1IOCsBOSvdWKmqtPFyOFi7aZ+xqHr07
 PunNy+Lr+wZj1XwC2T8QQsooXCWGiEhkptlAweiGwkcS2TaYTqQAb0bJw7KeUJCo3DFPlKR
 9NjRM8xaG1oGfoHEfwegQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2qq+rNS+YW0=:tpo1sbbJEpTi6RxKA9k7Oz
 YTo/W8uZSFeAECHW/L/X+Ty3azwTsGLRkQiIfEi+e6ZF7hC5nN2bvJ3jdjHlPw+xLCHKS2+/T
 fn2YCDruE5x6ZNoCKF54pDJ1udf0gEUq90zku/ey2OGdZtyWfsybJijLO0P2yMkwk4vc2ieXO
 q2mRm4v8kJK4RDmSts+NEZkeZxfWIqSvYY/9UPAbyTuk4a3L+NNnNi2E5MaYkK0wUscjSsyMv
 W26GYQ5xMwlwsWlMjCtEfKlbF1dUeaBfS4NV0dpfrEYrmv182BBqzcpxz6nlHuMiA46kJeNBd
 Yg81rlnUhCjwd2Vpuv/pG5U4k+h6kVgfoGDV/HeHO+Hku4O4FJKrBf2EybvQtosp2RvWCR6oc
 wG7z1iCQVamyKvb6I5n14cHjwiQs1it0B190G6n9jexEQynrVW7cq576vpWcscMkqd6XaCses
 D/QeWLq7ilPBeXRj3FgNjGwN9pdn10/j7oxcaP8jaUHKPE+WTqykSoFxdGtB51nVLTjNzNWZq
 RSSx4lzHU5omQor7nEDX3+uQUMxEcAnN0DBVZ+rTi3oagAYBfKQiyH/6QeHnm2Ar0Dt1MORCn
 iDXI7B39G/umPOEr+Wm9EcN26TMcIF4q92BFjTEXatZckTuRQt26czDjc2OgJFgLvVwmZ0APW
 Mp1nAd5ug8JDvh7xfyVFngIaFLozvpnhPNNv8mIKdi/79W/3lYqoHBmXCj+C56mOlnqej4nW3
 7GtI1G1vClPy9ZzQQEn0bDzXhP+o3MSJ5u2HS6XJnWw6OuLasfRcswL+n5qDmH+PNNyjV8psJ
 SnTRWBUB/M1l8j/wy1ElMXyWoKN2VjZZIOjmGz1olOu0gTIPj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The grafts feature was a convenient way to "stitch together" ancient
history to the fresh start of linux.git.

Its implementation is, however, not up to Git's standards, as there are
too many ways where it can lead to surprising and unwelcome behavior.

For example, when pushing from a repository with active grafts, it is
possible to miss commits that have been "grafted out", resulting in a
broken state on the other side.

Also, the grafts feature is limited to "rewriting" commits' list of
parents, it cannot replace anything else.

The much younger feature implemented as `git replace` set out to remedy
those limitations and dangerous bugs.

Seeing as `git replace` is pretty mature by now (since 4228e8bc98
(replace: add --graft option, 2014-07-19) it can perform the graft
file's duties), it is time to deprecate support for the graft file, and
to retire it eventually.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 advice.c                  |  2 ++
 advice.h                  |  1 +
 commit.c                  | 10 ++++++++++
 t/t6001-rev-list-graft.sh |  9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/advice.c b/advice.c
index 406efc183ba..4411704fd45 100644
--- a/advice.c
+++ b/advice.c
@@ -19,6 +19,7 @@ int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
+int advice_graft_file_deprecated = 1;
 
 static struct {
 	const char *name;
@@ -42,6 +43,7 @@ static struct {
 	{ "addembeddedrepo", &advice_add_embedded_repo },
 	{ "ignoredhook", &advice_ignored_hook },
 	{ "waitingforeditor", &advice_waiting_for_editor },
+	{ "graftfiledeprecated", &advice_graft_file_deprecated },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 70568fa7922..9f5064e82a8 100644
--- a/advice.h
+++ b/advice.h
@@ -21,6 +21,7 @@ extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
+extern int advice_graft_file_deprecated;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/commit.c b/commit.c
index 2952ec987c5..451d3ce8dfe 100644
--- a/commit.c
+++ b/commit.c
@@ -12,6 +12,7 @@
 #include "prio-queue.h"
 #include "sha1-lookup.h"
 #include "wt-status.h"
+#include "advice.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -176,6 +177,15 @@ static int read_graft_file(const char *graft_file)
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
+	if (advice_graft_file_deprecated)
+		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
+			 "and will be removed in a future Git version.\n"
+			 "\n"
+			 "Please use \"git replace --convert-graft-file\"\n"
+			 "to convert the grafts into replace refs.\n"
+			 "\n"
+			 "Turn this message off by running\n"
+			 "\"git config advice.graftFileDeprecated false\""));
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(&buf);
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 05ddc69cf2a..7504ba47511 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -110,4 +110,13 @@ do
 	"
 
 done
+
+test_expect_success 'show advice that grafts are deprecated' '
+	git show HEAD 2>err &&
+	test_i18ngrep "git replace" err &&
+	test_config advice.graftFileDeprecated false &&
+	git show HEAD 2>err &&
+	test_i18ngrep ! "git replace" err
+'
+
 test_done
-- 
2.17.0.windows.1.15.gaa56ade3205


