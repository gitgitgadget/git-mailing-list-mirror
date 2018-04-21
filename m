Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46DA1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeDUKKJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:10:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:55637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752388AbeDUKKI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:10:08 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC8iq-1fIf9g3fRA-008ot0; Sat, 21
 Apr 2018 12:10:05 +0200
Date:   Sat, 21 Apr 2018 12:10:04 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] Add a test to verify that push errors are colorful
In-Reply-To: <cover.1524305353.git.johannes.schindelin@gmx.de>
Message-ID: <7f24ee9bf59f91505b8e7cf92715724511f4026e.1524305353.git.johannes.schindelin@gmx.de>
References: <cover.1522968472.git.johannes.schindelin@gmx.de> <cover.1524305353.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QN9SBMJIryNedbRBxygJ2EFpPwbMhbkgsREz8Wzgk5NvaXpT+sx
 vvvOmXzO1DlIiwvSON+Y0bVAOp7WVpNDlOC1lTMRe/xHxBDk97aqDXM0e6iiAWUiIBHAtFI
 eVoMhwGqvKmSnh3q83BLMvJ8FdRWMOJQujrdH9VvldHQAGz73JsdPv+Uxr9BM5itYddvf87
 0Y53imhCVSGjsFLgvOBtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ypt8611nGDE=:YxdLxF0KyEVCJBpMg0a2TO
 QHzBmZtrhElQdxCxijPK9MISwQdv0Wx6OlEGlAde2lK2Gt9NDPfsbLKS85piehhVx8RUkOMVt
 jYGglF396eM1WkF96n7AptJCGPcI1eEmDMve4mZ0gV3k5OZr4u+7HZc7Enyes1PjTTKc3oXDH
 zs7EWpE8yNXfZtc2fowJxieexEFiOTYK7HocMsW5Bb1q+EN26SkwqDvQNHd9UEVR/uvBmjwKx
 eR+mH6mS93pDe/Icu/mS6SsA5E1MBHyREPN8GRuMGONzidaZdUgs0Htxw8ct3yzrZIbWu/T5n
 kJppvlarDaRje/1+d1k+lAcLPGmTV+b4HGBBvRM2PK9JFvIukroz6bOpuVgeBM4hJ95NGJYZN
 Gn1EIw+R7kk1gRaNrGstyf1AakJxrw37PJutysvI7AbBHU7SN8hfdU7ML72ympJBVWXn89qN6
 N+tYOG8hfHueI2RRUjq9mFiN1arqbegzaXc9+xVLyH/dm2dE4wz9kDZRKeYXFDjudrdvpFHSG
 5sCWWFuEKnzoT7u7cxjNjSESVQZ8uzFTIKM0AqiPG/S3zjSS52LJXqNtvqmzihLvS3QQhlQ9m
 kR/xB3NNAD9YEiB7hhXs1ugOnVNcAPpt9i7B4fwEWlRDJ+5rKjWwWAwynAHmxqwVhmGhNEneO
 sv5f17QDeCbUhyzCrThQk3gBj3Vnvv60zR5y4nNL2gbpTl5RZCX5s0h0bffdxAUPBtk7b5FAe
 29I9ue9B4GVWtAhOsT3Jmf/icUrk8rj3EcwbL3yt7KJriqCtNbpqR6/3gTDXXeT1J/wkRUg6A
 XWE+9gOyfeJLW7HlvSj49OGWu848vuMoYtAwKX45/uvwLAyGXo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This actually only tests whether the push errors/hints are colored if
the respective color.* config settings are `always`, but in the regular
case they default to `auto` (in which case we color the messages when
stderr is connected to an interactive terminal), therefore these tests
should suffice.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5541-http-push-smart.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 21340e89c96..a2af693068f 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -377,5 +377,17 @@ test_expect_success 'push status output scrubs password' '
 	grep "^To $HTTPD_URL/smart/test_repo.git" status
 '
 
+test_expect_success 'colorize errors/hints' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_must_fail git -c color.transport=always -c color.advice=always \
+		-c color.push=always \
+		push origin origin/master^:master 2>act &&
+	test_decode_color <act >decoded &&
+	test_i18ngrep "<RED>.*rejected.*<RESET>" decoded &&
+	test_i18ngrep "<RED>error: failed to push some refs" decoded &&
+	test_i18ngrep "<YELLOW>hint: " decoded &&
+	test_i18ngrep ! "^hint: " decoded
+'
+
 stop_httpd
 test_done
-- 
2.17.0.windows.1.15.gaa56ade3205


