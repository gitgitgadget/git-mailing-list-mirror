Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330CC1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfBQQfS (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 11:35:18 -0500
Received: from sonic314-22.consmr.mail.gq1.yahoo.com ([98.137.69.85]:45670
        "EHLO sonic314-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbfBQQfS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Feb 2019 11:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1550421317; bh=6YJsMn8fFRg2CpbhG2LvSj2wEnyFMStq0MjWxtlauZE=; h=From:To:Cc:Subject:Date:From:Subject; b=txVPT4Be9AIEiKWU/geGCzuAq2+gp7tjg4tO5rnK6JZ1+sh4LPutAyTf0QruiytmwYgVBzAvfSjhDxgLPddcQZ4p1TrjPdRxOWkm8luy5s8JPQiEiRD0j/knZZ+ZdlF/lWCSkAk1dqToL9/4mDG/Me/uEcmWzLk6v4asviv3pMvwbAS2RKSEYDe0/0KGGZpo6tH//iyrqllLJc0sHz0jCYj3LjclqRW0DcyQq3uFxlgEjV6L3kQraaO3/lCt/1oftBA7V5rNdk0TEA+qOxi2oPkNBFSLGxM8CDWeJUTdvPS7jA8cTmHDIeLvFzjDwBc1RpGHq/8zxz2zg9SJcjYmXQ==
X-YMail-OSG: w0mo_0cVM1lTAoaybVKdVYF2Xg1y9SaBWmaCPox1v_0QLDcsapHRl3D5pKbgSn5
 2Tc.G5bfjhuNTfypJkLGXWKf_9UyG_wZR3BfhfLyRDEf1Cx3pjptxI0tfV7Qa3j6GOHEP787MK68
 c7SeOvVjTUpnhBsMFDq1q6MkDCpuIAzKLIpaXr9NNH19TBz65UpwmPZX17haKngC0fOCBq55nU0m
 Lyg3fj5xh2_uFOrhemkNajgoOUCdyozDKXmiBfbGAZ_EC313FouMai90SeXiFc3KzI9YJ4XO5NJQ
 qRLGPprQM.KCj91yxhte42Ja4vLq0VZn1lMUHomtvzR.Pkwxw7Q3Ahs6L90QicjDpAvIrqEUNHyL
 1ESkY4Ysw0tmT._FY1.BJEiP5M3guWKkytBcCItxIhdVeYjQsuKmCM6Jt9crryMZuYU1IPDM9t6u
 30jK_fJ5jDn0l8WlPXGmfDCe1n.s1xOMsL4qkJnBBN0TyOCnxvnfZZEro8u4YdK00h81ugnqGJkw
 x3TQ9azEsaQiLPhCUqrT0gfaetlYPotncm.tk0BZC_WBxjNNmiqLEZvVYRpj1DpPaHrSS1kSePCb
 bi2_vc0o_.Dw0kKv8EjSWhCr9QtgLXRHzLvBM9JVhpiEGrPD1rbSD91EPpL6x1_EHyDH_hxCi0.d
 c6LJZOpaDGPuXZmGuKKsUqW8qgMAWJHSKqOzes92NQGWkA5kbnpQ34TKNKLZmIcfSAfpTThctKFi
 TC2xgWu4tVDFqSa9ueLHLEs.XttXiZ8vb2KEoyUFwYQMfSbpZHjuQJgPUgrRS5LGNu4AJyYulh44
 Wun_6Y3Mzkr7xO36snezjz1IAg2z7sT_42qH1PfAJSqYsI6DHatP40xhsmtVL34PgQZbHOOZ9CUw
 EEI9oyCEaxjAC7tl4xGjT4JausGhsaN3plBQTZ44JIfijSvADTOvHv0b_gLuLLtWiyflMJ4j0ToJ
 jhpAvHWCJcMOroKGxj2gdj9oRybefpXQcrOi5Gan_JmZ9DJsNeeiHF0t44DpgIpuYGapRzmFrpgO
 CHnA8W6_aVXAdVMqPnuRcQXmKdI6Igmb9c48p.w2EwSEzcBSj.sDmt7BfY_QWS77qUrocprb6YT0
 Pu0fhM2K8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sun, 17 Feb 2019 16:35:17 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7960f73deeeca8569531203623bec831;
          Sun, 17 Feb 2019 16:35:12 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Fix v1] builtin/ls-files.c: add error check on lstat for modified files
Date:   Sun, 17 Feb 2019 11:34:56 -0500
Message-Id: <20190217163456.17560-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The result from lstat, checking whether a file has been deleted, is now
included priot to calling id_modified when showing modified files. Prior
to this fix, it is possible that files that were deleted could show up
as being modified because the lstat error was unchecked.

Reported-by: Joe Ranieri <jranieri@grammatech.com>
Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 29a8762d4..fc21f4795 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -348,7 +348,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			err = lstat(fullname.buf, &st);
 			if (show_deleted && err)
 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
+			if (show_modified && !err && ie_modified(repo->index, ce, &st, 0))
 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
 		}
 	}
-- 
2.12.3

