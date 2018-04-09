Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1F31F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeDIIcI (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:46721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbeDIIcH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:07 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXDo1-1f1vY00rNF-00WHWy; Mon, 09
 Apr 2018 10:31:57 +0200
Date:   Mon, 9 Apr 2018 10:31:57 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 07/15] t1300: add a few more hairy examples of sections
 becoming empty
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <880bd424742c2bc562d567c6fad3409ce99aa825.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N30iWNr0Eokpdnu8WNmSZpXMJBqhix/2AAKz1KlLW+u72OAkQao
 KpfsVbUD9j2rW+q6PlNOjDq6SZZV1IzY7FCvvHrtEVIKvs5t4cKWm5mPXXo49rZ8wFo+jg/
 DiBT2woOYW594y1q1/Xgpswg8Am/ksHUHa9pp+FISH7/vGftrDvheJvw8/ape2OfyTV0GjX
 BSh9/jcbhbsctZQhtCdFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xBKSZVHqdms=:yqcRR5kDO+fyM+kqj6HdRY
 Y2I0XdQFJaDa+y7FujTuUz10vVb0iA0LZSWPt4FMs9IKBnvSg3P4u6TVX0JdjTfkDOlweCyNC
 OhcXATG2wS9NKaQJXH4AfqxWtNv+12//NR6EYTD1+4WZD/miVPbdKmJjCIYntUnF8va3tl0cH
 DMe+AHbYZdAr24Trlr18fZTVOnWsyPtG3prqFscCIx7+4zKCZiGoUdKtgt849pA4w/r9VFLid
 9zOqE3x3caPHWOD+L3ZNRBoUpTl0vWNDJ+ANqH9MVRprsWoNzJHA+yLE1N3fYiI2OsNtLQ++D
 hjGAfMCIRlvMh5uVdgXKXv5A2vBZ7NcZzXAUaiLdNurMJPRo5aw7wHblwHpHNBpuAuaq2L7PF
 PImtWSxVqhqJC7T7ZF1WJzY7yA9JtOCEwTGBwbupL3Q1tc1ch8BwSMjEJnNeSNMAlwQb8gjjh
 LI6NmEL5lEYiDffwXF4bzGwnxNwIe5VGZ+6Uw0bdLTjjP+1elwGcX2PF4+v/GWB1Y4Ei9bcKT
 Iw0O2aP7lp203SnfiN+5JBj/UZb1nfORJ5jRxrA4h/YFkw21lCG7dwxNf5VJR/u4O4iNLhuLS
 5VpH9Fn/ZSBfaStj4oaKdf9R5RpiJJJgfBoZb7mG/gPXumX/oM3n+wEOYxIiYb4LQiZfnXrm7
 4mQeL9PwAvfFIh6Henf/e/DNmF+XXZvmuSNi49NlsvV5L9lK4niMx02W7h5qspVfjcyxcub3P
 KKo9NKPKu36b7W/G4tG4+SFCK2RWe2RlF2OISQ4QFvhoUxRdwVR1VXHf4raOYvMjjUcagBGgt
 YqQzFRtY9muOSRB1FfEMACfJw7qjgJuMl5GdPuHnFQ9lofT/Zc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the review of the first iteration of the patch series to remove
sections that become empty upon --unset or --unset-all, Jeff King
identified a couple of problematic cases with the backtracking approach
that was still used then to "look backwards for the section header":
https://public-inbox.org/git/20180329213229.GG2939@sigill.intra.peff.net/

This patch adds a couple of concocted examples designed to fool a
backtracking parser.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 187fc5b195f..bc30cfb3468 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1449,7 +1449,50 @@ test_expect_failure '--unset last key removes section (except if commented)' '
 	EOF
 
 	git config --unset section.key &&
-	test_cmp expect .git/config
+	test_cmp expect .git/config &&
+
+	q_to_tab >.git/config <<-\EOF &&
+	[one]
+	Qkey = "multiline \
+	QQ# with comment"
+	[two]
+	key = true
+	EOF
+	git config --unset two.key &&
+	! grep two .git/config &&
+
+	q_to_tab >.git/config <<-\EOF &&
+	[one]
+	Qkey = "multiline \
+	QQ# with comment"
+	[one]
+	key = true
+	EOF
+	git config --unset-all one.key &&
+	test_line_count = 0 .git/config &&
+
+	q_to_tab >.git/config <<-\EOF &&
+	[one]
+	Qkey = true
+	Q# a comment not at the start
+	[two]
+	Qkey = true
+	EOF
+	git config --unset two.key &&
+	grep two .git/config &&
+
+	q_to_tab >.git/config <<-\EOF &&
+	[one]
+	Qkey = not [two "subsection"]
+	[two "subsection"]
+	[two "subsection"]
+	Qkey = true
+	[TWO "subsection"]
+	[one]
+	EOF
+	git config --unset two.subsection.key &&
+	test "not [two subsection]" = "$(git config one.key)" &&
+	test_line_count = 3 .git/config
 '
 
 test_expect_failure 'adding a key into an empty section reuses header' '
-- 
2.17.0.windows.1.4.g7e4058d72e3


