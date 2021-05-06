Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA26C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5722961222
	for <git@archiver.kernel.org>; Thu,  6 May 2021 00:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhEFAlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 20:41:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61808 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEFAlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 20:41:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EFA2D345F;
        Wed,  5 May 2021 20:40:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vQP5mqhgjKyxlZVLDYdtbOlcVpWAPpLmIFysuD
        Y6CFY=; b=YJApPzxK/GVOsxZGexTS7hnP2Up3qyavC1y2fAjj97r+NYOys5+cj2
        RfJ0KNaxpRhRGIcLZQsFHLPzlD8nLUWkjdvgXrhPePoBJpGOUwUOgTu/jE/MDOMJ
        Z3M9CK/ZfGKiTFsJlcZGPDtplTpfYHO2X49LdK6aAVEVcI3B6N0TI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6582AD345E;
        Wed,  5 May 2021 20:40:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBEB8D345C;
        Wed,  5 May 2021 20:40:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        christian.couder@gmail.com, git@jeffhostetler.com, tboegi@web.de
Subject: Re: [PATCH v3 0/8] Parallel Checkout (part 3)
References: <cover.1619818517.git.matheus.bernardino@usp.br>
        <cover.1620145501.git.matheus.bernardino@usp.br>
        <273c4f16-60b6-5635-b95a-17192cf4d5de@gmail.com>
Date:   Thu, 06 May 2021 09:40:19 +0900
In-Reply-To: <273c4f16-60b6-5635-b95a-17192cf4d5de@gmail.com> (Derrick
        Stolee's message of "Wed, 5 May 2021 09:57:08 -0400")
Message-ID: <xmqqa6p83dak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A27D7EC2-AE03-11EB-B65E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 5/4/2021 12:27 PM, Matheus Tavares wrote:
>> This is the last part of the parallel checkout series. It adds tests and
>> parallel checkout support to `git checkout-index` and
>> `git checkout <pathspec>`.
>> 
>> I rebased this version onto `master`, as part-2 was merged down to
>> `master`.
>
> I read the range-diff and gave the patches another pass. This version
> looks good to me.

Thanks.  Your assessment matches mine.
