Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22FEC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33696141B
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhF1Sce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 14:32:34 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54223 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhF1Scd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 14:32:33 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 292704000A
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:30:05 +0000 (UTC)
Date:   Tue, 29 Jun 2021 00:00:04 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Subject: Applying a patch with a diff header in its commit message
Message-ID: <20210628183004.flxirucfv2celll3@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a patch at $DAYJOB that contains a diff header ("diff --git 
a/...") in its commit message, and unfortunately it is not indented. So 
naturally, git-am trips up and thinks it is the start of the main diff 
and tries to apply the diff starting there. It does not apply and the 
patch is rejected as being corrupt.

I know one option for me is to manually edit the patch and indent the 
diff header. But I would like to avoid that if possible. Is there any 
way to apply that patch as-is? Is it possible to tell git-am where to 
start looking for the diff?

-- 
Regards,
Pratyush Yadav
