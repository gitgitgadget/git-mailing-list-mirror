Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C31C433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB9B206F1
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgEZShs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 14:37:48 -0400
Received: from outbound.soverin.net ([116.202.65.218]:50327 "EHLO
        outbound.soverin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgEZShs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 14:37:48 -0400
Received: from smtp.soverin.net (unknown [10.10.3.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id ED8A260060
        for <git@vger.kernel.org>; Tue, 26 May 2020 18:37:45 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [159.69.232.142]) by soverin.net
From:   Toon Claes <toon@iotcl.com>
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/1] Documentation fix related to hash algorithm
Date:   Tue, 26 May 2020 20:37:19 +0200
Message-Id: <20200526183720.120314-1-toon@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: clamav-milter 0.102.3 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was doing some research on the SHA256 implementation, and I discovered
a mismatch between the docs and the code. I have a patch attached that
fixes the docs.

This is version 2, which has a slightly nicer commit message as
suggested by Martin Ågren.

Martin Ågren also mentioned[0] this discrepancy is added on 2020-02-22
in 3c9331a129, which added both the documentation and the
implementation. As developers-only as this variable is, that commit was
not in v2.26.0, so this might be worth fixing before cutting v2.27.0.

[0] https://lore.kernel.org/git/20200525144138.1624272-1-toon@iotcl.com/T/#m637dc0692962e882928e035888435267b784ee17

Toon Claes (1):
  Documentation: correct hash environment variable

 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.27.0.rc1.73.g31835d1b01
