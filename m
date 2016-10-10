Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A04FC20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbcJJRdU (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:33:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:53807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbcJJRdU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:33:20 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lk7fW-1bHYRU1ejC-00cDPm; Mon, 10 Oct 2016 19:26:42
 +0200
Date:   Mon, 10 Oct 2016 19:26:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 25/25] sequencer: mark all error messages for
 translation
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <e38bf77ff57d06ca3250bc3ec71a34088b49abd0.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TaiZQN+QuPVcpSxD1W9bEEWt9XCWBYoVHNtFxXs+M1YaJzi/dt0
 TgORnpHk+qbN80OOXyK5onZR2QoEmFFTel8kcrCmsros6qu2hl3OWtF9WoHz9EUsIxKnt49
 X0ePjBH3p8XkCNjD96oMj196ulIuatixEpI7vqVMUrAJzWjP+X+ZsNUfE4ED9f6nr0xAK8O
 RI75vF3cihe7DRI5y3b2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zNly6TgKfvw=:MKx/CXgBWJ2w6POA5W4sRU
 mCcILvLAY96yiYFzf5NVOqI4V32crsbnuEEW2LslFqbu4rauvMX9yDue6TVSMt7KFsQkv/O/N
 AahjQSV9vUILSUMgCJGetf437uJmQc/fJeITgbtrYIW3TQD40p8baNl1D3tEIxlUzI5VKVapg
 DbmsQhUlRmhFjcUekK7AjUW4VQ1aNDiZtQ9RYmHqtsPpXQf7fdQ4A4FtONYNWFqTrpDdovvX4
 bK96LGpuCt61Ql93CbpGL1fPf6qHJtaFAKt+6Ul2nN3PnXBM1lpT6y8P0N9YTJHcAKoxi0EPs
 yKN+JHCchFmaSMQjqTiRH052y2xgiQtNy5UJ/u83hnJBcROZIyY1F2wZ2POwgUhDaUb7fNHlj
 aSTzxM6AwgQ2y6pkIoeLjyXckRrUzfAbkr197Fgo6fTmokl3yFBN/CxROQRwv+yv6zjQyz4tV
 NXM+7Vm0PQdvrFOcdnUPZFRivPfR9bVEJa8dJuRqJQzsxx51OvGchEQWXXQw+wsn4gprqltoa
 3PZjKNThCGI7zC2HdBxmi0ORp5j8x1sBV2k9iSykRz5/+0pWQ638+KyZ4abgvdxoD84BF5nAF
 Lk8BYvRE/uTKKRxLKqYzIZSBRGeVBU9eF4AnD/DhvsFLEsDaHlgfL043RmYm23XBijsVd1/+n
 dSvjPuEUi3RLr7YIK+79UIHXSaI0KHYUaOXjt0+hg7V2HJ/JJckpY7E+uj+buv2EWaeG8CDtc
 WE1d3HstdmZBSolo5M6y3Hr1Q6q/h0JKoKGM0ZfUfqd98qmoLzUzPfR++/vBrOuhlvH5mIxuu
 D25Mhcy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was actually only one error message that was not yet marked for
translation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 676f16c..86d86ce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -515,16 +515,19 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		if (!env) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-			return error("you have staged changes in your working "
-				"tree. If these changes are meant to be\n"
-				"squashed into the previous commit, run:\n\n"
-				"  git commit --amend %s\n\n"
-				"If they are meant to go into a new commit, "
-				"run:\n\n"
-				"  git commit %s\n\n"
-				"In both cases, once you're done, continue "
-				"with:\n\n"
-				"  git rebase --continue\n", gpg_opt, gpg_opt);
+			return error(_("you have staged changes in your "
+				       "working tree. If these changes are "
+				       "meant to be\n"
+				       "squashed into the previous commit, "
+				       "run:\n\n"
+				       "  git commit --amend %s\n\n"
+				       "If they are meant to go into a new "
+				       "commit, run:\n\n"
+				       "  git commit %s\n\n"
+				       "In both cases, once you're done, "
+				       "continue with:\n\n"
+				       "  git rebase --continue\n"),
+				     gpg_opt, gpg_opt);
 		}
 	}
 
-- 
2.10.0.windows.1.325.ge6089c1
