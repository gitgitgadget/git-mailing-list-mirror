Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BC0211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 15:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeL0P6u (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 10:58:50 -0500
Received: from sonic307-6.consmr.mail.bf2.yahoo.com ([74.6.134.45]:36389 "EHLO
        sonic307-6.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727086AbeL0P6u (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Dec 2018 10:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545926329; bh=SPeupn2Q3Uq+Tsf30AHkAyzHx3Wyw2PRezoignksmI0=; h=From:To:Cc:Subject:Date:From:Subject; b=sNkHlyGKpOwO3/8dbkoSix5tFQr454jbFJNZPxyS4F5y+aD76xk0tMjFNwfKmEdhxSQKuIvuP76LpfDlHaFn2H6AOPBF9UwhSwcGXRox8VwQHl7O9jKB7AtahHfuANFUxrhl+I4lLNBdD4TklxCPcS/2t2gWMZV2foepVDf63Pr9MrRUUt6704Fkot6DgiXPxqbSvJM6BfLYqT6BDzlLuF5Vo3m5SH80Njic+xrLEBwEl3R+3Y+GAHw6f1KEj65xx11MjxS4IypFAWRXd7nqFrpinP1oUJiYC73o/7pb/nWtdRAer25U9bugImTiHJ6CCe4RPHf7xsMLJJ+BQQUgWQ==
X-YMail-OSG: 0iA5pRsVM1n5l1RmNEi8mjJrFz3VYYLRAoRZKly6xPcoVvbSuMM5a5ZC5wPRECI
 pDd8pnFl2jmSCGM34Z1FJ8r8.w01C5lyt_PUECmuYoTC3vhAxbjs66fRfu5ZAAzXDM_RIcQxZPqR
 RaqdDKHVfA8f5owmyunALEu5Y9ToJdJuv9jNwM_LLJkNiFYVpPKdchJWcCJKXQ4nUX1jGCcAB4MC
 s1MCw5GR4Lw6MmmfL5ksYvSbBx3H7qz_DZ.V9id65a.8pD6qUwoOom5rBHxhZDJMIzXupooWADVS
 cVhCUrfmO5yMNNjKuSGrHJf6.sLnlEXrEmOoLsYmzT1fNyYnvTwd4kMc1SkjC3XLfllbkFhZ40Ke
 jVNNoScW8hd8ZBXu4jOgyIRwseFn4swENCaIoi0p65k44yd8QwjUYAfKj53eW26algcvoGtCmhHE
 ..J7vjd9_joMePXP_n0fqXa4GLzQdcpvVnDApRALEZdoSmuE96kqY_F8d13vx20qZTMVLk4JFM3p
 c0n9qRPKLbWSINuUwm84c5hNH0wutTcV.ynjxMK_sk93va9_9F2QcDsqGFWTlmohszGVDuj9o35X
 pmYmmpB7J3pmjYJUyw9HbLeMK1CIRS_3YH0kloQAvYrxj09pfqJ02iWRYIXJzkV29EVIDdjhTYVV
 mnAxbiMn4Oya.snc29EMEmv2EqUQc6NE3IxbzpRzG8Uam6il01pfBggCKq_zI_BphT.8w9qGFpD9
 ryYCOPd6MfDWB7CAespSUrfpRjsP.Px3FNR422VpDcT2LaGsFq8h3bhYSShiPFHWBebOcK.OmH4P
 zsPDWJ.BdvN9gjKtcDSUqJG01O03.BeS22qQ908h1Z9QQWKswEyQQ4g9WP6O.Or8mJ_55iu9uY5I
 TYJ.JhY2GzJg_p2dE7Oh1bE7YFhzORav9DRjqSLYasHgYc26UJBoF1Q1bqFRn788O9785qgd8Fu0
 .E0hH8jEcM98SvUfnNGaPr6vz85Xb_hwxWsPodmKQuZEXDqGOa6QtOJHPujY98JAgsr6pP8CmtW0
 CZ7Ip9JcuYpbjuCtOqh_0AI96RWe7qhnsdaSZIQJjv.Tf.5PWTseStPIGJI848qGWw7lvyJO9sqI
 XHLoA7NUgwM43vNJnhAsMvGf1zifyUUyM
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 27 Dec 2018 15:58:49 +0000
Received: from 99.229.179.249 (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 38273046f8eba034b8388e4413b9797a;
          Thu, 27 Dec 2018 15:58:45 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 3/4] git-compat-util.h: add FLOSS headers for HPE NonStop
Date:   Thu, 27 Dec 2018 10:58:24 -0500
Message-Id: <20181227155824.12232-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The HPE NonStop (a.k.a. __TANDEM) platform cannot build git without
using the FLOSS package supplied by HPE. The convenient location
for including the relevant headers is in this file.

The NSIG define is also not defined on __TANDEM, so we define it
here as 100 if it is not defined only for __TANDEM builds.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 git-compat-util.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 09b0102cae..3f615f7ed8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -397,6 +397,21 @@ static inline char *git_find_last_dir_sep(const char *path)
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
2.17.0.10.gb132f7033

