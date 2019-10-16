Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1E131F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 02:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfJPCGP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 22:06:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54827 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJPCGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 22:06:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B0FCA3556;
        Tue, 15 Oct 2019 22:06:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LxJBUIbZt9BN
        Om2Gbdii6rVIl5s=; b=a6+V9EerZPOUKeZwzVUwW+fLK9OXF3ysX8Hc1lSOT019
        3ifCCF7YRFWGYYk0vu2yhUmsmzPs/h7Wkxe51xTdb4IP2AssNJ7lzXoPKXKzFtoF
        COEFr+kMfN4chpuCtE93UDOQGokltNGZc3glp4x451E3ANLpBwDk14tyBwM87UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cHyGe4
        RxH8JVsGCCbhFgHgZojHu5uoP+92FyL5RhkozwLa/9Eut/WYrPuGmUEgHUSrKwpE
        kCiIwmJdv4wOCrjy/8wlvpnFSuV8cLPjxiFu4H9u3p1tuaOYSZwm5M0TWRzfmd4p
        xsJ5nALTSDDmWEt4Ol0VZaw21VUgXesO3CNgA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72B2EA3555;
        Tue, 15 Oct 2019 22:06:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 982B8A3551;
        Tue, 15 Oct 2019 22:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Maxim Belsky via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Max Belsky <public.belsky@gmail.com>
Subject: Re: [PATCH v3 1/1] doc: Change zsh git completion file name
References: <pull.367.v2.git.gitgitgadget@gmail.com>
        <pull.367.v3.git.1571165293.gitgitgadget@gmail.com>
        <7919addea85597c3c910a09cbc1d931c6f71c544.1571165293.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 11:06:08 +0900
In-Reply-To: <7919addea85597c3c910a09cbc1d931c6f71c544.1571165293.git.gitgitgadget@gmail.com>
        (Maxim Belsky via GitGitGadget's message of "Tue, 15 Oct 2019 18:48:13
        +0000")
Message-ID: <xmqqlftla1gv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 85ECB264-EFB9-11E9-AE00-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Maxim Belsky via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Maxim Belsky <public.belsky@gmail.com>
> Subject: Re: [PATCH v3 1/1] doc: Change zsh git completion file name

Lack of attention to the detail.  This is not about changing the
filename anymore.

    Subject: [PATCH v3] completion: clarify installation instruction for =
zsh

perhaps.  I'll make the change locally, so unless there are other
changes you want to make, there is no need to resend.

Thanks.

> The original comment does not describe type of ~/.zsh/_git explicitly
> and zsh does not warn or fail if a user create it as a dictionary.
> So unexperienced users could be misled by the original comment.
>
> There is a small update to clarify it.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Maxim Belsky <public.belsky@gmail.com>
> ---
>  contrib/completion/git-completion.zsh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion=
/git-completion.zsh
> index 886bf95d1f..b480e3f316 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -11,8 +11,9 @@
>  #
>  #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
>  #
> -# The recommended way to install this script is to copy to '~/.zsh/_gi=
t', and
> -# then add the following to your ~/.zshrc file:
> +# The recommended way to install this script is to make a copy of it i=
n
> +# '~/.zsh/' directory as '~/.zsh/_git' and then add the following to y=
our
> +# ~/.zshrc file:
>  #
>  #  fpath=3D(~/.zsh $fpath)
