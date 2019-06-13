Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC72F1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfFMSx3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:53:29 -0400
Received: from sonic301-35.consmr.mail.ne1.yahoo.com ([66.163.184.204]:41966
        "EHLO sonic301-35.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbfFMSx3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jun 2019 14:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1560452008; bh=N+vADfmMTE1hyUfi/f/YAZvaj5whf31Kn01Thng1Tm0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eMZXMN1V2LKk8Zjz9WYpjwIpPPJagm+gq8fVo/QNSUGd8xMp3fnwkprE4JUhGRW6oGqhAdoJzrPsia0pkNxcLFifS2jl6WZlNZK3xkEVpeY/oPPZ2UHeU0f8NiY6UufLMEI3SH6WsqHHMNtM01ymkfHLROTcL0+cDXQ5oL67ZXKCJS8ekFI799D9l72IC1UNHSHGriNBeD6FEvqOlbZsKP7AOXrDzCSDzHl9m0drwwl58qe16Ti8Y/TCzZn0sUXOvPQov9V0bXPK13tRYVjC0uE54slxAj8efvDQG/bz8EeIcM18uV1sv6hZC/PxYGMclXFc6qnfB8FwlO2n596HCg==
X-YMail-OSG: LXgC9ycVM1map5ziYdy0TfVVsh4QMNBc0IccBn939Mv92.p5u8h89yZASlULXVu
 GThc.h0Vt3GjGoP93.eM..FCWQpFvDOrexjucfTt1pnFIptvFJ4BWX.s6zxGYaYrGfpZ5yiJp40t
 K3pMMIxn1z0psW3SkzYUECGowPWomAUopZXkcwFVcN9u65gBo1AeiRBm2mMWleamEm8xU9gdrjvb
 m70kiZ.nBTxEqgnSR7B9NY5iBhIMZrjhy1kAf_833OjJPWJl116hQC2vuvxZKc4S8_qvELxUPokf
 g.60uBcdRTAcWzqZlTtQD8EwFeJ7pDk3wO2qRilgNApmAQAW0P9WhLCgpw_EVrIWKtPHdpEV8wnn
 0IIbGPwLqbn9mSS2uRDqV5uBu9L4CoTDsibsNR3WXhbOBxIWBMrtS.dvTnv1P86z0IwkBly0mCSN
 3Q2CMeLsy92cnqu1N_D4tDetQPVQVOaEjVU0ZvE8i3iS8pfKRHG7Xwn8dbutNRAqnV1guNfmA3bI
 7rYTnVYFgbYnvY8FuY.rYBxz.UN_AVpKOtKroPY0DUzHRTnu8uPi27O3D.SaaJdMqJjIcNWmId1r
 kaBBRj_QSPGqfXo4lKsz9hb4g35yiZQBjObC1xqGS6kmWKPLWI2FytCyoNG48BsaGIWpIDemxjy5
 iVtKicDPAtPpFilylOynaYzVDZCNP9ZltXwSUDGh9ejGhOldd.NoEoEWGZ6fvhyaicq654k5n3DE
 HuAj8BqUS._4nCBmBa1KWI65HQddxdsUI3QqxjOGoo.UwJDIPftRI2Mw4gDNV6geQYVXJVJux94r
 nWPcDXCDUnHhAIgig04Jk3GviFs4z0JtHo9rM.Uf.uerz0foT_BrHBGbWvSZyBf8_xcPtWQjwtU_
 azV.moloac3zwekwX9JngP.Pr755wZSqxYfQPQdFT4SBzg3ISmDm2jHvgwAdVKDsFtNbavmdZYuL
 zM235fFQtmGO9ACluEd6KureC164dPq6R.E1zCmulQ0z2k4CglZZ4F8aqK27QtY3fDRkSU_jvFVI
 0MA5Iab_Ziem1fEcvu6d_F3Ci4BJh6fk.wA77sf1zKnvuVWwaUqmNAjX9vGyuCAbVYySW_Mj30Pp
 xnNCmHgMJ7_nN7YMWS6P1IzBN65XqkxUB0hfbd2AIUa_Y5E0iPM05U0UGxFM77ZJ1EfBB7wlAAfR
 p.6GKdchxeJqCAcrkE7ijhUAKYSeTj0u7T5OUZct946vYAgA1c9mza5aE_6wOxSBlxkPCcIJrDgY
 expCjWdoW94kllo56I71EMGzLz.pRdMcQsN9kxG_y
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Jun 2019 18:53:28 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0df5561e6e714d6e0f0f0c310b112dc6;
          Thu, 13 Jun 2019 18:53:27 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 3/5] t9602-cvsimport-branches-tags: exclude test if cvs is not installed
Date:   Thu, 13 Jun 2019 14:53:11 -0400
Message-Id: <20190613185313.16120-4-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190613185313.16120-1-randall.s.becker@rogers.com>
References: <20190613185313.16120-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The t9602-cvsimport-branches-tags test requires the cvs package to
be installed on the system on which the test is being run. The test
will fail if cvs is not installed. The patch checks that cvs is
installed by running the object without arguments, which should
complete successfully if available.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t9602-cvsimport-branches-tags.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
index e1db323f54..52e8507725 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -6,6 +6,13 @@
 test_description='git cvsimport handling of branches and tags'
 . ./lib-cvs.sh
 
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+	skip_all='skipping git-cvsimport tests, cvs not found'
+	test_done
+fi
+
 setup_cvs_test_repository t9602
 
 test_expect_success PERL 'import module' '
-- 
2.22.0

