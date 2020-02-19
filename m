Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF522C5ACC5
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535DF207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BAQCeEug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBSX02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:26:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61339 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgBSX02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 18:26:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E287A3F774;
        Wed, 19 Feb 2020 18:26:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DVnu6tgKHblkg43puxmPNIsb9vo=; b=BAQCeE
        ugUNPnUgh6PM1/0D263S0Vix21EjM3q7IawWGfFN0gvKByAYGe+Fuxpn5BHOe3KJ
        Fzq7blwifMOzvRps+J68SfRKyasZZaAeu3+vpe1gOplYggUhsvss1z7+5Wb5Cewa
        Ou4WqK9FddfCDQU8+3j63Wm9rTa8XJJAhIDGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bj9J2RyF2zpzh4tbnL+WLvtUk+N5+b0D
        IfkSDn7Ko8Bc3n6fDxM8w+wlHAemyKcP9dsIfOiAh1Gd/daVXBA5qV7MsE/vcZem
        p8nEzVrEFr1kji3tIVlOFrh6FNMyawESygG8uPPBo94ovjwZv++eTHPX1TZ0dakp
        L4JE1/EH/ls=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA5783F773;
        Wed, 19 Feb 2020 18:26:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 433BE3F772;
        Wed, 19 Feb 2020 18:26:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/6] t7112: remove mention of KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED
References: <pull.555.git.1581915186.gitgitgadget@gmail.com>
        <5a271857a1176ede2ac9c894dcb436758e28a79f.1581915186.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 15:26:25 -0800
In-Reply-To: <5a271857a1176ede2ac9c894dcb436758e28a79f.1581915186.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 17 Feb 2020
        04:53:01 +0000")
Message-ID: <xmqqh7zmcg66.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4044A7D4-536F-11EA-A9BF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The known failure mode KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED was
> removed from lib-submodule-update.sh in 218c883783 (submodule: properly
> recurse for read-tree and checkout, 2017-05-02) but at that time this
> change was not ported over to topic sb/reset-recurse-submodules, such
> that when this topic was merged in 5f074ca7e8 (Merge branch
> 'sb/reset-recurse-submodules', 2017-05-29), t7112-reset-submodules.sh
> kept a mention of this removed failure mode.
>
> Remove it now, as it does not mean anything anymore.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/t7112-reset-submodule.sh | 1 -
>  1 file changed, 1 deletion(-)

Thanks for cleaning up.

>
> diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
> index a1cb9ff858e..67346424a53 100755
> --- a/t/t7112-reset-submodule.sh
> +++ b/t/t7112-reset-submodule.sh
> @@ -5,7 +5,6 @@ test_description='reset can handle submodules'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-submodule-update.sh
>  
> -KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
>  KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
>  KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
