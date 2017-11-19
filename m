Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CAB4202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbdKSSmY (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:42:24 -0500
Received: from mout.gmx.net ([212.227.17.21]:52717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751080AbdKSSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 13:42:23 -0500
Received: from bedhanger.strangled.net ([188.193.87.84]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LvyAz-1fEXOz1EBZ-017oDO; Sun, 19 Nov 2017 19:41:48 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v3 5/5] Testing: provide tests requiring them with ellipses after SHA-1 values
Date:   Sun, 19 Nov 2017 19:41:13 +0100
Message-Id: <20171119184113.16630-5-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171119184113.16630-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:dWKUG9cUJDFYx3tlEAvPR5EygsqDPVTy4G6uIvqRHCYDwg7hcPT
 XqoNr8LuXoclSXfVKuJug3M+FhEjv07+wx+lYHEkN5abBrvXZhPcGICvEWDOG+OY/XbL1xr
 L4HXmJmfPwO5Crv76XiAKtfmZrV3CRbM0mynQrgL0WsL5zV1wcgPws1RTJIzbc52jgdJ/TQ
 aKHe9BSRuPoKku5r1uecw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qFp/kgADBEc=:UW1JG9b1nMf3DT8IVP7geJ
 wLlO5MUeYn6WGzAUK6jWAGUqJckqCpckFAxoJfzHQWM3dPodtPv4nWlc0o3cUsarwTT5rvABB
 M+5Ln2pi8+ZpGpR19wxsSQ+ToKH6GBoTDIxbcYdnmvA07de7LAB5i69A5EzuQcaVupsfnfqTN
 1aWLq3tlvIMbJQDHYwLcjeWROws8wBpo6k7LFTe51dAey+tjQx32XKdXvhLu9xTzHRV5Iq2ZT
 grmbAPRjCB9dhZ9UDVF6BdBgWzz5ubfehNAflmYHtTOSrDoR7XBlnbSofDAAiOXxJsg7IUh9B
 3suCcLwYASHybH6vqZ6VKIYbWXII37NMWefuyoW4n3uB2LKbkGIPRDTJyIFnk3lEaXFei3yaW
 uK9Qnh0579YKAPxzBFJf/ljJFBFMcQxYMbbIWskEKjigErv9B24j8RHojvncdPNbop1FAdzsy
 9hl/0dTnNIHENe2WuCrTktT0XazxEaW3zLrdWkIy1cFNMoJTQDhAA9RZhRa8pu4VXy9GE4cyK
 fa65dzxWITvn2d5ERZ9l1Ebpaf8ncKzSJlnQiAA/Mh1dk4eGUhY2PQ7uqguXFT3wsOEeGbVl2
 pGgERt2tEP4euIVRYo8ZLyJOjKQwAgFErwVOUvfG6/UrbgT+VSaY1wiTwTVSQY9Ua13y5s750
 jZhsAt/9UTwPsKzkjSVlr0jUjwVQCkq8UNlDLosJWK9ep8X3Nfi2VDWAenMs1EiB+tPJon+kt
 jNW0QUdVO3FX/DDHQPVu1DijJQRKWEtb/kws85oluuj84v0mRT6I741uA+ROFMnhU3E/aQ4UJ
 xj8+k8MFUO4UTJYVCBWDkD6HruahQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Where needed[*1*], we arrange for the environment of a Git invocation to
contain the variable

   PRINT_SHA1_ELLIPSIS="yes"

This furnishes ellipses in the output which then matches what is
expected.

[Footnote]

*1* We are being overly generous in t4013-diff-various.sh because we do
not want to destroy/take apart the here-document.  Given that all this a
temporary measure, we should get away with it.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
 t/t3040-subprojects-basic.sh | 2 +-
 t/t4013-diff-various.sh      | 6 +++++-
 t/t9300-fast-import.sh       | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 0a4ff6d824a0..dfd46a5672da 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup: create subprojects' '
 	git update-index --add sub1 &&
 	git add sub2 &&
 	git commit -q -m "subprojects added" &&
-	git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
+	PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
 	git branch save HEAD &&
 	cat >expected <<-\EOF &&
 	:000000 160000 00000... A	sub1
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index c515e3e53fee..79f213dddd92 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -131,7 +131,11 @@ do
 	test_expect_success "git $cmd" '
 		{
 			echo "\$ git $cmd"
-			git $cmd |
+			# All invocations receive the env var.
+			# We would destroy the here-doc if we
+			# tried to apply it to only the ones
+			# truly needing it.
+			PRINT_SHA1_ELLIPSIS="yes" git $cmd |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
 			echo "\$"
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d47560b6343d..d93ddd91093e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -876,7 +876,7 @@ test_expect_success 'L: verify internal tree sorting' '
 	EXPECT_END
 
 	git fast-import <input &&
-	git diff-tree --abbrev --raw L^ L >output &&
+	PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev --raw L^ L >output &&
 	test_cmp expect output
 '
 
-- 
2.13.6

