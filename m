Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224FDC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 20:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FBB239E4
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 20:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgLQUYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 15:24:37 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:30407 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbgLQUYg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 15:24:36 -0500
X-Originating-IP: 103.82.80.43
Received: from localhost (unknown [103.82.80.43])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D3BBC240006;
        Thu, 17 Dec 2020 20:23:54 +0000 (UTC)
Date:   Fri, 18 Dec 2020 01:53:52 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     stefan@haller-berlin.de, git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Fix selected text colors
Message-ID: <20201217202352.oia64d35wtwi3cce@yadavpratyush.com>
References: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
 <20201122133233.7077-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122133233.7077-1-serg.partizan@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/20 03:32PM, Serg Tereshchenko wrote:
> Stefan, please check if this fixes select colors for you.
> 
> --- 8< ---
> 
> Added selected state colors for text widget.
> 
> Same colors for active and inactive selection, to match previous
> behaviour.
> 
> Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
> ---
>  lib/themed.tcl | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to git-gui/master. Thanks.

-- 
Regards,
Pratyush Yadav
