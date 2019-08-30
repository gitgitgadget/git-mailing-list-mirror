Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFA31F461
	for <e@80x24.org>; Fri, 30 Aug 2019 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfH3UMs (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 16:12:48 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:27789
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728086AbfH3UMr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Aug 2019 16:12:47 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 885F86A28E0;
        Fri, 30 Aug 2019 20:12:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a50.g.dreamhost.com (100-96-85-60.trex.outbound.svc.cluster.local [100.96.85.60])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CED706A30DE;
        Fri, 30 Aug 2019 20:12:40 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a50.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Fri, 30 Aug 2019 20:12:41 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Desert: 15e959957cb1a5c3_1567195961258_1058480091
X-MC-Loop-Signature: 1567195961258:651823239
X-MC-Ingress-Time: 1567195961258
Received: from pdx1-sub0-mail-a50.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a50.g.dreamhost.com (Postfix) with ESMTP id D489982503;
        Fri, 30 Aug 2019 13:12:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [38.27.161.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a50.g.dreamhost.com (Postfix) with ESMTPSA id CADB282D0F;
        Fri, 30 Aug 2019 13:12:34 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a50
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v3] clarify documentation for remote helpers
Date:   Fri, 30 Aug 2019 16:12:18 -0400
Message-Id: <20190830201218.21651-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigedgudegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghvihguucfvuhhrnhgvrhcuoeguthhurhhnvghrsehtfihoshhighhmrgdrtghomheqnecukfhppeefkedrvdejrdduiedurddujeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefkedrvdejrdduiedurddujedprhgvthhurhhnqdhprghthhepffgrvhhiugcuvfhurhhnvghruceoughtuhhrnhgvrhesthifohhsihhgmhgrrdgtohhmqedpmhgrihhlfhhrohhmpeguthhurhhnvghrsehtfihoshhighhmrgdrtghomhdpnhhrtghpthhtohepughtuhhrnhgvrhesthifohhsihhgmhgrrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Turner <dturner@twosigma.com>
---
 Documentation/gitremote-helpers.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremot=
e-helpers.txt
index 43f80c8068..a5c3c04371 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -297,9 +297,13 @@ Supported if the helper has the "option" capability.
 	same batch are complete. Only objects which were reported
 	in the output of 'list' with a sha1 may be fetched this way.
 +
-Optionally may output a 'lock <file>' line indicating a file under
-GIT_DIR/objects/pack which is keeping a pack until refs can be
-suitably updated.
+Optionally may output a 'lock <file>' line indicating the full path of
+a file under `$GIT_DIR/objects/pack` which is keeping a pack until
+refs can be suitably updated.  The path must end with `.keep`. This is
+a mechanism to name a <pack,idx,keep> tuple by giving only the keep
+component.  The kept pack will not be deleted by a concurrent repack,
+even though its objects may not be referenced until the fetch completes.
+The `.keep` file will be deleted at the conclusion of the fetch.
 +
 If option 'check-connectivity' is requested, the helper must output
 'connectivity-ok' if the clone is self-contained and connected.
--=20
2.20.1

