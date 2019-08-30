Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972181F461
	for <e@80x24.org>; Fri, 30 Aug 2019 13:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfH3N6U (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 09:58:20 -0400
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:9904 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728324AbfH3N6U (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Aug 2019 09:58:20 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D2D035010C9;
        Fri, 30 Aug 2019 13:48:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a84.g.dreamhost.com (100-96-15-138.trex.outbound.svc.cluster.local [100.96.15.138])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9FDF15007E9;
        Fri, 30 Aug 2019 13:48:26 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a84.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.1);
        Fri, 30 Aug 2019 13:48:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Company-Sponge: 6388af16444bfe85_1567172907491_3066433969
X-MC-Loop-Signature: 1567172907491:39763420
X-MC-Ingress-Time: 1567172907490
Received: from pdx1-sub0-mail-a84.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a84.g.dreamhost.com (Postfix) with ESMTP id 25D327EFF2;
        Fri, 30 Aug 2019 06:48:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [38.27.161.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a84.g.dreamhost.com (Postfix) with ESMTPSA id 136257EFE7;
        Fri, 30 Aug 2019 06:48:20 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a84
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v2] clarify documentation for remote helpers
Date:   Fri, 30 Aug 2019 09:48:05 -0400
Message-Id: <20190830134805.9588-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigedgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepffgrvhhiugcuvfhurhhnvghruceoughtuhhrnhgvrhesthifohhsihhgmhgrrdgtohhmqeenucfkphepfeekrddvjedrudeiuddrudejnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfeekrddvjedrudeiuddrudejpdhrvghtuhhrnhdqphgrthhhpeffrghvihguucfvuhhrnhgvrhcuoeguthhurhhnvghrsehtfihoshhighhmrgdrtghomheqpdhmrghilhhfrhhomhepughtuhhrnhgvrhesthifohhsihhgmhgrrdgtohhmpdhnrhgtphhtthhopeguthhurhhnvghrsehtfihoshhighhmrgdrtghomhenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Turner <dturner@twosigma.com>
---
 Documentation/gitremote-helpers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremot=
e-helpers.txt
index 43f80c8068..f4a165387f 100644
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
+a file under $GIT_DIR/objects/pack which is keeping a pack until refs
+can be suitably updated.  The path must end with ".keep".
 +
 If option 'check-connectivity' is requested, the helper must output
 'connectivity-ok' if the clone is self-contained and connected.
--=20
2.20.1

