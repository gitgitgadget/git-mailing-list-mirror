Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30996ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 15:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiIPPjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiIPPjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 11:39:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B2B7E3
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 08:39:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AE6C1B8B28;
        Fri, 16 Sep 2022 11:39:32 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=nF6uFMtOwvJ2daYKLpxaZNOLiWSVrzI8JajAgLU
        E+x0=; b=DLcXN55qDqCXaJBYbPqzJTOZ/To7JECZgs9+aRJmr4YEfQRcc1PTCJk
        OOIYildhL05NlvyUpKWUlSdhZcQHpTxZF6NRDFLdyrY+a5lPBI3zP0RsgPHAm44V
        CbgPoZfAadfHmBA3FqI+jEO9eiSIQ6wgyArHfXN7TxkaW6wBaFKg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8239D1B8B27;
        Fri, 16 Sep 2022 11:39:32 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.78])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD55B1B8B24;
        Fri, 16 Sep 2022 11:39:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 16 Sep 2022 11:39:23 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] environ: simplify description of GIT_INDEX_FILE
Message-ID: <YySYq94EEGfwXMjd@pobox.com>
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
 <20220915160659.126441-5-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915160659.126441-5-gitster@pobox.com>
X-Pobox-Relay-ID: BF2D5C58-35D5-11ED-9652-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 3d31252bf2..535ff561c6 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -472,7 +472,7 @@ is worth noting that they may be used/overridden by SCMS sitting above
>  Git so take care if using a foreign front-end.
>  
>  `GIT_INDEX_FILE`::
> -	This environment allows the specification of an alternate
> +	This environment specifies an alternate

While here, `s/environment/& variable/` would make this a
bit easier to read and more consistent with the nearby
descriptions.

-- 
Todd
