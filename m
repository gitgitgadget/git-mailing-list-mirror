Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BBAB1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbcLITBh (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:01:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:56975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbcLITBg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:01:36 -0500
Received: from fermat.fritz.box ([88.70.156.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEWPx-1cQddo2hJ3-00Fi00; Fri, 09
 Dec 2016 20:01:29 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/5] am: Fix filename in safe_to_abort() error message
Date:   Fri,  9 Dec 2016 20:01:07 +0100
Message-Id: <20161209190111.9571-1-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g74d6bea
In-Reply-To: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:govwN4uJHdc53m/ZZ6H7kY4uC9918UwLBgK29AmP70/9jG64oa+
 tjfLieC6hGX7WSRNV/GwBqZcq5uPLOlq4JOpnLb7lQKUVXNVMbKEBrN6UwcWJtkiGMdVMWS
 HByBmM44qC/g+HVWDzm4LT/Y+xDqbdLHmG6sUPknPWcdYPHj+vJuMfizkxCNKKkv1zaG/K7
 IQeFWyC2Q/RlDwArWfvuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LJdoEzrBfVc=:Xw6T4JxQPuV3Q91Phdspo5
 FCC9QvcLCpnuqJ3B8J2kedjbs4GOcwMfac1AyMo3jlxgnRRKF7al2sT9H3DUrSRCscqwVNwNq
 DuKk+8q3RBRsLWnqWspYaoWKxKLmUslFKQg1MtYEz/HCOlMvMimuRZeA+eg1WbvxKUilaiJ/D
 hohjNNvWOgfeUgMr0ah5TvNU3RAMlEyY5okU6cS2l8e1N4LAtn9Oa81zfq0m5BA+DsrN+kR7C
 o10RIxRjj80TAS+bvETRnj4+uf1Fmk3f3w+TJLJYazdwACEHKH3xAwjgV1tGB3XG/Yv87ypZM
 sJwSLK3+WoYmXfwewDs+gf8MxADJURkTR5z1/ra3rYT88xLXoVKhi4Bb0ha7FbJ90eL3yDK8g
 YWH5VZyXU7wS1/saxloOkrM1J+bT+jrllHbZPIiZEnsiOOo2IfW2rN8fzAuNFrMWFoKxoUE+V
 NJFwqogCgVg/IpgcsgF9jKiNuJHhNJfOg+ZtYFXbFfkiijWQivwisxF9MsRS2sZ7gRJf9iT/Q
 qWDw0mxjXiUG+R90T8gEkNhruqSMrR6f8MOdtIOqAWeWRM2lPP43OmiPhUtLQowPOf+YdZiwB
 SvBql+Qd3IY06qsbtHu+vnet5Wy1JB+cWzhgznNUGe2vh+SL1mjdp9XIlPTbCnDfShBmGnz8+
 XNWsq9AOVh2t4nlEAAiSKvnGMPfsuBgyBtTG1GLKOa1/cTuUfWhrmJ1+tLBo/0PipgcGFGobb
 uk2zkntbPQr7jIXS4wFgo2l2lcWIpAV2TpWYNhu705LN8qGDJUfdEuBh4B8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6981f42ce..7cf40e6f2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2124,7 +2124,7 @@ static int safe_to_abort(const struct am_state *state)
 
 	if (read_state_file(&sb, state, "abort-safety", 1) > 0) {
 		if (get_oid_hex(sb.buf, &abort_safety))
-			die(_("could not parse %s"), am_path(state, "abort_safety"));
+			die(_("could not parse %s"), am_path(state, "abort-safety"));
 	} else
 		oidclr(&abort_safety);
 
-- 
2.11.0.27.g74d6bea

