Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E8EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGYVuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGYVuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:50:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F210D1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:50:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DE5D189AC9;
        Tue, 25 Jul 2023 17:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jyg2tnA/jq/E/RluamW7jiOBnYXQYYKdgQG3+T
        zUOAE=; b=msUQy8R2JToFKyxZL4IxqjQyh58Bb0VzBFKDxkohNe79o/L01znBLL
        mJLPYMg6+LyaZQ27aK2H45C+2ywrUfrilOZyuUUXQmVxnoJFP9SA01q+6Q4vgPY8
        45aau6jEBd8prVrgUQcN2pYdW2V0XNXbZKAUSVNsdlzUTHozvlk+4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 748BA189AC6;
        Tue, 25 Jul 2023 17:50:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 827E2189AC3;
        Tue, 25 Jul 2023 17:50:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
References: <ZMA78xwfCE1-paE-@five231003>
Date:   Tue, 25 Jul 2023 14:50:40 -0700
In-Reply-To: <ZMA78xwfCE1-paE-@five231003> (Kousik Sanagavarapu's message of
        "Wed, 26 Jul 2023 02:47:39 +0530")
Message-ID: <xmqqzg3jhd8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CB8C4CC-2B35-11EE-9A3C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> [New Topics]
>
>> * ks/ref-filter-describe (2023-07-24) 2 commits
>>  - ref-filter: add new "describe" atom
>>  - ref-filter: add multiple-option parsing functions
>> 
>>  "git branch --list --format=<format>" and friends are taught
>>  a new "%(describe)" placeholder.
>> 
>>  Will merge to 'next'.
>>  source: <20230723162717.68123-1-five231003@gmail.com>
>
> Hi,
>
> Could you merge the version (v5) that I sent out just now to 'next'
> instead of these? They address a minor change.

Nah, that is not worth it, as I've already done ! -> test_must_fail
fix locally yesterday.

Thanks.
