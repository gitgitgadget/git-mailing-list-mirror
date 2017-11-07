Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13B89202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbdKGQbU (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 11:31:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:64768 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbdKGQbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:31:19 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1SLt-1f4c4w3vjN-00tWQi; Tue, 07
 Nov 2017 17:31:16 +0100
Date:   Tue, 7 Nov 2017 17:31:14 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
Subject: [PATCH v3 3/3] for-each-ref: test :remotename and :remoteref
In-Reply-To: <cover.1510072200.git.johannes.schindelin@gmx.de>
Message-ID: <bf51292cfefd495ff813fdf638c51f6b7acfe646.1510072200.git.johannes.schindelin@gmx.de>
References: <cover.1507205895.git.johannes.schindelin@gmx.de> <cover.1510072200.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lkdnC7sjValG0RZFW25QZSGrEANZaxJbrDWM21zQJynkbm2LMcv
 TJTYQQlH/ozixaY8GpOl/zGDB9zrYJWiy1UAOj9TILziQrI2atAOFpc0AuUMGBGsX+6JMzd
 Kxo1NGboeu4yGKfW1v7z3cGVo0861VQHnNdzhjYJK586PhOoRCFZaosU+2qEYRF+tL7Zph4
 jGGPigkfskYBxfwJ/JgSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bR479DqMFY4=:e6k3glqkSZ6/ItVBJ7kk2d
 4Iaxg3ICOFBf4ZLS1g5Jxn0ItLypkHUdUrUMDn/FniBmELF7gMfL251Tsivp3T6/OT0BdlWmb
 j5+21yDCsZjI8AYJVwK5EzNf1rILBZXPkyMl2VcCDOJpwjbyKOhtkvr4Nt0xaXZH1yRpUCGb0
 lBCt7zB4ZyaWFz1m9rIYyYsvtjGZGlIBz099RDqwdyW30GAgbzCbH5NTthrzXwLjpeQjWnYKW
 IJsO7OwRTxQUuqfJQeYWL4QNxayy03W6/nJXvsXwhU11/iFN4OnOxTVdLt0Z3Rq219bjT8Bho
 5/2pSuwH0dybZvexOlLb2o9X6sHitIns5cpHPCWS0eJ811w/hAbmvb4jSk/A4Dl2IyVc4SzRg
 4l6D+pbuUg1pYKb2yQZ0Y27k7z1TlQPFFDiBKZf7Iq3HUAbEjryk1/mv+wHLF5oSj0smDsKtv
 h8FcoPPJfHtmc4MGWZCeHZ/EwQ73xYpNhd4nKbo9rM4AyUQG3JZ9WVay8kX6gl0pbGr1fNl9u
 46gXotmfFm7UcyGPvGiD4q6IeTZnwb0hhv0L2/nSZrg8nPgkFX+ue+KBRnNvWDdvYkt+feK9c
 TZfWQvVfkF5+P7A3Qa6M49r+KSzPM4kmPE7oP+TGa/zhr4wluDH+MGD7ClvCBDrwi5q0Ia5nC
 kTCuT9iEuD0tIOCjjEU56FMvFXZs0zfW0admWqdNvJjKw28KlpctE6YwFCNHphgbxmqVl68nW
 PYrwMA2qSxdI+32gxcWDO8OOBq3DGzRq5AhMKwwKNjtSwX2LdkoZYcN/bYcY3p0j8K3260N3R
 9ZY2mct3VTV/b7JSXEyjIA+9YV4wLtjbbbGa9kRbR08s4PLGLg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This not only prevents regressions, but also serves as documentation
what this new feature is expected to do.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6300-for-each-ref.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 3aa534933e0..c128dfc5790 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -766,4 +766,36 @@ test_expect_success 'Verify usage of %(symref:rstrip) atom' '
 	test_cmp expected actual
 '
 
+test_expect_success ':remotename and :remoteref' '
+	git init remote-tests &&
+	(
+		cd remote-tests &&
+		test_commit initial &&
+		git remote add from fifth.coffee:blub &&
+		git config branch.master.remote from &&
+		git config branch.master.merge refs/heads/stable &&
+		git remote add to southridge.audio:repo &&
+		git config remote.to.push "refs/heads/*:refs/heads/pushed/*" &&
+		git config branch.master.pushRemote to &&
+		for pair in "%(upstream)=refs/remotes/from/stable" \
+			"%(upstream:remotename)=from" \
+			"%(upstream:remoteref)=refs/heads/stable" \
+			"%(push)=refs/remotes/to/pushed/master" \
+			"%(push:remotename)=to" \
+			"%(push:remoteref)=refs/heads/pushed/master"
+		do
+			echo "${pair#*=}" >expect &&
+			git for-each-ref --format="${pair%=*}" \
+				refs/heads/master >actual &&
+			test_cmp expect actual
+		done &&
+		git branch push-simple &&
+		git config branch.push-simple.pushRemote from &&
+		actual="$(git for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/push-simple)" &&
+		test from, = "$actual"
+	)
+'
+
 test_done
-- 
2.15.0.windows.1
