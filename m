Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD466C04A94
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjHIRPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjHIRPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03CF2100
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 27C4B2425C
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:15:32 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lEe-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/3] rebase refactoring
Date:   Wed,  9 Aug 2023 19:15:28 +0200
Message-Id: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <xmqqiler8cga.fsf@gitster.g>
References: <xmqqiler8cga.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

broken out of the bigger series, as the aggregation just unnecessarily holds it
up.

Oswald Buddenhagen (3):
  rebase: simplify code related to imply_merge()
  rebase: handle --strategy via imply_merge() as well
  rebase: move parse_opt_keep_empty() down

 builtin/rebase.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

-- 
2.40.0.152.g15d061e6df

