Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6F7C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbiCJS5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiCJS5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:57:47 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A6D19D75B
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:56:45 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5D171169B6;
        Thu, 10 Mar 2022 13:56:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cd4mom5k84ROqZePFWw9bf62UJP9WzidkLAo2d
        QJmss=; b=fNOJBYW3KXdqZoSmfz+DNqJ5iKj1OkTe0m8UoPWNkyrDmfz86j8oxi
        hEEhq2YJskaKBjp/aP+/jaSEsF27bhH6TjIWdNRjqGyt5YpVGpKgvnDpi6C9p98d
        pAekj4VTSaBio/tiluQYk+tPiW5mw6YNiMz8zggSZ416/5WvtJSqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC5181169B5;
        Thu, 10 Mar 2022 13:56:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01DFA1169B4;
        Thu, 10 Mar 2022 13:56:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] trace2 docs: surround more terms in backticks
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <284c6a3df84bed669790fe2f44905328269d1f4f.1646919331.git.gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 10:56:39 -0800
In-Reply-To: <284c6a3df84bed669790fe2f44905328269d1f4f.1646919331.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 10 Mar 2022
        13:35:29 +0000")
Message-ID: <xmqqee39eivs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D250F7DA-A0A3-11EC-9226-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/technical/api-trace2.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 77216eff622..8ef921a4e4d 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -70,7 +70,7 @@ $ cat ~/log.normal
>  
>  The performance format target (PERF) is a column-based format to
>  replace GIT_TRACE_PERFORMANCE and is suitable for development and

`GIT_TRACE_PERFORMANCE` to match `GIT_TRACE2_PERF` we see below.

> -testing, possibly to complement tools like gprof.  This format is
> +testing, possibly to complement tools like `gprof`.  This format is
>  enabled with the `GIT_TRACE2_PERF` environment variable or the
>  `trace2.perfTarget` system or global config setting.
>  
> @@ -172,7 +172,7 @@ take a `va_list` argument.
>  Some functions have a `_printf_fl()` suffix to indicate that they also
>  take a varargs argument.
>  
> -There are CPP wrapper macros and ifdefs to hide most of these details.
> +There are CPP wrapper macros and `#ifdef`s to hide most of these details.
>  See `trace2.h` for more details.  The following discussion will only
>  describe the simplified forms.
