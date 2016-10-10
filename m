Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5EBF20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbcJJR0B (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:59067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752989AbcJJR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:00 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MV6EP-1bNRhc0UbF-00YOJN; Mon, 10 Oct 2016 19:25:29
 +0200
Date:   Mon, 10 Oct 2016 19:25:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 09/25] sequencer: avoid completely different messages for
 different actions
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <1b7c940b274e1ac0887ea310ee4d629b8b6b200f.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fE0iBgWzpx4+1PAmHZDLl7fziTLHuW/WggK76ZG+M/MyY48vq1+
 /G130QEUx2TU++xyOQMF3SfcLt3NgMz4Tg5hW7zptBxSUox+JXoKVS/w3YhFW6Yet9q6EP7
 9HUD/M4T9u5+ITQ+1Mw9oaPMi2t0qdf4ZjHTOVpJEF1/j2711qrD/VtkkScC09iLH26TVv1
 D+bxviFj61S4Zk7pvwXqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aowu/MinaUU=:5YQ2z4m7LvgiI/ptRaxW4l
 nF1f61l5VQPn1DBTdzWFPZqE5mr2VUvfxu+e6GPneMRl6V/wxuw29Wa/vM5230jAcGJ2DORir
 vqd9InMsmTlo+ATDtN7w4LGhT84jjXpnmHcIGgqy5571Xn+W0bmlpxfD0T4S46JG28Ibg7Nhq
 0hmBIU/W3gJ3AMgQ6jMDwOnc7Kn5JIRsi3ehLgtyfD2eoFEMjPOWBahnuSHyZ7E5MGJ/b9aMs
 CPWLKBF1PcZaCGBG6ragrcotocW8u5BPbgUbdwrj9MfJBEeiZvysopVt8Pasuvj+Xv34GBwUn
 lKagzDxxaKwNLmSNx3Pr8QC8Jp8w5l1rowdye2BHCaaqR8g28Ry1N9cOC7lg9HmAE3QqDgQ7i
 o2bvkU0gEFTkUh4Il9titl0AmcQ8IR8Co0gtEgX4TuX/GomFytvjprnF2XJqSI9dSH6aGW9Li
 Ncp2qmotqfNj4BEVmvCKC5nvnIl8ThpRRa4VzPC6Q6dBXLsinP6XmY6usUyQ1qd7OxY6w6DcU
 kdIcuE0rty2Qq//bBZ8Mwsjpk2R4dsAnrpNyS5Q11ZgLH6ONkrr4EPBakzGrf5aXPXsNwp9Pw
 cGw8tpkxnK92YgATN04JBBXtHnF39lWdOLUI4e1SQYzQAL1wh/wfa1LWY0z8cuVu97fax1KtD
 BFSREOIRH59Uz9oi0WUZdMNQJpP3wglGgEZKG1CA6EybCN+pLXja7WPDn0NDwTZqdrTs1oyOX
 SX4zIPlVGJTcP8EcWLA3DkiQQnvqoPI+Gy8sJ7l4vCgKPmF5rDp0xg+5h/JCDFxkOAO1ha2Ct
 OdjHxIz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cee7e50..443a238 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -224,11 +224,8 @@ static int error_dirty_index(struct replay_opts *opts)
 	if (read_cache_unmerged())
 		return error_resolve_conflict(action_name(opts));
 
-	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == REPLAY_PICK)
-		error(_("Your local changes would be overwritten by cherry-pick."));
-	else
-		error(_("Your local changes would be overwritten by revert."));
+	error(_("Your local changes would be overwritten by %s."),
+		action_name(opts));
 
 	if (advice_commit_before_merge)
 		advise(_("Commit your changes or stash them to proceed."));
-- 
2.10.0.windows.1.325.ge6089c1


