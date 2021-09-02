Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2CC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F9560FDA
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbhIBUOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:14:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60829 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346109AbhIBUOb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 16:14:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5450EEEE97;
        Thu,  2 Sep 2021 16:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a6X6lwgq1/vHZ01X0aUkLP70rCaj+Bjcmn/DCn
        bQCqI=; b=lajyq2T+qVFyNamY7oJL8dbQlbr3EispqzPBj81A4M+NpPjysUKxkn
        vxSqPj8VlhjR24rlJU716UslPENBkV0bv3gBjuebs1wgkG+tgzDpeW95Tp1uXkA7
        zaEBgXmndneRmcyZHWgNj3XHVDF2RECZbUmxb9gWARxV4sbqS0KPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D56FEEE96;
        Thu,  2 Sep 2021 16:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAE09EEE95;
        Thu,  2 Sep 2021 16:13:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] remote: avoid -Wunused-but-set-variable in gcc with
 -DNDEBUG
References: <20210902073631.50062-1-carenas@gmail.com>
        <YTCO56kbtQbODDeK@coredump.intra.peff.net>
        <YTCQ5aJXPMTUpKs8@coredump.intra.peff.net>
        <CAPUEspjMbpbSvT=kVsnFgzTJKtPjU1EBo8cjgvrEqtfbeY4g3Q@mail.gmail.com>
Date:   Thu, 02 Sep 2021 13:13:31 -0700
In-Reply-To: <CAPUEspjMbpbSvT=kVsnFgzTJKtPjU1EBo8cjgvrEqtfbeY4g3Q@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 2 Sep 2021 02:10:36 -0700")
Message-ID: <xmqqa6kuka6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E812B6E-0C2A-11EC-B786-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Thank you; definitely a big improvement in both accuracy and prose.
>
> Carlo

Thanks, both.

