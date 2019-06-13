Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93AD1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfFMSxd (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:53:33 -0400
Received: from sonic316-23.consmr.mail.ne1.yahoo.com ([66.163.187.149]:40103
        "EHLO sonic316-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729293AbfFMSxc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jun 2019 14:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1560452011; bh=ViQTkdqKJDIcYKJ+eFSTDxn6kc0bb6QhC55b17i19AI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=M8dy4Atpbx0xwTdeWAOStIQdZNdYevkSQUvaRsEvxhwxW/vqV3JcN/RfGyuK3S1IlOpWcbXntmV+4e1XEIPvaFMP39uRYII7/7Kce5Gp8n3eVJIDMvcPQ6UsXlY9FzP4m9yfRLVwffkyXMYsyNX/vRUFMBAmEffJ1QFijztYdHFwKdSlLlbBkFyOe1R3TsJiou5CLzmDqJaj8x6mcXd4Z3DlSkK9eCbYjRZhjCeEFST2RAhQVPGySChONNBziNy7V9N4YMczO8ptz73+2/3kDlAidkqsIDuMPrMqb9cQ3tfdtCbpfVQteH+63tZy0UnHPs7yyi3ELxlh5RdouW+Uhw==
X-YMail-OSG: 9p8Up4gVM1mkPGrLKHp7im.g_12jwdrVE1osv8H2Jf0HrH_yMjVKlGu1CGAzY5J
 tT25TlbF9cJBdCOY7eXkR1yTStjDIoqsV32_E1KuKlmSNvnvqa8itbMPGaq0ov5Ti3EOnKgwSjSx
 3YjrMVyBW0jjV4_g3GwTt88ARjdK3M0GH3rLrQbgv.oVCXYenWKkegZcs07d6_ikjud6gDYyamm.
 yKvKkS_qmt5K2hi1ftTYJnbrfmkldbPQ.BtnDiCs5XzRtSBKCoCkZUZfb94hTfIKb9OYZt3aeJr2
 sGY0UztqZ1EM3fAtOOgRzJPqjviCQCU0FAgyjHAj0b7SJiA.9RGO8M8Yk2Qj4ULA1LkgRtN.jArv
 EFYKpSMlfT2n254qwi0XLSbwY3dC7kVXbwt0.2aYWycJO9SgfqeXrVdb6fWv89ov68lttCxjWHjO
 a7T56Ug9ZORnfyRw8dBGH33jSpeN0QBawZvYKG2tdLWWE8kHwLdsLJLa7g2E3swLIFno8ziskf.W
 pCE2UnCzYQnTTb.CNdc94tJ6fla3mLBdaKOPOmTtgn_Smx44K6n_JQFE4J8IKrjX48rxjPGvyH_q
 _P8e1JgUpyNpD.60uz5ZFhySQwI5Z0UZGhJkp25Xn4GpE_uWsC1_fUFeB94r0lxhHzjbdX84.g6n
 pXIRYOes0CD_.hVI5sna_ZOd2gSJWTW4J52vpby9VkllLV4c7qycjbKI_eQz_f3WYAEMAmNquYyO
 .Oiyzu0iAz9SWmA83yiwaScBArwqv7PYLE0pT3zMQgAfPr_.WKurnbqfLh27BYb.QioSBMnzmVBh
 JLBI0af6nULroZgcSNudh793uYXJlQzkWvgm0yyZYhyMtc.P7D4iAHDcrnYOrpPXV8e2RNfTbgcl
 kbFWZ4yQ5XINMPgeD2zWvNif29dGjAfZ6OKuYKayMVDzqIoqoWIf3oqWRfx8c4.B7CMuCv7oA3Ho
 5_wrjMQIbRSobGsc2jxvMp0nQxKpnuPU8OeIiwRk8aFDRtv8.aBHho2L2WBxFVhD9Jpd.KnrgET9
 oAusGd5YVFqz9TbVL33uH1VHKj8VN1dP_ZRuC7OGeTDLZFoBYONmUH3WY8zLORuGfyEZJ67_ys08
 UQBbwsUZHLwOBAocyTFOGFHPVh89n6wn.7ibs0OMDIA9MXRZ_N9TC0ngPaSvLMT44tT9DOxvQc27
 dNEJnR2_iGKTaBmKG9QNqoUymFxLLpwuJlraoXU.7xSa.3vA74u3mTz3n7sU0RVZaOhYY0tIr_Ik
 2Ihg4nqqVXOroC1U.Akp6KH_.sXRzYcl64.IKtos-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Jun 2019 18:53:31 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0df5561e6e714d6e0f0f0c310b112dc6;
          Thu, 13 Jun 2019 18:53:27 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 5/5] t9604-cvsimport-timestamps: exclude test if cvs is not installed
Date:   Thu, 13 Jun 2019 14:53:13 -0400
Message-Id: <20190613185313.16120-6-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190613185313.16120-1-randall.s.becker@rogers.com>
References: <20190613185313.16120-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The t9604-cvsimport-timestamps test requires the cvs package to
be installed on the system on which the test is being run. The test
will fail if cvs is not installed. The patch checks that cvs is
installed by running the object without arguments, which should
complete successfully if available.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t9604-cvsimport-timestamps.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 2ff4aa932d..1fbbd179c1 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -3,6 +3,13 @@
 test_description='git cvsimport timestamps'
 . ./lib-cvs.sh
 
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+	skip_all='skipping git-cvsimport tests, cvs not found'
+	test_done
+fi
+
 setup_cvs_test_repository t9604
 
 test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
-- 
2.22.0

