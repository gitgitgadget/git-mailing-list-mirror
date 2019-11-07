Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3220A1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfKGFly (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:41:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51455 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfKGFly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:41:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3547536FCD;
        Thu,  7 Nov 2019 00:41:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U8rVBVYsbdtfsWO6Lub0hVYeYt4=; b=w6wgg3
        Vz+GFCyY0g5QUyPPTkNBi6sEYI7/N0cdvqHc4D7V0c9sOnBAX7oeBNbLIywnB7Q6
        WF59O3g77E2oj8LPpetnCkrUlrdwdi1cki8U2tuTOHxJjeQRONxXH0EM8vX52+9N
        hFqardPlJsfRxTH8rgAAEnydyyDe1zm2kvqNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D2HLBhgdFgyeDRyZj/i2m6QfikriZXha
        fIgkLrCRBM5eYiHnV2HcC0cXmJZayWlxO4qBYCdyPpoYg/2PXO6le88ZeSikef5j
        GFoeguXf1X9W96xtZT66s0Wu3JGC0Mp5mMsHj7pw4fXh162Nfza4C8eISr0x8PI6
        nPTYp6BKj68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C62736FCC;
        Thu,  7 Nov 2019 00:41:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F32D36FCB;
        Thu,  7 Nov 2019 00:41:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] name-hash.c: remove duplicate word in comment
References: <pull.454.git.1572996692.gitgitgadget@gmail.com>
        <f7503d644c2baa9f5b8a71c998741f8232385508.1572996692.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 14:41:50 +0900
In-Reply-To: <f7503d644c2baa9f5b8a71c998741f8232385508.1572996692.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 05 Nov 2019
        23:31:32 +0000")
Message-ID: <xmqqwoccqm3l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C6DA0A6-0121-11EA-94C5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  name-hash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/name-hash.c b/name-hash.c
> index ceb1d7bd6f..4885bae5da 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -218,7 +218,7 @@ static int lookup_lazy_params(struct index_state *istate)
>   * However, the hashmap is going to put items into bucket
>   * chains based on their hash values.  Use that to create n
>   * mutexes and lock on mutex[bucket(hash) % n].  This will
> - * decrease the collision rate by (hopefully) by a factor of n.
> + * decrease the collision rate by (hopefully) a factor of n.
>   */
>  static void init_dir_mutex(void)
>  {

Thanks.  Will queue all 3.
