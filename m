Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72231F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfACVEN (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:04:13 -0500
Received: from sonic308-14.consmr.mail.ne1.yahoo.com ([66.163.187.37]:42477
        "EHLO sonic308-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbfACVEN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Jan 2019 16:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1546549452; bh=T8xaeYFTK7epWsDIBhl0VcK1h5zBv5ZWkzIazS61kOs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=o17M+OWqMRn22B4Bh3TdvuSMslBipSMQYe2cZsWfZjZNuiobGyaZqnTnHoWX89uS/V4Uyfk28jOymXou37giRCkg/B5lxClzQyI8ki6d+X1eFGFeWKXbNUnCsIIc4uHlPx0o5WAjw/18WZDp8I9yTlFoQM8IGIqQdL48ZocwWS1IGYAMSAf5efut+X61S+q+aCJyIaxCcKQfIeqU7CBo2x+kVChy7P/GCZFc5QG0EmLiC8vdtle34mpxhbbDLV9urnjKJEHcEUoDP6v2wCgJ3mEDQedsL+n3o6/Drca9rYNGPVUJXuMjI6zOnXwa9avJDb73OY5eay5XDzlDKjboIw==
X-YMail-OSG: e3EjWxYVM1lidpYsKqN9I0E6iOGzMAht0aetrIMunHFul1QZvFfE4mrrdKw2eX2
 5mBI2k5hHPk1WzHaQKnSB7krZllzxxWzTnF9TmTYdm.mGuDfe4chQl8gMhA2JKDga76Kz7x_mlS5
 NspQ7gSaHwPsLIGSjSj3uw6udkllXdgjR61QrCunKS5pWfoAMjwb5HUoyuEnRJ7YTfgE3jHqTDV9
 aEGJA2Z725RzzIUExzfxom6UqKNjt6Nn6Rrz3NvdLOPjfKhSLjgSaduQZJKkHSTH33FMidgh_8mn
 NXgFqv7R1lYEVMVYAuOeAkUFtA_xJ__IKaAUd7KA316pJTFZFgNN.EF5AHqhhlJwCNKEwquN1S_F
 7z8XxRCTlqmXs2bKPJW0IvVpTfJudXpsMDTT.8.PbMh.WCrQWwshpsVuU_zqnHZgcMN.a90UuyD_
 tsn7DSMG9waD7Oi4mf5YeQwdw1YXNbb36sb9LshQ9nhb9mOsdN7P0k4zxeTN.xyyLHonKky6R7Zq
 UHLjmeUxgNABUQtF23RYnSzd4TG6VqQArzobzBjPEOU.DvPLL2YwfL4q0KQ5sFix6xdxK7j1Q03q
 YGG3Yi5skOYrw270BSrhfsZb_dL2oAHBsIQxruiMndfOFahz_rX.ytfkxYU1zeCnadr5Z6kkt3im
 Ivzyf0MYrFdoIhuTYOMyNhIhFKzouSu27x4oYFttD3kl2MXvTD_unSfMq0zrZS_EgscUiDw6W1CZ
 AyE0reEVQ6GpDdqL7KoQLpu4AqTZCEhXOsjHCLwQOfAC_MEP7Ps0s90RLQ8A.GjsJ3davNrKWD7n
 tYTIPwCVAL3U5mI01m4Z8PWkc5dnTWWcQohBMv8EMgDv9oyOAl_Vi7Z0ZMIGtvSdXwVRBtZXswRa
 rOXmuvGNQ_9wSSTJnkXo_TMeptH3xoJ4YkcN67gOVme6vQorrYsPMUrYKuCdtNBeMwa5qOx4rCzT
 r4G804S6wRDp3P1X0VcC3L8GD7N48GEF7ko1_skO8vNNUKueMD_vTy7avqkIyHDdjO1CgJ1yWzTq
 Q1QlyfR1WIyOpONVomjQlrPCV0rGMTri2jx75BFJNXekyHx8aa5Uvqfv9QgINCG.S5NVF0RcTit1
 e_nxvUWpESO87yP.2n3oZ38YESYlu91Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Jan 2019 21:04:12 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be612531d29230a92e273a46c8c0f700;
          Thu, 03 Jan 2019 21:04:07 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [Patch v5 4/4] compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop
Date:   Thu,  3 Jan 2019 16:03:51 -0500
Message-Id: <20190103210351.13920-5-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190103210351.13920-1-randall.s.becker@rogers.com>
References: <20190103210351.13920-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

The system definition header files on HPE NonStop do not define
intptr_t and uintptr_t as do other platforms. These typedefs
are added specifically wrapped in a __TANDEM ifdef.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 compat/regex/regcomp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 51cd60baa..c0d838834 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -17,6 +17,14 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#if defined __TANDEM
+ /* This is currently duplicated from git-compat-utils.h */
+# ifdef NO_INTPTR_T
+ typedef long intptr_t;
+ typedef unsigned long uintptr_t;
+# endif
+#endif
+
 static reg_errcode_t re_compile_internal (regex_t *preg, const char * pattern,
 					  size_t length, reg_syntax_t syntax);
 static void re_compile_fastmap_iter (regex_t *bufp,
-- 
2.12.3

