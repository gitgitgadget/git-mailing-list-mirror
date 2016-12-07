Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5453F1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbcLGVwF (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:52:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:55705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932987AbcLGVwE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:52:04 -0500
Received: from fermat.fritz.box ([92.76.239.239]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDm4o-1cRRxe3Xig-00H5oK; Wed, 07
 Dec 2016 22:51:53 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] am: Fix filename in safe_to_abort() error message
Date:   Wed,  7 Dec 2016 22:51:29 +0100
Message-Id: <20161207215133.13433-1-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g4eed97c
In-Reply-To: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:olSp2UMniZ+G0DbDkjS6Eg8obq/LzbFnlQFy+ppzqCLD3ot/Vwl
 I9c4DWbgBrtXihUu9xNTWboPxPPtCLJ8nO+44c1CEP1yxT5V8LwzpAVwN30LY7fmSvjnKYj
 BORkoR23tArGOst+8OqfUo6jZNWJ7ofb7RJNdu/+lUhbwgnF15G33XNRDpl7NwvgXUrzJGV
 8JbgRwUjsOTUF0qDNLhjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FMq6Q7qNN5k=:HIwdxEiJxHa7c8KoOn07ki
 kCped9rxe/9GiYb9NWJblUOxtANsv25u7pyvY9+c8ByUu4Tb/oYuF8hbyx24Gmq4hAw6d+OOO
 u4EyuMmH5wn8ealrwXhptAwS+vYTnVRW1Hd9jCULvLD2ZRPsbmGgfuoVhgGfhX2s2cx2/y9U0
 E70eEBcF0Cjj650frsaiyiHqSQsihpbpmTfxi/QfCTBCbUiGOvg6b9NRsyP6Yrmbm8LpjFuhM
 paort+o6EpMr1kpCyaoRvUu/xsAgp+a3F70N0Iw3HHwicG2u/M5EzQ3vzcIUbdvS04P/Ki/Rs
 aWjDyzjBV+I5JrpA73k3S+LaS3Ssh/bQeYaxQWynVMU9i0x8/xo9cPfXDSFxR7deHBxJZFDfY
 y2R/8fs8Gdii6nog1E+sL9KHF74nR0w3bB2EcSW78FmJs24dYog9GdBxrVc0oG7GpnQa01Zeo
 PUSL3SztkyaqX1JRzMLSn+0gu0eCrlgQH+RddU6jKdo1oKSMSIr5JLIQMeX+RI2NWvNAC3HMW
 y+KzKOhuR5OXOqnXiYjecnlSVhPo8xIfc8DP9Qv7yVpHKTPpYroYqMXms9u1Q3DQ5khjLhzaW
 yRREAFpSeqZE4Opv4a/eR4hFPX0mNP6mHyL6SJ+BmV767rNoHmeBsJpsqAYUCDh/AbcLyB/GS
 hv6SvXiKu6mda1W4utJeanR54qHi9FglhznZVXH6KN2zBe5Sx92cF7rc93MRzjoSrhnBoFmA7
 swhF8aPJXiBORk1NrHQhu2DK9Wo+ffgH444y8Wyaw/N5fioksDpV0r3P9gM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Okay let's give it a try. Some minor things that I found
 are also in this patchset (patch 01, 02 and 05).
 The branch can also be found on
   https://github.com/sbeyer/git/commits/sequencer-abort-safety

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
2.11.0.27.g4eed97c

