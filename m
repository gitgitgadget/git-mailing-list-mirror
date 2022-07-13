Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD204C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 15:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiGMPXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 11:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiGMPXI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 11:23:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05384B48D
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 08:23:07 -0700 (PDT)
Received: (qmail 15099 invoked by uid 109); 13 Jul 2022 15:23:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jul 2022 15:23:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13167 invoked by uid 111); 13 Jul 2022 15:23:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jul 2022 11:23:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jul 2022 11:23:06 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] *: use allowlist and denylist
Message-ID: <Ys7jWgjhkavPxFDn@coredump.intra.peff.net>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <8aaceedb7a8f9d95550ef4a2d147c837ede6acec.1657718450.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8aaceedb7a8f9d95550ef4a2d147c837ede6acec.1657718450.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 01:20:50PM +0000, Derrick Stolee via GitGitGadget wrote:

> @@ -1444,7 +1444,7 @@ int cmd_main(int argc, const char **argv)
>  		cred = prepare_credentials(user_name, group_name);
>  
>  	if (strict_paths && (!ok_paths || !*ok_paths))
> -		die("option --strict-paths requires a whitelist");
> +		die("option --strict-paths requires a allowlist");

Here's another s/a/an/ case. I think there are a few others in comments
in other parts of the patch.

-Peff
