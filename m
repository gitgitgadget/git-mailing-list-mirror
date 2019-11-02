Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09041F454
	for <e@80x24.org>; Sat,  2 Nov 2019 05:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKBFnt (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 01:43:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60194 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBFns (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 01:43:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF76637892;
        Sat,  2 Nov 2019 01:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LGkD28lXMc/ZpfidNJokRWRzWRU=; b=J44Cxr
        TbI86HjJEbyIwx21kM9J23mCETKGaCw1NZH00FvpVxSIWQ/s2U3+nLK8/q7/V2/t
        BT5UafgjuuLjUpwuysf8HYmETM0y+EmAmrMv+A8I66ju3AdnyCYTsFhC7m7vrQ2x
        bEQc06TBUG0uGAN2Txr54BjlVCv/99/3NJ7Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ISLMTTMk3ONqIRdFpm7tkTNptaL0K9xs
        f2I5s1mVII8MUHwR2SmAud3WwMOxGoO5rH2GRvR34MaN4P8EEARHMnSKzqky8LD8
        Nt8iTfxk1/jFXFWwwmtGLMgktdpcmjN98Ww4FZFuijE51nUftMz15HeHls6qxCDu
        fgOEjxobVY4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B69B737891;
        Sat,  2 Nov 2019 01:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23C4A3788F;
        Sat,  2 Nov 2019 01:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] RelNotes/2.24.0: typofix
References: <pull.440.git.1572466878.gitgitgadget@gmail.com>
        <2e1ebe70820fd4cbc40df1f89779c77b9ceea881.1572466878.git.gitgitgadget@gmail.com>
Date:   Sat, 02 Nov 2019 14:43:45 +0900
In-Reply-To: <2e1ebe70820fd4cbc40df1f89779c77b9ceea881.1572466878.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 30 Oct 2019
        20:21:17 +0000")
Message-ID: <xmqqbltu4yum.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCA56954-FD33-11E9-A0D9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/RelNotes/2.24.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.24.0.txt b/Documentation/RelNotes/2.24.0.txt
> index b7083cd6b2..26e018078d 100644
> --- a/Documentation/RelNotes/2.24.0.txt
> +++ b/Documentation/RelNotes/2.24.0.txt
> @@ -316,7 +316,7 @@ Fixes since v2.23
>     to access the worktree correctly, which has been corrected.
>     (merge dfd557c978 js/stash-apply-in-secondary-worktree later to maint).
>  
> - * The merge-recursive machiery is one of the most complex parts of
> + * The merge-recursive machinery is one of the most complex parts of
>     the system that accumulated cruft over time.  This large series
>     cleans up the implementation quite a bit.
>     (merge b657047719 en/merge-recursive-cleanup later to maint).

Thanks.
