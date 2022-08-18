Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C524C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbiHRNON (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbiHRNNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:13:47 -0400
Received: from mailproxy03.manitu.net (mailproxy03.manitu.net [217.11.48.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B2A69F75
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:13:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a5d:5400:e242:9824:2cff:8bd5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 0E09112A0187;
        Thu, 18 Aug 2022 15:13:30 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/4] sequencer: clarify translations
Date:   Thu, 18 Aug 2022 15:13:25 +0200
Message-Id: <cover.1660828108.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.2.596.g72ccb331cf
In-Reply-To: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

thanks for all your input to my RFC patch. I tried to summarize and pack
everything up into this little series.

A follow-up could (but does not have to) turn translated action names
into untranslated git command names in some places.

Cheers
Michael

Michael J Gruber (4):
  sequencer: do not translate reflog messages
  sequencer: do not translate parameters to error_resolve_conflict()
  sequencer: do not translate command names
  po: adjust README to code

 po/README.md |  2 +-
 sequencer.c  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.37.2.596.g72ccb331cf

