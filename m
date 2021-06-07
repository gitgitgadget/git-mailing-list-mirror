Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF26C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04198600EF
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFGTEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:04:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63803 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhFGTEY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 15:04:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED260BF55E;
        Mon,  7 Jun 2021 15:02:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X70xzKpKH0saNdx7eiKkXG+e4naQ3KpKjIQz99
        GvQkQ=; b=vIlXJOVAclMuv9yrkjgwRnHDbY/CpXGUkk6r8a8zqkXriFeIopZ5eh
        PLvFViUfLWsdpzIk6fM6TJ3icC1ORalJ/ZdKBoBrnqoY66ZrmWveaPBZ2qESZG2D
        /LJtbD6MomA9RW6IEGRBlqTL+R7Nkyq0huWIcvQqlIoC2Gqeiotjg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0F6FBF55B;
        Mon,  7 Jun 2021 15:02:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54BA2BF55A;
        Mon,  7 Jun 2021 15:02:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] *: use singular they in comments
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 04:02:30 +0900
In-Reply-To: <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 07 Jun 2021
        16:57:46 +0000")
Message-ID: <xmqqwnr5ts55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E91FEA08-C7C2-11EB-BF67-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1178,7 +1178,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
>  	/*
>  	 * We could verify this signature and either omit the tag when
>  	 * it does not validate, but the integrator may not have the
> -	 * public key of the signer of the tag he is merging, while a
> +	 * public key of the signer of the tag they are merging, while a
>  	 * later auditor may have it while auditing, so let's not run
>  	 * verify-signed-buffer here for now...
>  	 *

This is not wrong per-se, but "the tag being merged" is something I
would have written, as naive non-native English speakers would find
it disturbing and ungrammatical that "the integrator" singular is
matched with "singular" they, which goes opposite from what they
were taught in their foreign language classes [*1*].

Perhaps offer a passive voice as a weaker alternative to the
singular they in the guidelines patch?


[Footnote]

*1* I started writing this paragraph first with a singular subject
    "a naive non-native speaker", found "his or her foreign language
    class" problematic, and worked it around by make the statement
    about plural speakers.  That may qualify as the third option.
