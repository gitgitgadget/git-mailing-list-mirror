Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD91C001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjHGRJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjHGRJi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3777B1A4
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 10:09:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id AF3512429A
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:09:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3jb-nsJ-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 19:09:35 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] t/lib-rebase: (mostly) cosmetic improvements to set_fake_editor()
Date:   Mon,  7 Aug 2023 19:09:32 +0200
Message-Id: <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
References: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An update to the documentation, and two minor functional changes that don't
actually change anything given current use cases, and are therefore basically
documentation updates as well.

Oswald Buddenhagen (3):
  t/lib-rebase: set_fake_editor(): fix recognition of reset's short
    command
  t/lib-rebase: set_fake_editor(): handle FAKE_LINES more consistently
  t/lib-rebase: improve documentation of set_fake_editor()

 t/lib-rebase.sh | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.40.0.152.g15d061e6df

