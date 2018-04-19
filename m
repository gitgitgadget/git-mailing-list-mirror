Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40AFD1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeDSISy (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:18:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:33037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeDSISv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:18:51 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7TQZ-1eFrYv0PpP-00xMiI; Thu, 19
 Apr 2018 10:18:46 +0200
Date:   Thu, 19 Apr 2018 10:18:30 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 4/7] Deprecate support for .git/info/grafts
In-Reply-To: <cover.1524125760.git.johannes.schindelin@gmx.de>
Message-ID: <36c8de0c9c4484ec44cc5af8f8ac752ef77bc960.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QnrWu3fYKdHKuZxLgJL32+h3t9DQr6ahiCLo1UzOBYdzSDwb/UD
 bP3D+oWN9NRw2CwGYYVEDRTWfXs92Mw9P1DvyMYsiuVY6YBTRdB8WBkOcZWYJrCrV4HHr8U
 CjJPzUSe6Wp2z7QjunhOQqKdfwR70XymdTfr7DZEIsXyc0MEtcGjzwVF9hol5sY3g9ogQkv
 kgmWeX5+ygA4bECPjwvCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:18sZuQkYqkc=:/JXDWauTQI35Pa6KWGq96L
 uuOMZfWNrgpuP5ZaocfrefIPK2VTfWN7CVivrzeeQNfFDCCY9ZMAO/9kMEKIRMxe3B77mRwc5
 U9+kFVENrg93F01vIzatzBC4uoCOjziUgK90vGfLVQ2yS1Lh2wz+4BcGEfw7Rs+zyKmN1lCnd
 shwCKjYEzMiVfkFfW5Fs+4tHDmQiBD2Do+bpX0Qe6pim8BHUYcpbJPm0wfAJ4BVB3PXa6zOPU
 Ou9x0R8r7vmok7TH7JU3dABGPDsdKAn/WXn+vUOWZZsRAkU4TLcHrSfQpaFSRgD3ZhKX96A98
 7vsjolmop9ulZ9l+oDidzeOB3h/5x0vyWq9lL/cSJm5zu/lhKfL4OXRR/Jj47taeoe5CQaQQB
 k3J7T9tUgFxBDfUaNTRNAndFdizY6bse/juj1yMLKibgez1+Mavi9WXHUopb9NlrtpIZqSen8
 WxtvEESza8jEdCB8z+dofJr+y1BVbErfA7opbPZmjrlYhfzMz2QLGiSgG6zl3t3t+GuZV5YYA
 BuzNYmLt2D6PNbsmuoWBWo1jWm7uPsu9Pg7uqBBHqEKDw2fuoIr+DtoQzd5PSwMUt4NsSATIr
 jyhzO8K8YdNbylm3V1/M76c2g3LbKJ5dmGXdvLbBqqrDDbmv3muZYab/plznQBEFXx4jd2df7
 Im81BWMAymimRObGSct4jD5dPu+z36MRIsqTn2G1CMw5z2lOU+pkE/qR9tnrrXAnfDVfWHTcW
 kAgUUj5RISaUKsYZmBINFBeHuJHtvMcrvN5FnQ/rXpoDzyY44/I/kpPYstR1pSiOTnpLdbfkS
 lmI5m5a33yEXUau0d86zmvG5lr+x/eMr47Palb4iR6QrBplZAk=
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
index ca474a7c112..1a5e8777617 100644
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
2.17.0.windows.1.4.g7e4058d72e3


