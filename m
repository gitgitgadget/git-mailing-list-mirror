Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026BEB64DC
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 05:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjGHFhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 01:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjGHFhB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 01:37:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C232128
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 22:36:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85E3B19C362;
        Sat,  8 Jul 2023 01:36:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3SZIwT1Ygub+lS/2OAEftfdhSycsHYR99nwHLm
        VBkdQ=; b=spf4uI1ijx4IE8eMPNcOKc1e8ReBcS0GfYoUrYIny9icgd/qXv2diJ
        MI80HEegp1iQsCwmvuz7PCx1YPFvilcf1NJEjyUmeTUB80QlMTIs0svyM2j0GE+z
        YgwTM3U0Jb64HqIY+omcLYMrCgV5Xoa/FW9kHFX20WfJUXcK70Q/U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B20519C360;
        Sat,  8 Jul 2023 01:36:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCFBE19C35F;
        Sat,  8 Jul 2023 01:36:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 2/5] SubmittingPatches: be more explicit
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <203ed19dd1b72a8085af05359d5a226b94fe2c7f.1688778359.git.gitgitgadget@gmail.com>
Date:   Fri, 07 Jul 2023 22:36:54 -0700
In-Reply-To: <203ed19dd1b72a8085af05359d5a226b94fe2c7f.1688778359.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Sat, 08 Jul 2023 01:05:56
        +0000")
Message-ID: <xmqqo7kn6k21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 734F77BC-1D51-11EE-B494-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---

If you leave the body of the commit log message empty, can we
at least have a bit more helpful title so that it is clear what we
are being more explicit about?

>  [[base-branch]]
> -=== Decide what to base your work on.
> +=== Decide which branch to base your work on.

Technically speaking, what the user needs to decide here is on top
of what commit to base their work on.  There may not be a suitable
branch anywhere.

But this series will be updating the section even more in the later
steps, so let's read on.



> @@ -317,8 +317,8 @@ Please make sure your patch does not add commented out debugging code,
>  or include any extra files which do not relate to what your patch
>  is trying to achieve. Make sure to review
>  your patch after generating it, to ensure accuracy.  Before
> -sending out, please make sure it cleanly applies to the base you
> -have chosen in the "Decide what to base your work on" section,
> +sending out, please make sure it cleanly applies to the branch you
> +have chosen in the "Decide which branch to base your work on" section,
>  and unless it targets the `master` branch (which is the default),
>  mark your patches as such.
