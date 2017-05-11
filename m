Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A1312018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756132AbdEKNsp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:49163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756123AbdEKNsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:48:40 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnPnu-1dfPNs1O5G-00hghS; Thu, 11
 May 2017 15:48:26 +0200
Date:   Thu, 11 May 2017 15:48:24 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/11] PREVIEW: t0060: stop testing support for .git/remotes/
 and .git/branches/
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <41310d8aac9a58c8c419676a1e9c971b2b4648aa.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aS4RkP265hSMIZTlAjRZWR0Q1vpTY55EaHAZMT76HzAYelmj3dh
 0NDpZbxrfjrM44bE/ANSYaZGBnQrQApJ2WFrk+NOQLgV3m5T64IMUk3H6hJ+COaWX6WrLi0
 +rCPGOgmcuaPrqQ6nr4n4N2hujbrlAlB6a5fumCXj5MIuKQnZ7O3smcjbIt6CJ1O34KKl46
 KGG4OCENUCssQnuxNF/+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g16nGbjvYFs=:22qauD5FzDAe0uHjRpoJRD
 FN1nBP0yH+9JxiNIh4HbnhCo2BrV+T6jz4zf26oV34VzbRoshifoYnguTvl1gmZMPh3kv19he
 Nwba0nfVoTBMbmknp6Q0J5l/iClHkrEuTdlVp5Pj3OUM1u3praurVfzWHNYgg9rbUwN0wTo0S
 ma2P2M44xRDvCh0hnju7EYG2I29qgK6Y7lupaQ6+X9BNhnomaUiVlCM0FIKymXDrcScvkAKUz
 QOO7tY+6MdeVB6klxNheUnYnFFLpjWfcTUWhs1cEJO9IAHYdDtaRwvaLRh9/IA9gSTcXrHftB
 YV3i4LGl283p/CIj67EBQeTgi7m1P1IXH+ejchZ/MVD0IlSkg/r16OyBqMzEDpztApf+Cdjjq
 LY+gMJkr5Lyss03qAz8zXBWXTu53tWTT+4gASOXOXoqHOGQ62mSF6T9EA4WgzIcbDx7qAMgt1
 Vj2HxhwtzvisAXco1KPPvXMkDFdy24xVqNTvZy6wccNJVfrlnejXOAU2zKGlGCpc3JZolRqVC
 a420pWxs1lX0Pkb4i4wfiRZqlB1AoCdAiVPbtOhrdEUd+aWZC/bjVjwNgLb39YQHgs2j9qPjx
 Tayn0EXgWYW8f8FvKuV7T99YaqeRXZ420nfnnC+cL0o5DUar1O7fCaqi2b/APbcIATMr3relm
 QHAwO2832JSb1iZeHDP9mlUae4oRAmwripHvJD9eldZiSTpbDlFKJDtVhGhvA23YEJRBV9Uxn
 RSu/5ntrMmt20xtMnPDm6veEki3ncx/wdSNuA17zb4SU1oE+LgQ4ggbra6605oylobbsp3ALk
 1A1tKhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to remove that feature for good.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 444b5a4df80..162c9a5a2f7 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -295,8 +295,6 @@ test_git_path GIT_COMMON_DIR=bar info/exclude             bar/info/exclude
 test_git_path GIT_COMMON_DIR=bar info/grafts              bar/info/grafts
 test_git_path GIT_COMMON_DIR=bar info/sparse-checkout     .git/info/sparse-checkout
 test_git_path GIT_COMMON_DIR=bar info//sparse-checkout    .git/info//sparse-checkout
-test_git_path GIT_COMMON_DIR=bar remotes/bar              bar/remotes/bar
-test_git_path GIT_COMMON_DIR=bar branches/bar             bar/branches/bar
 test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master   bar/logs/refs/heads/master
 test_git_path GIT_COMMON_DIR=bar refs/heads/master        bar/refs/heads/master
 test_git_path GIT_COMMON_DIR=bar refs/bisect/foo          .git/refs/bisect/foo
-- 
2.12.2.windows.2.800.gede8f145e06


