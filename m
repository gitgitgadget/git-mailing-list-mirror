Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502C62036D
	for <e@80x24.org>; Fri, 24 Nov 2017 23:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbdKXXzD (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 18:55:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:55413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753868AbdKXXzB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 18:55:01 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LptId-1eoxOP1rqp-00fimL; Sat, 25 Nov 2017 00:54:26 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v4 6/6] Testing: provide existing tests requiring them with ellipses after SHA-1 values
Date:   Sat, 25 Nov 2017 00:53:30 +0100
Message-Id: <20171124235330.15157-6-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
In-Reply-To: <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:wSMri724RAQc2N8ODXnsJJOVrFfzruHJAjeuaR/7PaglGT6vI9S
 8P/OMBpYJ3r/fdRJhlbR0F2yyPVNVsiJ7Bj882WIdk5mCsL8XeMx/FmlHGsghGXArz4etnK
 QyUoFDYYGjtaBlOoCsvzvfjOqtczZQsjW6rRRGz+netw0+/zt8N03cYH8O3WFxVG/cAFZTU
 aSIH/1FLGgkU6/AKPGwUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wKQyE5ZQ1Ro=:f42YyMI4gVmGJqaZ/fcz+n
 nlCDDpqWR0jShE1Q0TwOjiuWZtUPOuySEhm07Ygr0DcQSCo4FdgnnSOaIc0E9Ii7ohLJRvgcB
 eGw0A31w/y9PGeNQDnUvCHb3UPnDY73mrLbvo0AlU1BAiYYxs7vjZTMtYkcmUi7ZcOrCGs+5E
 5Tc8Y7uQ9NH/SrCj9toFZc3fVvZCz2/ioJc0khP0ndF6KPOcU5w2LzqslEdle5g3UagZ+5rsF
 XoFqFTP6AKyZtSpiRz5jL4iQXm+CMs6uDi1olGbEfbZ7PxmnGZrkV4AQd1Vz7RsMO3MKvZt2c
 uI5T0KE4OZPx5bg1ZpIyWAiO9bBBu3DV54G5SIdCnmTdbYnWoGi+QSM6jTrFOoEtCW1jJ3U/n
 QWE0L7U30+zr9VTV/+2x4fogRwkacEUSztVAkALDdPwjoY0aUUSLvGw11dtGWy5qhgXRiMtsf
 TL9Q9BHHpZ11NjCP3sDHQQLIkh3EqwMuAmnKhxKmhavlz8l3Om5Hvn4+U1CMUHJoiELI5IJvv
 23cN5d0tVbXP5ginP3mXrJeEGUPrrj5u46R2EovH9fm6ZzzMGb6aaCeHM3JG04o74fQt6o9Ax
 MrnZ48qWEwR3JLCFQMRnGIc7EkcOUEPotAoC5LsvdNU6RrZg4HnfgZV+lGdq+i9r3eYa2pCG1
 InuxDgv36JWsc/SzY0z7JRMn6vLLzlo9zqytgc6Oml+MMbxOYaR6MCB/F3YUGpdReDtFFngZe
 8m8NEKpRYSMnJX1MR6d28YzGbUqNl5nUk+JTEKaOkJkEt+r9qCibWp8BzPpjwAPYtPkJjCD3z
 owuKNihXpW0NGv8pt41tlL6PM8qCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the moment, this patch's concern is to not break existing tests.

A follow-up patch (series) will rectify the situation by covering the
new output format as well as the backward compatible one.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
 t/t3040-subprojects-basic.sh | 2 +-
 t/t4013-diff-various.sh      | 2 +-
 t/t9300-fast-import.sh       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 0a4ff6d824a0..b81eb5fd6ffa 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup: create subprojects' '
 	git update-index --add sub1 &&
 	git add sub2 &&
 	git commit -q -m "subprojects added" &&
-	git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
+	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
 	git branch save HEAD &&
 	cat >expected <<-\EOF &&
 	:000000 160000 00000... A	sub1
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index c515e3e53fee..9bed64d53e01 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -131,7 +131,7 @@ do
 	test_expect_success "git $cmd" '
 		{
 			echo "\$ git $cmd"
-			git $cmd |
+			GIT_PRINT_SHA1_ELLIPSIS="yes" git $cmd |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
 			echo "\$"
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d47560b6343d..e4d06accc458 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -876,7 +876,7 @@ test_expect_success 'L: verify internal tree sorting' '
 	EXPECT_END
 
 	git fast-import <input &&
-	git diff-tree --abbrev --raw L^ L >output &&
+	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev --raw L^ L >output &&
 	test_cmp expect output
 '
 
-- 
2.13.6

