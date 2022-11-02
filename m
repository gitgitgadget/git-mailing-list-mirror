Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42C3C43217
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiKBWs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKBWsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:48:55 -0400
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625FF6392
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:48:53 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id qMXSo68vDLVi2qMXSojVpE; Wed, 02 Nov 2022 22:48:51 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=QkSSStTfMLAkaxJcOzoA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [RFC/PoC 0/5] Provide example docbundles
Date:   Wed,  2 Nov 2022 22:48:38 +0000
Message-Id: <20221102224843.2104-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP+5GEMKmOJJ1OjmZfyD96VPuiapPur3v2rUxs7JwZAcvb/Mncp2kz08XkYkGHtKtUw4CjAhy1EpJD1AWqRH6t5+A76hrwsVWFP9zcAQZS6Sk/xFKqZZ
 a8Pc4ayHzhBJqNriM7sJLR9eFWxTwVY/3IgZfyzzVZLoRmw84ea0/S8oQybRTKzTMW1dgYSzKEL7lhtQ3wHAQgMV+9ciN0Oi+hXoeRgQEYoIg3eSyPnGYUDv
 OkGdJg9fF/yOOC9vE59RbFTsFwg5IJyE0TlX4N5f6zM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The man pages provide user facing examples which explain important
concepts, such as history-simplification. However users can have
difficulty in reproducing these examples to allow the exploration
of thr concepts. Let's provide these simple example, pre-packaged
as part of the documentation.

This Request for Comment (RFC) / Proof of Concept (PoC) attempts
to set out some design aims, and an outline implementation based
on using bundles for each example, and the test system for their
preparation.

Are there any obvious show-stoppers? 
Where best to hold the docbundle dir on various platforms?
How many examples to provide, and how to decide?
Usage of existing test repo examples?
etc.
--
Philip

Philip Oakley (5):
  doc: provide DocBundles design document
  Documentation Bundles: ignore artifact files from creating doc bundles
  test-lib: add GIT_BUNDLE_DIR setup
  Doc Bundles: add t6102 rev-list simple and pulls examples
  docbundle: provide the git-log History Simplication example

 .gitignore                            |   2 +
 Documentation/technical/docbundle.txt |  97 ++++++++++
 t/t6012-rev-list-simplify.sh          |   8 +
 t/t9990-history-simplification.sh     | 261 ++++++++++++++++++++++++++
 t/test-lib.sh                         |  14 ++
 5 files changed, 382 insertions(+)
 create mode 100644 Documentation/technical/docbundle.txt
 create mode 100644 t/t9990-history-simplification.sh

-- 
2.38.1.281.g83ef3ded8d

