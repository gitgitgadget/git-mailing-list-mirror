Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B421F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfHZQYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:24:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64949 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfHZQYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:24:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CA7D1610C7;
        Mon, 26 Aug 2019 12:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NG/UQGYkWKpNFQDZqcCveYogEIg=; b=vmKkmI
        i8wcawku6sZ7m+/qLMNfCi/NpUFPFn3GY6BgGooskKimhlzmSXw9ORGs8RSf0AZW
        doH3IXEB335ExBxzD7zIQLaetC1VztTuw8neXI5dYszvKOH4dNDtbH4FNtLSB+nb
        Z8gsrwzMrFp7ZgVBnmHGWFl/z1jHsXFzmQNnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PwQ9Hc+QTCNOkLUTAUPBmy65fTzB9G3J
        nwonQE/yii1CWzLWqubPGnDD16IH/JjbZ+UGdJl19rNzw6bdbXlq79dd0fiptDTL
        4F2E9LEVm4V/G2UpJK87G7uriD5/GG1kgREufqTX460Jadr/q75cEwkSZawdGNj2
        2j2zyKTbdtY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43CD51610C6;
        Mon, 26 Aug 2019 12:24:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3E6F1610C3;
        Mon, 26 Aug 2019 12:24:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrey Portnoy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] banned.h: fix vsprintf warning
References: <pull.322.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Aug 2019 09:24:10 -0700
In-Reply-To: <pull.322.git.gitgitgadget@gmail.com> (Andrey Portnoy via
        GitGitGadget's message of "Mon, 26 Aug 2019 08:21:50 -0700 (PDT)")
Message-ID: <xmqqwoezj3o5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFF3DA7A-C81D-11E9-A0AC-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrey Portnoy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Previously sprintf was the argument to the BANNED macro, where vsprintf is
> expected.

Good eyes.  Thanks.


>
> Andrey Portnoy (1):
>   banned.h: fix vsprintf warning
>
>  banned.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> base-commit: 75b2f01a0f642b39b0f29b6218515df9b5eb798e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-322%2Fandportnoy%2Ffix-vsprintf-warning-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-322/andportnoy/fix-vsprintf-warning-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/322
