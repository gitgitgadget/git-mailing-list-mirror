Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470CAC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D49610C7
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhIQGpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:45:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59816 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhIQGpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 02:45:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F906DBCC9;
        Fri, 17 Sep 2021 02:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6fuhZp2xideMjll+PXCbkstt/Hh5MPbe2wIEjv
        AX7BY=; b=RvbzsP+p0xko40hKliqvf+Re63HcDzy0EvACmO/RhsCSqoT6u4Rurz
        OmKDqm5VhyGDI1S20pvgWVle012V3Ey4eWwH/xdR5w9jwRngvcEY0VO45jEPNBLf
        nQ0BZoI3H695t+ztmgKZz7rnQbAuoaKmJ2BWYrkuU/P1ztuZG6Ttg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85EE9DBCC8;
        Fri, 17 Sep 2021 02:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0C91DBCC7;
        Fri, 17 Sep 2021 02:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/5] fsmonitor: enhance existing comments
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
        <6be687ba39d49f56a0729d3197ecbf3a64041357.1631822063.git.gitgitgadget@gmail.com>
        <2b7f0885-bb76-d695-941d-3160a8d62ccc@gmail.com>
Date:   Thu, 16 Sep 2021 23:44:21 -0700
In-Reply-To: <2b7f0885-bb76-d695-941d-3160a8d62ccc@gmail.com> (Bagas Sanjaya's
        message of "Fri, 17 Sep 2021 13:31:54 +0700")
Message-ID: <xmqqr1dnitve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B156C136-1782-11EC-B489-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 17/09/21 02.54, Jeff Hostetler via GitGitGadget wrote:
>> -		/* If we're going to check every file, ensure we save the results */
>> +		/*
>> +		 * If we're going to check every file, ensure we save
>> +		 * the results.
>> +		 */
>
> Why did you split the comment above?

I would guess that the reason why it is done is because the original
line is overly long it (extends to 84 columns, if I am counting
correctly).
