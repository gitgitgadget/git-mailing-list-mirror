Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A9C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 18:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiGaSuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 14:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaSue (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 14:50:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B81DAE72
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:50:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BCA81B786F;
        Sun, 31 Jul 2022 14:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=224km24Q+G+nAib28hVR3NMp94h3tmREMUMsMX
        55CTs=; b=VDPeuvSO8TCf1aYv9tL1Qfk0XUZf7JNN/w1yqqhx9+VTDCWqp423jl
        XvbK/1anYP4+fKQZO1sFV+w3Wshr5IT11HOEMDxmpad8hn0799RmbW4r+7q4uaJi
        WkfGI7KzRCIr0dkeaWJNIQPgnR9La0IvHXUHkYBZb3n3Z5kdJEdOI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 856B91B786E;
        Sun, 31 Jul 2022 14:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08E001B786B;
        Sun, 31 Jul 2022 14:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2022, #08; Fri, 29)
References: <xmqq7d3v33to.fsf@gitster.g>
        <YuXM4pmsuDzIqbQT@coredump.intra.peff.net>
Date:   Sun, 31 Jul 2022 11:50:26 -0700
In-Reply-To: <YuXM4pmsuDzIqbQT@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 30 Jul 2022 20:29:22 -0400")
Message-ID: <xmqqedy115hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5132C42-1101-11ED-B5C7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you get a chance before merging, can you please squash in this
> typo-fix?

Ah, sure.  

Sorry, I did see that "oops" message but didn't react to it.  Now
it's done.

Thanks.

> diff --git a/config.mak.dev b/config.mak.dev
> index b9878a4994..4fa19d361b 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -60,7 +60,7 @@ endif
>  # uninitialized warnings on gcc 4.9.2 in xdiff/xdiffi.c and config.c
>  # not worth fixing since newer compilers correctly stop complaining
>  #
> -# Likwise, gcc older than 4.9 complains about initializing a
> +# Likewise, gcc older than 4.9 complains about initializing a
>  # struct-within-a-struct using just "{ 0 }"
>  ifneq ($(filter gcc4,$(COMPILER_FEATURES)),)
>  ifeq ($(filter gcc5,$(COMPILER_FEATURES)),)
>
> Thanks.
>
> -Peff
