Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3695CC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 18:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203186141B
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 18:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbhI2Sck (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:32:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65362 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbhI2Sck (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 14:32:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DE6FE95C2;
        Wed, 29 Sep 2021 14:30:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t7Vl1hus8BObGCABC2MaDWyEWYrwO88gwDvdtI
        Nvdjc=; b=I213Vj9vQAfx9aGsEoIRec8JjzMKwghzAeiLJtrfAXdvPM/GrzL5Ag
        FnL3tDiHEw1KE0HlR0XjjjbYgegSPHxn3vPnmkEwBKfb7x1a9CtrbdaFTg7NSkA8
        6xasr5UJVQrx8uUWPMpDHzPsPMyFDIDOqdN1u6WlwTKlo8NVFfl0c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 561F0E95C1;
        Wed, 29 Sep 2021 14:30:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8519E95BF;
        Wed, 29 Sep 2021 14:30:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>,
        git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] blame: document --color-* options
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
        <20210925121817.1089897-1-bagasdotme@gmail.com>
        <xmqq5yulregh.fsf@gitster.g>
        <fe78329d-07a7-bdf3-2bda-13def35f3de3@gmail.com>
        <xmqq4ka4n00h.fsf@gitster.g>
        <7745e157-7df9-2da7-f391-8c5bae16f005@gmail.com>
Date:   Wed, 29 Sep 2021 11:30:56 -0700
In-Reply-To: <7745e157-7df9-2da7-f391-8c5bae16f005@gmail.com> (Bagas Sanjaya's
        message of "Wed, 29 Sep 2021 16:15:55 +0700")
Message-ID: <xmqqk0izdyjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 638B9172-2153-11EC-97A7-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Stefan mentioned "metadata" term to describe the line annotation, from
> commit cdc2d5f11f1a:
>
>>     When using git-blame lots of lines contain redundant information, for
>>     example in hunks that consist of multiple lines, the metadata (commit
>>     name, author, date) are repeated. A reader may not be interested in those,
>>     so offer an option to color the information that is repeated from the
>>     previous line differently. Traditionally, we use CYAN for lines that
>>     are less interesting than others (e.g. hunk header), so go with that.

The documentation is for our end users, who may not have read our
commit log messages, so phrasing that was used in an old commit
message would not help them.

