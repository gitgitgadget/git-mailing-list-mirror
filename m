Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070401F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfACVEM (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:04:12 -0500
Received: from sonic316-24.consmr.mail.ne1.yahoo.com ([66.163.187.150]:33157
        "EHLO sonic316-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbfACVEM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Jan 2019 16:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1546549451; bh=NVdjon8fStj0zsSg+yvjBzuukLOeacEyj3LD13Sfuvk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=r7xjj3ObZVTVclnZ9MJgoUHmOKoGimWCE5dWVYFg+dE1f0Gvm9B4FCMDlyMU7RsyqYHK7jehB+tBMNQHzXKNyUGfZoo6/C+JeqrohDI0LaaYpn8pqXe2bpCH86R9B/WCAZG9bnHrImckPWRM3HsQXiqxvq8XH72NV9svZHvlUvvy4RsFPt/WpiHfbZHoZ+3SZKoOPizlR2YXwMC0njVGeOdCm0WVRK5MABcKgZkEtvx/1U1QTwx3bq+tZaFwEYG2O5DLuBG06WnKNDoRwQdfmNxZbLeEZ0+jDf79HB/29VEcsa7rD52TjTtKDWFHsxKSsj91Gq5EOtyfw+pRbcs46Q==
X-YMail-OSG: syso4UkVM1nEuyxVCUKt_yTimXf7jQooqC5nJm0Q1sKoPnj61BtwaDWCnL1mwCA
 ALZtNvkmHfRoa0HbnCwhwmAEFWfTmc2Rg5svPamrpTpycF0GYu7Oa1GxyLLL8oDo6v8OqEWkQXF4
 JIkkOLUyMsZ9M0UynRCROjrXvU4WQzHV_cqUi0f3r9x.8l9boNznOhxBp607XDyQKXpmnDCfryvh
 BT3CtT96Y_e8F6IWok_u3.BRlIe.4V4Rk.f9ygH5JlbH5.eyG18XnrefOmxIi1YAIwpydzqsG.ZD
 38bFEnbBkcsrg9U5ARCrJssQWHf2OgkW9QkCEZXtxtGDYJ3i85c_SFjajkNClQI8KMdefY9k2vr9
 jEabrRAO3fMozvDqdSV9dYqLPAvQiV5LNFjkDFq3pwW48sPLcuwmgsHm3m02ZjH5XQHhAQdKySeP
 _nVFiQNplA6U72bJJJ2Fm5DTwORNEQG4sXXqTdQLwXgTbtPriNv2QGUXx_xN_bpYYEzqvZqE5l9C
 WNY18c_z0Rh5DDkb7aO3wh7ytaomZvpKA0rxVaR1RHcdvcGUooXwlOyS2zcT8LtzRtQLWc.ip5ea
 FRlGp3eU5AW.010jtopVsN71xiqSc1az8uJimaM74azVhhL3DBHUB79my0Uolyvm4Fq7KN7HP.oQ
 3CjpzDY3KHbuKL1sLkgOJlCwc8JSVruoG1P.KPZgMzTGZrx9Nr703kF6NG3brV6WIfskTfiQKrKM
 3gwmQ.JzTvDBRquglxrDHy647hpuOG46E69JYtRePbQGraHG8yLpWnIjlTVGgKIRhuX8rcOieUXo
 w.XNWsu8GeBoys8LzkAaI4oxvgz4i2t15ugs_FeRXsxKlIwC_hzzGsBeoqye6Z4HwmAvuTqbtWVa
 7C0.LevrR9JhluVFJdmSScEEwgROlrKqm1eP0Tw8IytdgonfKZnV0nKQuhe4XbulNYSaJrdrsPbn
 4Gfd1XD7dqyT0GUSPpA.1JjupBx5z9SGsiah4.ypP70dA5TRWg3YRzWbWgfgUtH8vXq8cHvIaDQw
 j1iJCMachXR.lzx2JOh6QPbwCnS2yu7ckivOzrjp_8SthLCBrOG7rFaE5kXbL_BEZ1UqaEzRK7XC
 doHzQx3tnu2I20dI268leT5wYapks
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Jan 2019 21:04:11 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be612531d29230a92e273a46c8c0f700;
          Thu, 03 Jan 2019 21:04:06 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [Patch v5 3/4] git-compat-util.h: add FLOSS headers for HPE NonStop
Date:   Thu,  3 Jan 2019 16:03:50 -0500
Message-Id: <20190103210351.13920-4-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190103210351.13920-1-randall.s.becker@rogers.com>
References: <20190103210351.13920-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

The HPE NonStop (a.k.a. __TANDEM) platform cannot build git without
using the FLOSS package supplied by HPE. The convenient location
for including the relevant headers is in this file.

The NSIG define is also not defined on __TANDEM, so we define it
here as 100 if it is not defined only for __TANDEM builds.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 git-compat-util.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 09b0102ca..3da6f0673 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -397,6 +397,17 @@ static inline char *git_find_last_dir_sep(const char *path)
 #define query_user_email() NULL
 #endif
 
+#ifdef __TANDEM
+#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
+#include <floss.h(floss_getpwuid)>
+#ifndef NSIG
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
2.12.3

