Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06861F461
	for <e@80x24.org>; Thu, 29 Aug 2019 21:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfH2VE3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 17:04:29 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:18713
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbfH2VE3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 17:04:29 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A3F452C2D7A;
        Thu, 29 Aug 2019 21:04:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (100-96-45-15.trex.outbound.svc.cluster.local [100.96.45.15])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EB4CC2C2572;
        Thu, 29 Aug 2019 21:04:26 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a35.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Thu, 29 Aug 2019 21:04:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Turn-Macabre: 66aeda9d04696d1c_1567112667378_3217876287
X-MC-Loop-Signature: 1567112667378:1699084483
X-MC-Ingress-Time: 1567112667378
Received: from pdx1-sub0-mail-a35.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a35.g.dreamhost.com (Postfix) with ESMTP id B2CDD7F656;
        Thu, 29 Aug 2019 14:04:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [38.27.161.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a35.g.dreamhost.com (Postfix) with ESMTPSA id 69C387F5E0;
        Thu, 29 Aug 2019 14:04:20 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a35
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH] clarify documentation for remote helpers
Date:   Thu, 29 Aug 2019 17:03:02 -0400
Message-Id: <20190829210301.18467-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeivddgudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghvihguucfvuhhrnhgvrhcuoeguthhurhhnvghrsehtfihoshhighhmrgdrtghomheqnecukfhppeefkedrvdejrdduiedurddujeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefkedrvdejrdduiedurddujedprhgvthhurhhnqdhprghthhepffgrvhhiugcuvfhurhhnvghruceoughtuhhrnhgvrhesthifohhsihhgmhgrrdgtohhmqedpmhgrihhlfhhrohhmpeguthhurhhnvghrsehtfihoshhighhmrgdrtghomhdpnhhrtghpthhtohepughtuhhrnhgvrhesthifohhsihhgmhgrrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Turner <dturner@twosigma.com>
---

This doesn't address the connectivity-ok problem, which I continue to
worry is a real bug.  But it would have saved me a few minutes of
debugging.

 Documentation/gitremote-helpers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremot=
e-helpers.txt
index 43f80c8068..30001b2054 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -297,9 +297,9 @@ Supported if the helper has the "option" capability.
 	same batch are complete. Only objects which were reported
 	in the output of 'list' with a sha1 may be fetched this way.
 +
-Optionally may output a 'lock <file>' line indicating a file under
-GIT_DIR/objects/pack which is keeping a pack until refs can be
-suitably updated.
+Optionally may output a 'lock <file>' line indicating the full path of
+a file under under GIT_DIR/objects/pack which is keeping a pack until
+refs can be suitably updated.  The path must end with ".keep".
 +
 If option 'check-connectivity' is requested, the helper must output
 'connectivity-ok' if the clone is self-contained and connected.
--=20
2.20.1

