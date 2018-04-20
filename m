Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C7D1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeDTWYa (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:24:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:52509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeDTWY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:24:28 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lwarz-1eLviZ0XEN-018I7j; Sat, 21
 Apr 2018 00:24:24 +0200
Date:   Sat, 21 Apr 2018 00:24:07 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 07/11] Deprecate support for .git/info/grafts
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <20b6b0cb61e0285fd586dc190a0a96e642cd917a.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9ntz0PpEc2rTmYX9TlYnZRPdAdlxBHSN3rWapQFcTRQUb9C9Q/8
 n1PK1sM00d2fmCxRLygyadnOg/GHjYb0IOK+A5IAOVWUlWdw/OOgTnRxncvsFE/mATOtsd9
 8KRmDsaH3DJ+PJJfDZaI+2gZNEPODO8FxrCDTj4wkFZt1DzkCRjhJFQJQxfYPu+Ezb3TuYg
 lH+ci4G/7bCMF0vdLHgWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eS60eVNcw5k=:/52iZbQ6Iw4imzmdipzY73
 sUKYBjfB9NHRWgLCZ9KlEVrjaOOUeI08vrgqNhX5PICjf2bUAYeLNLs2HdNtQPqufxUDgHlyK
 j6k4bdjzKVrGmhifLwFBh2aXJvqCyzFrdPwcTYnZXckuSQf/87Er9lmEbVFcmPV1AXZMJI2sx
 H/ucaoJiQIIcHcg0h7KHgRyOkWmz19RcNjZwXQynKincJfN1eh8/CJuFbOS21FZV60axR1M7u
 ZEl/8D+ZbJFIEGijOYSPDyOo1NXrEPa9aUXjJQT2TZJl8FzdiPEc7GtvHI56y2xMd0auggWUm
 /MVHKo4O/XHHrG4Vc1ko75nFI1ZCean33AHqjoEJmIN+5FVzB3eLgSoOK5EAa8XbMGrfI2DIW
 lX/+QJNxbVPTqRgp4ALaYq7nk90WT430RhBpaO3mh3StRkbqkydJF9gOtj2np3xU4iK7nRzN5
 fjh2ug7agK9Egpt8Fz4STo7rkKE9MJHPhG4sNWtjIVf3I0sx4CdMigycsDUyASTJiOT8Gae+a
 W+n8DfOFehZvSdEmjgvJNptSb9B4eLvOc9B6rwBQiNNDhkP94Zh+hRG+csA3EwSZ1dhtGIFUK
 1L8cmlPlev+/Ltm4uM4eRslxdCxucdX1xmSh2RmProGTYnI8HYK0bsl/D1huHunyPML6s1KFV
 NAqwfIZ4IpRbbY/kHMo5e/BtoFFTH3rIgO4O+3hWkTM0siOLQzsAhquEJrLmIKykNdWr1NlW5
 0c/KhYU5a9Q4NHDVqv80acM19uIosuGwnrfGfXXDOj4voXJziYAE5S47JCkqWWOnrgF6NGDGX
 32KTP2Hu8nEUhR/Ut6+Tz74e7NU038Yy7UjgZW8JxylUH0h9/8=
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


