Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0984F1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeDEWs4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:48:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:50621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752662AbeDEWsz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:48:55 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDR21-1fImPx3juH-00GmwM; Fri, 06
 Apr 2018 00:48:52 +0200
Date:   Fri, 6 Apr 2018 00:48:52 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] Document the new color.* settings to colorize push
 errors/hints
In-Reply-To: <cover.1522968472.git.johannes.schindelin@gmx.de>
Message-ID: <516b28e82ace0a0b6831c644f246c19dad1187ac.1522968472.git.johannes.schindelin@gmx.de>
References: <cover.1518783709.git.johannes.schindelin@gmx.de> <cover.1522968472.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4gJsJPQ7NMHI0XHc4301mHgEte7F4xBBppWEDnDaEOWn8u6kWdw
 qW4/dVdVjxprmWMilPZyIuKQ16gYMLMytJdT86sjqttJ5Qff87n6NtYN9V8V9GXphLB3VA2
 P1vbkdaCjiKEmraEUkEdzVrdExg+ibbozPs2M88EDzQN66QC2h7ha5lJ8E7+A2GcOxV4zfO
 eOBLFUnWMdBGLcatlRRXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/zn1pklgJEw=:Hd0clAPbMmw0Zo9a391KPW
 KpTsjWk52UF7iJF061BVYsdj0cMmlAMMqEmdCyKoEOBTAl64NXv0oLTeGeJO2EuM2c+4yfTPU
 +0oxrjRf8zOyVxj6yGwWZbkCl0E7AHgAJiTSeWRoDoSjid8NRyge9PZ/IKXhqbJFCVimU+Axh
 +nTdaMoMlF77CIi6zO6+gvI0BbydxHmchX21oNlhU9VK5qGXs3YTpQITuMJm+Wo13EChABGCt
 ayD2sT25dHrURn7zPn7Yo2yE0kzWqzNItMsr/RPoIcUXgilY5y/jyMleSaxxWTF2zZXrttXmD
 v7E+eXr7KL8zfqF9JK75CnNK1u+kBCX2+iBUyaLCy/LuO3s0YmE+8FXCzeP0Pu+5VL7GUOnjs
 gPX8SX4huoftskhAOQcoG2lD/BTU3WW+se4SaqoeKiEfKYwJZs1ihYfbAoV7isjBljeSO8BR5
 JoobNmYOlwLX3QWotL3Hi2t4m9IE4re/41jIh5E5Kz/Us/iUQ9mC5kznEyvYXwheY9VXUPio+
 jpHgGYyR0qbR5hl8nZwl4LCZZP7wASxrGLJ3t2qBNMkcI9lcDobxqCsl6AMmMk8xLu0EfiYOR
 WlxJpHs24EDB/RlJlpC8A1JLh+nH4gEzpGOjeIbHyh9DfiV/pTQd5oIkwcbTFSyWzrUh0Fxfi
 IO6iN9Qib7O999skQl3qqv9ULis0QRCSAvAkVZEPTcyiP4q/XcgUHO5pXjm8uOnxJ8o04fbDm
 LJUmZwOqPxC5z0qAs8cyMqLRMv9bcx6HjHZ4+rRuAgBtZUtavl9Qjsu4Kzsonpq/X5BbU6+IC
 UJXxd6qHj9dd2m0FJNFmvAMVLy02faABR76G90X+fPRVtEIl61nzpUU+9/jZ2/fmT5WVOAe
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
index 4e0cff87f62..40e3828b85f 100644
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
+color.advice.advice::
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
2.17.0.windows.1.4.g7e4058d72e3
