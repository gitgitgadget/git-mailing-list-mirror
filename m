Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC9FC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 15:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC1264ED6
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 15:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhBVPDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:03:42 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:54037 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhBVPDe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 10:03:34 -0500
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 5B7093B10A6
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 14:52:47 +0000 (UTC)
X-Originating-IP: 103.82.80.142
Received: from localhost (unknown [103.82.80.142])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1C27940019;
        Mon, 22 Feb 2021 14:51:39 +0000 (UTC)
Date:   Mon, 22 Feb 2021 20:21:37 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git-gui: remove lines starting with the comment
 character
Message-ID: <20210222145137.b7lmgzpmm5q4m2qf@yadavpratyush.com>
References: <20210218181937.83419-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218181937.83419-1-me@yadavpratyush.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/02/21 11:49PM, Pratyush Yadav wrote:
> The comment character is specified by the config variable
> 'core.commentchar'. Any lines starting with this character is considered
> a comment and should not be included in the final commit message.
> 
> Teach git-gui to filter out lines in the commit message that start with
> the comment character using git-stripspace. If the config is not set,
> '#' is taken as the default. Also add a message educating users about
> the comment character.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

Applied to git-gui/master.

-- 
Regards,
Pratyush Yadav
