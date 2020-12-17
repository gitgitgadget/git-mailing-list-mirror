Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38515C2BBCA
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0235023877
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgLQTEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:04:02 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:34437 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQTEC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 14:04:02 -0500
Received: from localhost (unknown [103.82.80.43])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5F2D624000B;
        Thu, 17 Dec 2020 19:03:19 +0000 (UTC)
Date:   Fri, 18 Dec 2020 00:33:17 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-gui: fix colored label backgrounds when using
 themed widgets
Message-ID: <20201217190317.pbsozw7kl5vxtwmi@yadavpratyush.com>
References: <20201122194537.41870-1-stefan@haller-berlin.de>
 <20201122194537.41870-2-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122194537.41870-2-stefan@haller-berlin.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/20 08:45PM, Stefan Haller wrote:
> The aqua theme on Mac doesn't support changing the background color for labels
> and frames [1]. Since the red, green, and yellow backgrounds of the labels for
> unstaged and staged files and the diff pane are so important design elements of
> git gui's main window, it's not acceptable for them to have grey backgrounds on
> Mac.
> 
> To work around this, simply use non-themed widgets for all labels on Mac. This
> is not a big problem because labels don't look extremely different between the
> themed and non-themed versions. There are subtle differences, but they are not
> as bad as having the wrong background color.
> 
> [1] https://stackoverflow.com/a/6723911
> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
>  lib/themed.tcl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to git-gui/master. Thanks.

-- 
Regards,
Pratyush Yadav
