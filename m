Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15E3207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755827AbcIKKyA (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:54:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:61705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755479AbcIKKx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:53:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MK17F-1bheop1INp-001PKu; Sun, 11 Sep 2016 12:53:54
 +0200
Date:   Sun, 11 Sep 2016 12:53:39 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 09/25] sequencer: avoid completely different messages for
 different actions
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <a8f59af7bccdca01d34f77c1c259639175191a12.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M8GgcuUlSOjr0pXuDIAL6EzSltlKzclxz30cD6HofRaS7RVw7lD
 FJFTXSaw9yvTgRvxSYg6Squ0UhCkotXbbgfUlLC+sgbI8V/hope0CxW8ohbo9QJB/YgZMMR
 e3SgVzh77JwtiPesyX2qTsPXeGSk97XUMxCxEn6813MWIOxa4n6Fd4dmn8dY+fHN4s5E0AU
 mk5WdtiVkYEVvuynQgVKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bKsiSUJ9DfI=:jS/gy6fm/HddLXYP8lEZVp
 Lurqv5u3NuhV4T93XtgJ33nXyrWCrAhrvVCRalwLOw3chyKVgJ+KPPCiceWhkyAeuIUltr3Cw
 eU0fZj3htmUaIT5y8z80x/3Z428WXzjwBrMgZghV9gNoytOkB7OLfNA70rPWXRiJXoDPcGgVt
 1ulARFQlMCIfLW93PFyFHQaDDAEVMm7ccuUBEQ9ZEtxU78jzNpyNLznK0O8oVsZxROLYkDU85
 8/aynBM6ZO7zjv0ZitIEVJkySUrQud2klDuNRPrj4wFNQ5H3x2GpDOcl1oSJUVbOI4KIMapoR
 +DgQ8aJSDGrC7TDiM6tjgvkHiJy4ZL3KG49ltWtX1hlCtoFGyzjWOcXAguCnZt2TBq0wwxyf8
 P+heSholMSOVZHckhbNrWw1I7vm/Yu6oGJe/uFhNriEuWlIVBdy5CN6Xpi/wGewLvu+jwRHpT
 wt5kX5b0IsVnNT+POdnIK7dyQjbi/x0jx47UHEqeNeSETXN38zMxOLp4BOGJ3WeAaLSv4HN/T
 twC6otWQfquly7cvNOCucT3sCa9wLyGCe5q/nyHvnNjapyaPX1utFr91hD7Kf9Ls5TcgvN+vu
 345Mceu/bzgxapsZYniEWTf2kyQAQNj1ln15I5K2CxFcF4oEfhTNmwzxjpz6sGZTHeCPxIMi6
 LrgAEpHLuS0tMBtPArfV3bumBkLuMqreJOuXaKT4QXTPfVmZucUiurOdf1Pw4QR+ypL88N0b0
 z1xK4JhLrz2RJgRLgsOz+eb7fJQvhlZyvn5uS0BxeAoAOumMBYsidNCMUgQxlvbXKe8RSmE/s
 IBjcGGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b971ad0..7ba932b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -232,11 +232,8 @@ static int error_dirty_index(struct replay_opts *opts)
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
2.10.0.windows.1.10.g803177d


