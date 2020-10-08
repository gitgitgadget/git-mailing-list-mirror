Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6370FC4363A
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 13:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1675E20754
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 13:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgJHNYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:24:08 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34262 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJHNYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 09:24:08 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id B9BCE3BAFF2
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 13:08:05 +0000 (UTC)
Received: from localhost (unknown [103.82.80.144])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8F7B110000E;
        Thu,  8 Oct 2020 13:07:43 +0000 (UTC)
Date:   Thu, 8 Oct 2020 18:37:41 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] git-gui: Basic dark mode support
Message-ID: <20201008130741.mz7k3uy65xdbdkeh@yadavpratyush.com>
References: <20200922110419.ymqj4ol76kg6qshf@yadavpratyush.com>
 <20200926145443.15423-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926145443.15423-1-serg.partizan@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/20 05:54PM, Serg Tereshchenko wrote:
> Removed forced colors in ttext widget calls,
> instead using Text.Background/Foreground options.
> This way colors can be configured dependent on current theme, and even
> overriden by user via .Xresources.
> 
> Extracted colors for in_sel/in_diff tags into colors:: namespace,
> where they can be configured from current theme colors.
> 
> Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
> ---
>  git-gui.sh     | 17 +++++++++++------
>  lib/themed.tcl | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 6 deletions(-)

Merged to git-gui/master. Thanks.

-- 
Regards,
Pratyush Yadav
