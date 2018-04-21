Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799EA1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeDUKKN (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:10:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:60835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeDUKKL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:10:11 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLvLE-1f4KlQ0Him-007lrx; Sat, 21
 Apr 2018 12:10:08 +0200
Date:   Sat, 21 Apr 2018 12:10:07 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] Document the new color.* settings to colorize push
 errors/hints
In-Reply-To: <cover.1524305353.git.johannes.schindelin@gmx.de>
Message-ID: <b192099ce0e251f4aa35b2c6388a31c9666e723f.1524305353.git.johannes.schindelin@gmx.de>
References: <cover.1522968472.git.johannes.schindelin@gmx.de> <cover.1524305353.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dmJW0JvWyiSafXZp/6pKbPX467h4aNtHSYBFfRdS0GOjUPWYBgl
 aUxOCSUQZ5Fe1UK/uImIJTfz7Lzo+niEPDv63ZyKGM+DnsW4Akq5F0OyKPEX6uRsNEsm+y0
 6dzO1J8+d6Y5106hJT6h6+3McsbOVQjZc3w8d7LCZ1/ZAfxJckYjzTxrDmEUINkwdDSK7lO
 zM1NTHzjr0Hq6XPp2ZAWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MA/enTIk898=:jsRFNhEtCgCCi9QRFpgYOf
 PaYh6nYRByruZ6svGS5VGo0PzLhzL1wZHXvwaUNJ+TsrwWJZF65QTQIHIULKp4VSlp21mQGS9
 IXY4ohfy0uqpUNbkHy9va00T1O7jxCRYY9SBFnNz0rkg0dwRGx9ru3iMaXi+NI4GqH5RafrQe
 uvzlx6fnGm6L5le8fdOQ77AmuOJXbB85qF0JYDBlNScd9LPf1rpmS3TK289z9RWXDb5rkb1fn
 8RZHYfIFCWM41ZZjOu0OjLR7qqIopUC4gKva1qis+OANITMJNFUrXAjcW9k/XajhRC1tze1N2
 xkiURpCKO8b6Aa1HNWukiETd9jwLUANNXCNba+TJg77XPAM2oo0HHqmt59xHuegrBZ7GPYQCS
 u/K3XqK/Y9559mp7hp6zayhtu5SrQjPdqbJnyvpdPhyZKah1ElAIcIz7yJa1Khx1XX8X/Ef7C
 mPZsR1S8K+7zHBh3mAK9YdEtyNDF42k4GxCNJx2KnvOSddowhIJfZRvHLBs8vuK/tmYU2o1Ci
 qitpdj/SV6W+u6eM6sMB0HFPl3FjtgXWSS3rZHpnoLFFGYc0Od9zWj6SBDBJyzLkShjGm/d5P
 5PODrbrSZ4ZVmlFvxKqoaU1v2iroUghKpjR/tEnEntz5Jxt06kwaYT87EQTor3KtPqouhr5Rx
 q2R+LzuTOpTN/bZepvjZUDP7IVW3yDZgv0cIsO3aj1tYCt1BoG1WLjsLq1ruHzpAajOof8afr
 m3PAn+NpPHBay8HVHRlaewI5yHs9e3IbNcM3DdFqN1g3dpQnjI+Hoq8qeoRTh8youhyh9XZY1
 IMhFeBOFtaYi7qAo60JpWy56eMGI3NeRDrHhLIHJi3n4cpt4C0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's make it easier for users to find out how to customize these colors.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb37..2cea0c6c899 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1088,6 +1088,16 @@ clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
 	-i or -n.   Defaults to true.
 
+color.advice::
+	A boolean to enable/disable color in hints (e.g. when a push
+	failed, see `advice.*` for a list).  May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors
+	are used only when the error output goes to a terminal. If
+	unset, then the value of `color.ui` is used (`auto` by default).
+
+color.advice.hint::
+	Use customized color for hints.
+
 color.branch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-branch[1]. May be set to `always`,
@@ -1190,6 +1200,15 @@ color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
 
+color.push::
+	A boolean to enable/disable color in push errors. May be set to
+	`always`, `false` (or `never`) or `auto` (or `true`), in which
+	case colors are used only when the error output goes to a terminal.
+	If unset, then the value of `color.ui` is used (`auto` by default).
+
+color.push.error::
+	Use customized color for push errors.
+
 color.showBranch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-show-branch[1]. May be set to `always`,
@@ -1218,6 +1237,15 @@ color.status.<slot>::
 	status short-format), or
 	`unmerged` (files which have unmerged changes).
 
+color.transport::
+	A boolean to enable/disable color when pushes are rejected. May be
+	set to `always`, `false` (or `never`) or `auto` (or `true`), in which
+	case colors are used only when the error output goes to a terminal.
+	If unset, then the value of `color.ui` is used (`auto` by default).
+
+color.transport.rejected::
+	Use customized color when a push was rejected.
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
-- 
2.17.0.windows.1.15.gaa56ade3205
