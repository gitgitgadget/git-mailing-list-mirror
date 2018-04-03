Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FCD1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeDCQ21 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:47213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbeDCQ2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:24 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lhwt0-1egh1l1yz4-00n5PT; Tue, 03 Apr 2018 18:28:11 +0200
Date:   Tue, 3 Apr 2018 18:28:10 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 03/15] t1300: demonstrate that --replace-all can "invent"
 newlines
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <532243287ff81725502f09251d9f749ce1d34417.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zCEcXBFG99fwXj83H5S5hAGHAmaKlph1wbo1z04kAwFvx3Yjn+z
 vvA3UABkV1sr6GGuahshrdnijbkUl+mmqeKzVBOZLb4eolw/Gvw8auYIzQIHIkCYzv5cC0Q
 4R9YEtPYIBHMCkDoQ5pQjtcvXGAAeas4wpPXSJeVRiylVWqPiFukY1Qgcg3ByEVxufiLZAl
 hO3KBopPwdt4fchPRNt3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qRN/t+H6nHA=:cuTZALkUD5DTmxyfgozc4p
 AqxKnc7hKNwT1TSEzOOhmclXEmvIwQlaVu5g9Zj6CGRYZMfioU0ZzlijQkTvz3k6ygIXTD+2y
 kpw5zzSOLnamY4B3Bripg3YZw7g9ZchX1/3fGO4bXGmDBC3nFz6NfQEh8XapvCI6L7ksV689O
 A2P7ZDSrZqNhU8jPiKzhonJ0dCW0GuzJ63GlZa2NAL+sQzQiJqKLe4ASp6vR6vd6NNj61Wm3G
 xmTHsnNUtK9r+BkVd+9ueR4BRtFdv71p+dipnee1yLGP2XK4aurqbfiKCKJYTBI3QStuaK9MR
 N7SLNnogJ4/xCmgFxxd/jyzRvxRPvzwWeDuKZY0QC7MSGXdk1V2J6tI8/CNwyoQdYc4BoX+CR
 SzGqDKfFf0s6xBzfkC7zWJ5qQPvik6UM/c7ud/t6dzWSjwEmK2jv0ll9FMZB1N+HXIP12N9+q
 w+xzHrgayrNer4+f7KiQrqKe/XeDr5N7t2KTbhN/KiGTCFCYP/jQBYUE440u1R/ACiuaI+0OW
 sv1mYo7Zlt6Kkpcxdjxv1DWhIcUVQzfdv03uTm/FmBbxYmwuiBeY+BoijsXxpIkH8DalwWEpf
 sHNPpPqZrn+8N+T87x2EYg1CSgR3DKn37pzdVOI8kKdvqWxAIcU/0bFfDDxwuiF5dIVYJZYQJ
 lXNyYwW43MxijaLNYw1hONL7qoVsBaEVKXLMOLkKOgn5jrjeBhdjOedo5dfGtrfyzNw1/LBHY
 Na2IS4ulmudw9JK7zCGxVv7QsK7+DIng02XFB+Qu7EpZs0d98Q0b7RW50Xw8rUjnwgIj/EOB0
 BiCXrptuJV3CnrgtGjFKBgZzBo+cPctE/92dHnnwCuWD+U+KcglUVxCSGGX1SyQJmMKavmw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 4f8e6f5fde3..cc417687e8d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1611,4 +1611,25 @@ test_expect_success '--local requires a repo' '
 	test_expect_code 128 nongit git config --local foo.bar
 '
 
+test_expect_failure '--replace-all does not invent newlines' '
+	q_to_tab >.git/config <<-\EOF &&
+	[abc]key
+	QkeepSection
+	[xyz]
+	Qkey = 1
+	[abc]
+	Qkey = a
+	EOF
+	q_to_tab >expect <<-\EOF &&
+	[abc]
+	QkeepSection
+	[xyz]
+	Qkey = 1
+	[abc]
+	Qkey = b
+	EOF
+	git config --replace-all abc.key b &&
+	test_cmp .git/config expect
+'
+
 test_done
-- 
2.16.2.windows.1.26.g2cc3565eb4b


