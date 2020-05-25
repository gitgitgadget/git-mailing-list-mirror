Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A046C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7462071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390926AbgEYOt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgEYOt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 10:49:28 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 May 2020 07:49:28 PDT
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D085C061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 07:49:28 -0700 (PDT)
Received: from smtp.soverin.net (unknown [10.10.3.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 559E8601BF;
        Mon, 25 May 2020 14:42:45 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [159.69.232.138]) by soverin.net
From:   Toon Claes <toon@iotcl.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/1] Documentation fix related to hash algorithm
Date:   Mon, 25 May 2020 16:41:37 +0200
Message-Id: <20200525144138.1624272-1-toon@iotcl.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.3 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was doing some research on the SHA256 implementation, and I discovered a
mismatch between the docs and the code. I have a patch attached that fixes the
docs.

Toon Claes (1):
  Documentation: correct hash environment variable

 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.27.0.rc1.72.g3440a8306a
