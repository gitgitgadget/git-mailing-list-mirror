Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49DDC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 18:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388820AbiEFSP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiEFSP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 14:15:57 -0400
Received: from mailproxy07.manitu.net (mailproxy07.manitu.net [217.11.48.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF16D97A
        for <git@vger.kernel.org>; Fri,  6 May 2022 11:12:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a00:20:704b:4372:c7cc:d7c9:fd95:983d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id 1DA89C88A9;
        Fri,  6 May 2022 20:04:23 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] quell a few gcc warnings
Date:   Fri,  6 May 2022 20:04:04 +0200
Message-Id: <cover.1651859773.git.git@grubix.eu>
X-Mailer: git-send-email 2.36.0.553.g068b50827d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New Fedora, new gcc, new warnings. This mini series quells them.

Michael J Gruber (2):
  dir.c: avoid gcc warning
  http.c: avoid gcc warning

 dir.c  | 2 +-
 http.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.36.0.553.g068b50827d

