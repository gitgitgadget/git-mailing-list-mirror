Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957441F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfFMSxl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:53:41 -0400
Received: from sonic303-25.consmr.mail.ne1.yahoo.com ([66.163.188.151]:36275
        "EHLO sonic303-25.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729308AbfFMSxc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jun 2019 14:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1560452011; bh=Ase6/uBQsZoJVs4POSXVEcJh2F2P3eyLZ2MuL0+CgA8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UPneUMveKVT29Dtm/UghUV7FXB7eWkto3XdwgB58Ng8PnYAACxRO7Vz6oiUVkgJr/UNOQN+fSB3lzYPD7XuCUrOgy2SkxmRq98mnbzDZAEPApTvg/yWjQIQ+a7E2v+7w1sPgWjnX9p9r23jx/K1AxxgJnEqGxJ2dN9mbEMTzqSOzELsQo5+1zD32lg7Y31NLH8FHmPa++CDGgD0Nbjorpadq5ZHVuUuZ8URv9rk9HgZpYiyd8GNIcA4SiVSORlx+N6Gv3/NjuEzMLZaJp8CE7FJyWmjjtPX9bqw587m3PCfenQn0zMbhdOqsW2bhrnk9JiwLvKxbj1wC02K1cpy08A==
X-YMail-OSG: wvbDHLwVM1nC_LJOYaOG_ERKXsq9J914SpiEWIf7k9qBwmBPge6Owq_k39RPcLf
 .hyEQfp5AbAy8zpfEcnrjnNCxo1bh690wHr.Hz8ejlxpso8XrYI1EEvVofmTeLWm8dbORB6L.R0p
 uQxeo9lWIlnYFod7iyJ9aT5lUQ3tk0Cc30QiRYBzlI6bQvLpY.QCN9B7Ch8kIh8rGjpzli48AkOp
 JzxsX9H9X2wN_bwamIKLN7R9S9Eq0TkrZR4K3d6DUawBFjnXE9wO6DMjquH7n7zEON331qNqPlWT
 NzHbukkjqjrD80EaIlZB.p1JmwDXdVfMY.i8fDXlJt9mfzqx8_ZbvTbzdyLGiUwUj2jck.xoiF77
 3lNGeTf6kj_r8hMlrd2nuiiofLLmEUj4AQruWC1JZcwQHzhC3GCMBYBxFI2sTwZ4JWjW2_g9NHMX
 XUnD05uQ8mnIjiekqYReLcL8k1GooSIFC3zk.kIzdAaV9Y4ji.TedaHV0yKi3zB12uvBHoE.ypMn
 RJERnQq83uuMTHPSDJDwGp4Ove0H67Z_82f9WyONB5Zvg7wdAHQ9mN_5jNWaHJ0nMYtEzQg51fai
 KSrn64WOCStwcY_JGgKNjoKLW7ACaH2av.V9OK4rFNez7dHJbO_m_AUqyf3TDmn9WNXYCcY8.IsB
 1isvi0XhD4MW5nHsRvLNiDQcJBj29UBkwCpQORfsfHg9nnxww55U94z_5m0JVxoGfnFLHCH5Ko1O
 _3l54DkpUsk9sggkEBnFufhxYFYWhLVhXrZfzcpwR.CXNcQEDA27VWWQ0LVkT8QkLPbzDaPgiFVb
 ZvbbEpUNJR9gvDq7VSuIiJvkK4VRRJ6xB8xMBPbGO9AmvDu027p9Sjwk27QrjRL4ojdM8CmJY7uv
 qVoLaYlwTfG7LQ7nB6uz0C9HkHdReqNZ4U9VNWYqqNlvZcq9o8JPJZz.bNa75AXwgoQAD5Vkmfdf
 fSXIKIGKFzbfasCNuvlj6uWNDOpV9BwglMF3saOKYrCxR9oXKiwLUYFpkz.ga93cf7060W.pXQLf
 cNJYKjxyjDxy1yzRfJhm4Pp.2O2SG0UJJN.LrVwPPjJwQhcLl0TVYtNnqMDLCriTfIDCZDfTW035
 71VI0C4FrOh8u2MN3gglvWm_d6kROFr3c.dbRhuDwNkDgB3zf753T3Ut5Vq3xO4FuOqDnAS9K_Fy
 e7yRXKaHwXHKDwMYFDl_TetLbkZbgJ2MJdDNORx1Cp.ynrsjhqvWPYfivVoRSZs4vhrxJg9vQqSj
 hKrgptSMH6qO_xxS5ex3Ld3V4V5N5UE3Onws-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Jun 2019 18:53:31 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0df5561e6e714d6e0f0f0c310b112dc6;
          Thu, 13 Jun 2019 18:53:27 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 4/5] t9603-cvsimport-patchsets: exclude test if cvs is not installed
Date:   Thu, 13 Jun 2019 14:53:12 -0400
Message-Id: <20190613185313.16120-5-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190613185313.16120-1-randall.s.becker@rogers.com>
References: <20190613185313.16120-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The t9603-cvsimport-patchsets test requires the cvs package to
be installed on the system on which the test is being run. The test
will fail if cvs is not installed. The patch checks that cvs is
installed by running the object without arguments, which should
complete successfully if available.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t9603-cvsimport-patchsets.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 3e64b11eac..354cd66400 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -14,6 +14,13 @@
 test_description='git cvsimport testing for correct patchset estimation'
 . ./lib-cvs.sh
 
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+	skip_all='skipping git-cvsimport tests, cvs not found'
+	test_done
+fi
+
 setup_cvs_test_repository t9603
 
 test_expect_failure PERL 'import with criss cross times on revisions' '
-- 
2.22.0

