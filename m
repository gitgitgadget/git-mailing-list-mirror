Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978AF1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 19:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfHETik (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 15:38:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62397 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 15:38:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DDD015F345;
        Mon,  5 Aug 2019 15:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wj1ihEk2JWNLdylJA8MZeoUNs2c=; b=qC3KE9
        WKhHJSr2N3TloSsV1NIg++0dTBoMCRbT41/nFDulAQ73pfaZ00YgGk55y2fcBAMT
        XvxAUJAobfRNYQXumZLQ+mrmGesGozhyBzwWDGGs7pMy/lIpMVz8xEdv3yWTJWYA
        5nA4hR63IOCWOcO9NFbh/RmtYoCwk7aZ6/zQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MTOugLHls7b+YKbyBbq8q9rlXY1jSdag
        grvpP+rjQbaG7+/2OSncNdzMJzvC6KLMwuQLxJnS2gQKp/mLvcTRDAd8MlEJgo1f
        94RSzwE7Su9g1k8SmNGGoF6UXriBCYTTXVvKDlOFtMhbq4h7kwKjlMossyiI/GoI
        fc5Oj0yzMH0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7591B15F344;
        Mon,  5 Aug 2019 15:38:38 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E211C15F343;
        Mon,  5 Aug 2019 15:38:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Chargin <wchargin@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] restore: fix typo in docs
References: <20190803220457.9338-1-wchargin@gmail.com>
Date:   Mon, 05 Aug 2019 12:38:36 -0700
In-Reply-To: <20190803220457.9338-1-wchargin@gmail.com> (William Chargin's
        message of "Sat, 3 Aug 2019 15:04:58 -0700")
Message-ID: <xmqqmugnmmgz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EE81C56-B7B8-11E9-BF89-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Chargin <wchargin@gmail.com> writes:

> Signed-off-by: William Chargin <wchargin@gmail.com>
> ---
> Assuming this is a typo, because I can't parse the sentence.

Looks good.  Thanks.

>
>  Documentation/git-restore.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
> index d90093f195..1ab2e40ea9 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -39,7 +39,7 @@ OPTIONS
>  	commit, branch or tag associated with it.
>  +
>  If not specified, the default restore source for the working tree is
> -the index, and the default restore source for the index index is
> +the index, and the default restore source for the index is
>  `HEAD`. When both `--staged` and `--worktree` are specified,
>  `--source` must also be specified.
