Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B205B20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbcJDNGJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:06:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:51888 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753510AbcJDNGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:06:08 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MTSmp-1bRKFK1dv5-00SN37; Tue, 04 Oct 2016 15:06:01
 +0200
Date:   Tue, 4 Oct 2016 15:06:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/6] wt-status: begin error messages with lower-case
In-Reply-To: <cover.1475586229.git.johannes.schindelin@gmx.de>
Message-ID: <1d2639277473010731ace0af8358bafd3c622a8d.1475586229.git.johannes.schindelin@gmx.de>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6P/LajJqWfS5iyhl8WLYWF1YgKkOI8o5ictG9GtxmTDXrcD1xQQ
 Z2JDFg0Ce8CGzzLn8zVFyxHtkWebK/7CHIQ4NJuC0fTQBi1F4UN4fZN7pfhbEg0KHNmtwNj
 uEYZKtNhNNs4wd7Aj8hkt7j5FlyBo5KpWLHvqm0okFnGfCQQi3Aw1lzo/q5htjryitnFb+E
 MVgiKGoMzT0no+3L1FI9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5B/k7cZ0GLM=:UY3317NEL677dqQDvy1Wzs
 H3TCEYS8Ryp8B4D+fB6MvXeEvEoMT9a3+Tz7j6wPBmcgRalyf6mTUuORtcg+BL7HVNCzlPm4e
 2Ix43RlEWakJJGYnwMzd2b5gn1omX91UC5QpV1TKRitVMgqslCIyDi1+NhU5XQ1gTZasWyTfD
 B9sFuek4SSGPBNbzFmzEHXOQ+FHobsAlCvGmCk8K1Uy80x1R3RL1cH+NkFlmpJ7rChVT8R3Xs
 StuYPzdKX3JOg/f/hB6e3ABNv5VuiazPB/fEAZa4pWBIzbOL6O1uIZ4JcwJdbSOxwQmvBTB7m
 ogGfghdgiTrpYwrGTyrHmj8+sSltF6V2PtPXyKdWScxvpOWQgvbqnvDrfOUFz+8nQlbn5Jx7k
 1w7MF41T/tPo+Gm/feqFMuI0oedC5DncopRHgD2BHAPYyPubVQnArV7F69NMMU/AsUPnhtFxm
 bUL32BMTmVDvqsTFylwnokVqPPPeGyObWUVOCcE5221sgHj5MJyFg/AAYRKI28LNepWQR2rLM
 6z1ajK7Jmb2dv6C4yy5KwCJmCZpzk7/YnhCcpbhk9UYzxYOpsZOwJYmXThygeuCQasVBJZrTS
 1sGU150/Q/gM9NBvSkbvJx2PriOoY3uNupOefVyxUlVipjwBlYYq9oLA7irgEopmX8jSue9DO
 Hoe7Bo+rp2hcRvGA6FO0MZ4OU5AkjRp+HLTwywZOiiR06Vk+dQCNgLTP0FRCNG0xPI2sqFpAi
 DtuA90zuOdB42Hr42tOJRcpq2CEwU5ib7iR71O9muTHXKx680F0vY+ygsaoaILlCX9EqQCQqE
 HHHkqkT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous code still followed the old git-pull.sh code which did not
adhere to our new convention.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 2 +-
 wt-status.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index c639167..0bf9802 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -810,7 +810,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (!autostash)
 			require_clean_work_tree(N_("pull with rebase"),
-				"Please commit or stash them.", 1, 0);
+				"please commit or stash them.", 1, 0);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
diff --git a/wt-status.c b/wt-status.c
index 061597a..010276b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2265,15 +2265,15 @@ int require_clean_work_tree(const char *action, const char *hint, int ignore_sub
 
 	if (has_unstaged_changes(ignore_submodules)) {
 		/* TRANSLATORS: the action is e.g. "pull with rebase" */
-		error(_("Cannot %s: You have unstaged changes."), _(action));
+		error(_("cannot %s: You have unstaged changes."), _(action));
 		err = 1;
 	}
 
 	if (has_uncommitted_changes(ignore_submodules)) {
 		if (err)
-			error(_("Additionally, your index contains uncommitted changes."));
+			error(_("additionally, your index contains uncommitted changes."));
 		else
-			error(_("Cannot %s: Your index contains uncommitted changes."),
+			error(_("cannot %s: Your index contains uncommitted changes."),
 			      _(action));
 		err = 1;
 	}
-- 
2.10.0.windows.1.325.ge6089c1
