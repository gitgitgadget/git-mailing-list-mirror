Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0147C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhK2XUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:20:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64929 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhK2XU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:20:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7998161867;
        Mon, 29 Nov 2021 18:17:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bDHysFo9Kp1VZE4fICdvKemnEteZ9Gf3DYNY8O
        P4XXM=; b=Bk8V4Z6z4CjzbhyMEQ0wmVahL1HlZlnvvSiK5HBo4d9nd+YQKL1EfV
        nbJAxkbQ6bxfwcVQO9FJC69M1Gco25Kz0jLVDqbN+OVzdof+wmDUsfeG84Iru2H0
        9+38ijdS1tKy53tS0dyXlKIVKGyuKL9JnPyEk6GJaw37e0P0dvdpk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0770161866;
        Mon, 29 Nov 2021 18:17:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B84C3161865;
        Mon, 29 Nov 2021 18:17:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 2/6] refs: update comment.
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <82971ddbfcf233c4462fb13eff8b742d84c72db0.1638211786.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:17:03 -0800
In-Reply-To: <82971ddbfcf233c4462fb13eff8b742d84c72db0.1638211786.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 29 Nov 2021
        18:49:42 +0000")
Message-ID: <xmqqo8624knk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 771249EC-516A-11EC-8D29-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> REF_IS_PRUNING is right below this comment, so it clearly does not belong in
> this comment. This was apparently introduced in commit 5ac95fee (Nov 5, 2017
> "refs: tidy up and adjust visibility of the `ref_update` flags").

Thanks for carefully reading and correcting.

>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/files-backend.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 151b0056fe5..5cfdec1e820 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -16,8 +16,7 @@
>   * This backend uses the following flags in `ref_update::flags` for
>   * internal bookkeeping purposes. Their numerical values must not
>   * conflict with REF_NO_DEREF, REF_FORCE_CREATE_REFLOG, REF_HAVE_NEW,
> - * REF_HAVE_OLD, or REF_IS_PRUNING, which are also stored in
> - * `ref_update::flags`.
> + * or REF_HAVE_OLD, which are also stored in `ref_update::flags`.
>   */
>  
>  /*
