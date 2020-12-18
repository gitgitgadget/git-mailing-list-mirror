Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A115C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9AF239FE
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLRMwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 07:52:36 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54119 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgLRMwg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 07:52:36 -0500
X-Originating-IP: 103.82.80.101
Received: from localhost (unknown [103.82.80.101])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CA2E21C0004;
        Fri, 18 Dec 2020 12:51:53 +0000 (UTC)
Date:   Fri, 18 Dec 2020 18:21:51 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     serg.partizan@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3] git-gui: use gray background for inactive text widgets
Message-ID: <20201218125151.zbuye67xbka7qphe@yadavpratyush.com>
References: <20201217214912.ycp7bidcyqwzslxy@yadavpratyush.com>
 <20201218094314.22138-1-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218094314.22138-1-stefan@haller-berlin.de>
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/12/20 10:43AM, Stefan Haller wrote:
> This makes it easier to see at a glance which of the four main views has the
> keyboard focus.
> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
> Hi Pratyush,
> 
> here's a rerolled version with added Signed-off-by and using local variables for
> inactive_select_bg and inactive_select_bg, hoping this might save you some time.
> Let me know if this is what you had in mind, I wasn't totally sure.

Yes, this is what I wanted. Thanks. Will apply.

-- 
Regards,
Pratyush Yadav
