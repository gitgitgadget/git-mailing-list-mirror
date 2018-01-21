Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C711F576
	for <e@80x24.org>; Sun, 21 Jan 2018 23:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeAUXmV (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 18:42:21 -0500
Received: from sonic307-7.consmr.mail.bf2.yahoo.com ([74.6.134.46]:33066 "EHLO
        sonic307-7.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751021AbeAUXmU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Jan 2018 18:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516578139; bh=DbpnlxRxbblD3q2dg59SHbfKb5M7Hkzq93ykhOeN5yE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XW6keST/FiCULtui0wzS6kJObgsj0HM0oafOBc5BnkjElA+8j9JVcOpMAs7D/mvv9Wivtd/GkHEjxtyQK7sjeXmgJ77hOgPhivi9BE3/PiQy3ge/KMrOBPsDBq0eosGdrkaqEuSJS4zcDjfRbnuoyTUrrwi2+3Nek5Uv3p6UxuGkvXIbjLpP4YzOCFL90P82qvoRIh3EISskWGSA9cGsgXrl86VZrV9fFbBHwij5+2UoXVW59zZ/hRRNZvH1c/xSUTBQ5bmbgBNtnBLnxxalvsq14O/p75JAZ1LTNPGp5oHOUF0A/3wIJH9DqiJ/eoFnA6Fl4VbAUFZfOPwd+wULzg==
X-YMail-OSG: WvKQREcVM1kQ.e6Ykq3WPC5KUWOd6c6hHbHLrrdZ89wEP8LhwRD3E3Pm_CaxZ6Q
 d9qe52ZdnXXg4duR3ETjjqAZxH1nDTQmB1oqO_9ypoztoUWrRSaGnxbS_jYb.xQ_oTlVZcV_tE.E
 8Tva_kgdfjV_LgM_1O1Oenf.PqZFSHo5LvxhmWB.ut33U_PNrh_YDIG4hJHNR7r2HG_3EBYQmyxC
 Vq6bp4lgDr1m2udC1XOzlpsSb.jnTsMqQ9WPvA7lTIzUdjlh.MlOZTicyhtfZfwqhR_ziSrwhCrF
 NPTmsnnRh2QaG8RqusBR9pkf3X0csaAM4BxCM.zQ.r.yESg.EJLBG_LjxxxBORNWs2kA8UM4_6CH
 C._lG3NWFoCQalG8_a8zpfZx_QFWCGg5fmxxLiAHnG4nY2yAih1WZ2BlKsszEi3vzafAOM9cE_X1
 c4vCx6YBRfkhy8TwX4agGVRdCWlGF5dcbqeoP3zMvj544N_wxmyDHVfRXgAMUP6pYUYqMnyACCvu
 UovJ6XYu4S67NwAah9VYfSEiC1NXAUHDnHyVPE9Ye8riQWjMfGg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Sun, 21 Jan 2018 23:42:19 +0000
Received: from smtp106.rhel.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([98.139.231.40])
          by smtp404.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 658003e76b47aa0b456f7039861b9699;
          Sun, 21 Jan 2018 23:42:17 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v4 3/4] Bring NonStop platform definitions up to date in git-compat-util.h
Date:   Sun, 21 Jan 2018 18:42:02 -0500
Message-Id: <20180121234203.13764-4-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180121234203.13764-1-randall.s.becker@rogers.com>
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Add correct FLOSS (NonStop platform emulation) definitions into
git-compat-util.h to allow correct emulation of non-platform
behaviour. Also added NSIG definition that is not explicitly
supplied in signal.h on platform.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 git-compat-util.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531..fb3ef0dcf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -378,6 +378,21 @@ static inline char *git_find_last_dir_sep(const char *path)
 #define find_last_dir_sep git_find_last_dir_sep
 #endif
 
+#ifdef __TANDEM
+#if !defined(_THREAD_SUPPORT_FUNCTIONS) && !defined(_PUT_MODEL_)
+/* #include <floss.h(floss_read,floss_write,floss_fsync,floss_fork)> */
+/* #include <floss.h(floss_fork)> */
+#endif
+#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
+#include <floss.h(floss_getpwuid)>
+#if ! defined NSIG
+/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the highest
+   known, by detective work using kill -l as a list is all signals
+   instead of signal.h where it should be. */
+# define NSIG 100
+#endif
+#endif
+
 #if defined(__HP_cc) && (__HP_cc >= 61000)
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
-- 
2.16.0.31.gf1a482c

