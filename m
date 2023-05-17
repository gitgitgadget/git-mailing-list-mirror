Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2991C7EE23
	for <git@archiver.kernel.org>; Wed, 17 May 2023 15:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjEQPiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 11:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEQPiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 11:38:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA73E42
        for <git@vger.kernel.org>; Wed, 17 May 2023 08:38:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33B0D204A17;
        Wed, 17 May 2023 11:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ViPPUnpCirTS002/zHNb1ziW6yvh+/Yp3Sd78W
        T8qEM=; b=CL2FbBVlh3Us1SkaHsOL/xAOjdGwKewb9C9ufyThZ/pI93WsBt6HI6
        gYRlMWr4Fb6QBz+k3d62tQHppfaKRFF2LR1a5Wsc5VVHDTw+1VEYB1yZs97TLkiG
        8SkNpy2DF0VMXAyClJ83MXk7XGYEXglhrAbhJnIXewZDakAZeFEC4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CDA5204A16;
        Wed, 17 May 2023 11:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57C72204A15;
        Wed, 17 May 2023 11:38:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes/2.41.0: trivial case change in WWW-Authenticate
References: <20230517025148.1199907-1-tmz@pobox.com>
Date:   Wed, 17 May 2023 08:38:12 -0700
In-Reply-To: <20230517025148.1199907-1-tmz@pobox.com> (Todd Zullinger's
        message of "Tue, 16 May 2023 22:51:48 -0400")
Message-ID: <xmqq1qjfrmsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5AB11DE-F4C8-11ED-BA15-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Readers may wonder whether the upper case 'U' has special meaning in
> WWW-AUthenticate.  Use a lower case 'u' to save them from such thoughts.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> This caught my eye while reading the 2.41.0 release notes.  It's a long read
> this time -- folks here have been busy.

Thanks.  Somehow the Shift-key lingers on when I type capitalized
words and affects the second letter X-<.

> Nothing else jumped out, but I'm not a professional proofreader. ;)
>
> Thanks!
>
> Todd
>
>  Documentation/RelNotes/2.41.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.41.0.txt b/Documentation/RelNotes/2.41.0.txt
> index e177aff2d0..2bbf8fdc53 100644
> --- a/Documentation/RelNotes/2.41.0.txt
> +++ b/Documentation/RelNotes/2.41.0.txt
> @@ -3,7 +3,7 @@ Git v2.41 Release Notes
>  
>  UI, Workflows & Features
>  
> - * Allow information carried on the WWW-AUthenticate header to be
> + * Allow information carried on the WWW-Authenticate header to be
>     passed to the credential helpers.
>  
>   * A new "fetch.hideRefs" option can be used to exclude specified refs
