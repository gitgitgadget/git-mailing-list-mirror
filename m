Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880EBC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6949D60F9E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhGZTkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:40:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58064 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhGZTkM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:40:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12611D0ECB;
        Mon, 26 Jul 2021 16:20:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A0WVNex9OYEYRDK7sbuHXqYXn3YfCESdV1AtNa
        zyv5Y=; b=YzZkNHKRVwSWTkKyqtnwx+7MZQZi5Kr4/g8xnJxbRUfBo9XrLCHTJs
        Lfcnhcmoqryyp9PtsW+FIBEHUjnPQ8z49EGVe0Hc7waqakye9tksR1oStPTyfZ9E
        BfO7hrtwznrh1Prx9W/9o0aIrK1BBYKDQpJb00/VjnNybqM07DBR8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B234D0ECA;
        Mon, 26 Jul 2021 16:20:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87822D0EC9;
        Mon, 26 Jul 2021 16:20:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     andrzej@ahunt.org
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: Re: [PATCH v2 00/12] Fix all leaks in tests t0002-t0099: Part 2
References: <20210620151204.19260-1-andrzej@ahunt.org>
        <20210725130830.5145-1-andrzej@ahunt.org>
Date:   Mon, 26 Jul 2021 13:20:39 -0700
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org> (andrzej@ahunt.org's
        message of "Sun, 25 Jul 2021 15:08:18 +0200")
Message-ID: <xmqq1r7kj088.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1C00672-EE4E-11EB-A9C5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

andrzej@ahunt.org writes:

> From: Andrzej Hunt <ajrhunt@google.com>
>
> V2 fixes patch 11/12 (rebase_options.strategy lifecycle) as per review
> discussion. Many thanks to Phillip and Elijah for spotting the issues there!

Thanks.  Looking good.

Will queue.
