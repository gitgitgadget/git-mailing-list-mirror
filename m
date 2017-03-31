Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0CAB1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 00:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755475AbdDAAqF (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 20:46:05 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34376 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755462AbdDAAqD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 20:46:03 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8F4B11D9E;
        Fri, 31 Mar 2017 15:47:17 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute7.internal (MEProxy); Fri, 31 Mar 2017 15:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antipode.se; h=
        cc:date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc:x-sasl-enc; s=fm1; bh=S8THhsiQoftbb8F1c+8K96zb/qQXYY
        fyAZnMdcMIxsc=; b=j5YcNjsXSQw4H1eRaWpQPQn2avV+qc/oIPcZvu/POreH8u
        tXgasIc7bKshlLLzV17dq1BEdbMf3kyYW0FVOKdjCHzCO1O4qjJQA1xRjtDISnLD
        leDsuyoLjIBjU6xzIyZfY3YCmWmKtzF+SePSPtac/nfbG5KWsq2kQr4c/7HSZUoz
        i2VOEn9RgG1fTBTuu6DcFZ2NTKD7J+fQP54BLWGNeVn3aiQcxR/nEZgku9hbYXXZ
        DELOpIoXMzZhxlKTUq/fvqBOqM5guVYmkqcklUbKUI//5/YIZtXP4lGahgDSpesK
        fv6CEtiUiU69dxFGdvU8nQNF1d2pnbWHucUTLfWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=S8THhs
        iQoftbb8F1c+8K96zb/qQXYYfyAZnMdcMIxsc=; b=E4TteQs/pSXF3qGUny+7pe
        hBREGeFdkRWXHNRB/893+skUXVLvdNiPfISoFWSW1n6b8c4sUidCCbteRoM2SCLd
        z4ONxaFgXU1Gmq/bL2N+ZpdQf8nN7fZ1hSrdgNQTFa6ooCSuhXj/PXttogsm6TRT
        qKwUB4HfrTrfGn+RIM2N3hq8z9RH20BM8RE+YYXE131oJau47ePA3itcCOYE264a
        UiHyMsDW/pP/yyFG5OwZslu+hlc9gIYgU0VO7Ph99oYk9jthp8nkWs0lM1j42vcS
        XrXxQE/fogXEpBLn1TxBGsQrRimmIhDJ+A3Tae1eTb6q8VswblrfPNzJ8Kq0cN6g
        ==
X-ME-Sender: <xms:RbLeWJlXJU_CZSHSPCLcCNZDibmEw2vyB8TMctLxKvFKjUREk5PwMg>
X-Sasl-enc: xlVNNqBwGP9T0M76/X3jResJOpcjPadxWP5EeqBzXRqP 1490989637
Received: from luciana.skrumpis (78-73-126-207-no292.tbcn.telia.com [78.73.126.207])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE0AF242B6;
        Fri, 31 Mar 2017 15:47:16 -0400 (EDT)
From:   Mostyn Bramley-Moore <mostyn@antipode.se>
To:     git@vger.kernel.org
Cc:     Mostyn Bramley-Moore <mostyn@antipode.se>
Subject: [PATCH] Documentation: improve git ls-files -s manpage entry
Date:   Fri, 31 Mar 2017 21:47:08 +0200
Message-Id: <20170331194708.22437-1-mostyn@antipode.se>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

List the fields in order of appearance in the command output.

Signed-off-by: Mostyn Bramley-Moore <mostyn@antipode.se>
---
 Documentation/git-ls-files.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1cab703..a9149fc 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -57,7 +57,8 @@ OPTIONS
 
 -s::
 --stage::
-	Show staged contents' object name, mode bits and stage number in the output.
+	Show staged contents' mode bits, hash, stage number as well as the
+	object name in the output.
 
 --directory::
 	If a whole directory is classified as "other", show just its
-- 
2.9.3

