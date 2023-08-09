Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D16C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjHIRPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjHIRPi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC01FEF
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:37 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id B311824304
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:15:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lDf-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/1] t/lib-rebase: (mostly) cosmetic improvements to set_fake_editor()
Date:   Wed,  9 Aug 2023 19:15:30 +0200
Message-Id: <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An update to the documentation, and two minor functional changes that don't
actually change anything given current use cases, and are therefore basically
documentation updates as well.

Oswald Buddenhagen (1):
  t/lib-rebase: improve documentation of set_fake_editor()

 t/lib-rebase.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.40.0.152.g15d061e6df

