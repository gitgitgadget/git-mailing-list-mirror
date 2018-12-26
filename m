Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A24211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 23:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeLZXGA (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 18:06:00 -0500
Received: from sonic310.consmr.mail.bf2.yahoo.com ([74.6.135.253]:37217 "EHLO
        sonic310-18.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727231AbeLZXF7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 18:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545865558; bh=CcJ+uFKxIKm/3L9CCJ0S5xdsZ0iyjxnOTQ+N4kmgOSA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rgPiO4Dc6CsRWPYqAFW1YrW3XH/V0BLIhhrKIv117IJcLh9m81paAiO0pz7a8DvXsjKKEdCVzsa0weRvMjjGdfnoqy66EL1Cie6ZuRStY+6cT3j9qe+bPYxtaElvdsexZLltgsOIllFxMGFuPrw1xiseZiKapeCicwBO2g/qmqKLIsiQN58X56fwku22tD/i43WlWM3KgaTnrfTpyRfT/05WSr4EXse91adp9KULJUha7PoxPSWPeUm7MCakLH6Fa98hXXhbjJR8MQxa+sTuf+YrISgWDroxvV/u21n0+W0MRSeBruGgJJ30GiD3c4NjhJ4jsmrkFlDbV3W5CpsBcg==
X-YMail-OSG: AFYQ6h0VM1nH3kV4UVISy9ptLdoIrIU11SN6UlLfyEw0ZhLP1wLCp3Dfcpmm7kv
 Umb7pOI7ttqv2XoO3u.FMXhlNac5XxziXSrDOAJ3BIrzaAEOpcf1VLiZEyPOGlX24.LoBgYFM.fb
 g.fLOyP8r1.5Ajv28JWcR_iUxbUudDs9oHg_yQrWEl_5PxeA.kVUYAwwh3Ag_zpMdHwiB9WpIimV
 hsy1U_1o8VoTqsDgtohEQFhIkWEmyHWUnDNh4t3jsKtuneTUmH1WpmK_QQK1PZzxecENcg3XnuUh
 M6xy_SoxxAm07OEKSqynil9zL49L4v8hOHLgt9cbaITN1YWuOdlQhIaF1gQGAvHatY9V1pD.PJ1K
 YuJeV1W509OB8PD38aMde0yKPyP1K66X_cy.dFST1GAXDOF.No9gBg7mU81N.1o4VUY0TPX_7PEl
 r4w.cA1gE9zbwXqV__fYENi0dsNH9mvvkN8lEGya_fGRGpF3LsEHETi595aB4es_zUdXIEyyg8st
 lmk2uR.lMmDK2PjODnBZQmECKzXhViRihxACPOjsQoltZHlH3BVAKm_pKRHiEE1jFOtv6HspJhiY
 OU4wKQ6ASu25QPE4Qxh0wVY03EVheVq5bqxFUR9TZwiofnpEhpX9EAhNnfd9Ma6PHUJRZ.lLbnkc
 Q.1DSLvGXxYr_z2_RwTh3sek9bi1a9WilAg4wWpnerU8o6EHQFVmHzB7L2HtGjjXTjZWUstnQH0B
 DsEduyGcpqFYboDMnmbYmKNZKvGyt9w3FnJiMg70XPedJQkaOsAvGt159ToizCF38joeMl6WKkwF
 HCh_xTt.ojz7OhxqgJAO_C1vqPseSL_5dxlK0fAvVmEOtJTR_CFEgAorEJuJY0gL7gEZv71RSLaU
 JkaR1XTvTkj2e6AZL7ddcWheXhCSUrjriHOvkk8s5Y_rhmI4u2e5._YL88uWpOo_NDTru_nR4CM0
 y9aQHtweTm6u5CwTkZ3pXt_nNnnRjW74HBlZyDtJtYy0wGsHKUEk.1DXi3DSrCeTlYgLCdv.mt1K
 qQwPUYL89xG2ZmVL6.nBpXoR1fWOioAYm.G5rBsOltZe4g00xSPwe6z47JnAksh1cVpWbJ6qg8bn
 z6l9dfLZr34BcgEnRjjIjLthZboVJZXM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Dec 2018 23:05:58 +0000
Received: from 99.229.179.249 (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 98f6f8df7851f5cc32b027b3d2c09fa1;
          Wed, 26 Dec 2018 23:05:53 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 4/4] compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop
Date:   Wed, 26 Dec 2018 18:05:23 -0500
Message-Id: <20181226230523.16572-5-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181226230523.16572-1-randall.s.becker@rogers.com>
References: <20181226230523.16572-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The system definition header files on HPE NonStop do not define
intptr_t and uintptr_t as do other platforms. These typedefs
are added specifically wrapped in a __TANDEM ifdef.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 compat/regex/regcomp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 51cd60baa3..c0d838834a 100644
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
2.17.0.10.gb132f7033

