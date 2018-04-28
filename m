Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E421E1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeD1WpS (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:45:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:49699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeD1WpR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:45:17 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M3NEK-1eLYQi3s48-00r3Ob; Sun, 29 Apr 2018 00:45:13 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 09/12] filter-branch: stop suggesting to use grafts
Date:   Sun, 29 Apr 2018 00:44:53 +0200
Message-Id: <fdda7416d47f145caead0c4282f62853c93ec64d.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:6dcR7Or0PwNuYmc75zB9kRo2F3PPPuBvtc01q/ZkkbRq2QZBCWI
 W8xn3/6mukgU5He1pKkrH4q+Zh2P3g18LYmj68OxZiZJlcPjNDz17Rz+NkkOEQExFZCILX+
 VvXAXsn+nPSys2WyG6RKUR/FkV/PX5rODZurdSTUCRalzcFnFEAGM52WS+h4M0urQANDndh
 FHon8X9jeSKphshqAnyPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yORwiBhJTJA=:sF/dhijzXZBLmp3ZDrwMRs
 JyAX91lfvcYpAmsx2imCbzVHo5nyDs8KtmKZBMEAMcm7n2K6vg0peyOkicHieF22KAN0QCRoE
 2RERM5PHXY39AJcAz4N+mUmcPS0m4GP9P1xJG+w2Bh/jjfUm42ZbNfUYtsP8OlIpDL0aYF5om
 XlAuNb1zL0Fmt6Whk8SAhbwRAQezqrIujhK57p5F68kHzzj8QeUu+uk25ImUkpMjPfMUCjBR4
 TVTsvp1gcsqkiNGGNuFoAtCyQrIXIClo0YUjLoUobeFM2aiwUA36jaI18L6bHpqd6o/YbTmfW
 2jetW4Nz75GhHBC0mW5/QKf49gNhM08mWsxowqbCDAHeuZ+w9z52/iA5I5Jp/O8Im1AiWSQU0
 vAsum3gMi2erEdSl9e7J8nUe2v20bojH4q2ssQbg8PaXVfrv0U7LY8cG4FJVuan/YCA6IWWfb
 48gyYvyjUonyhraTSdNb7REyRPCrWhYP+VE8P0bVuesq9cyMMBbQ/gUFJWhJTnTyDymJsCGen
 pvzUqSLUHlBlB9ZSu30tQ9mW9mAS8Pyrh7r8UAV5LAXWA/+7xzwFvi5KdQGxfRmWAtIKKx1BB
 1u5nFci4+wiQPEtcrhdoDrsu18cC9BC3RkP1edSrDepMrJjH+q4LelML1J2qc9QbR6CF9D5Ds
 uf/gLUSduygVR8C6v8DKlNIFHTThk6VE4fVIjwWuACHD2psrwaA0xvwx5N74Hi6P/i/6o3uyN
 SX7BdpFkM1g6J2/zuqPMHjr1k8eOkkjJ1uwi6+0cWL6hFcD4UhE9gPpYbUqFA0RdAfVjNjAIy
 5xHpEx9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The graft file is deprecated now, so let's use replace refs in the example
in filter-branch's man page instead.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-filter-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index b634043183b..1d4d2f86045 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -288,7 +288,7 @@ git filter-branch --parent-filter \
 or even simpler:
 
 -----------------------------------------------
-echo "$commit-id $graft-id" >> .git/info/grafts
+git replace --graft $commit-id $graft-id
 git filter-branch $graft-id..HEAD
 -----------------------------------------------
 
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


