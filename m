Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A07ACA101D
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 22:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbjIEWUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWUA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 18:20:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939DBFA
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 15:19:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02B5F1B9FCC;
        Tue,  5 Sep 2023 18:19:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TCCpI5L24rQbG6+HPkRxUWOpjMPGhXEwFdQlam
        LizYM=; b=albpwQhp6pz8Af2ERSv5fUXkGoKda2BDJLP2cqLu0r+duqKjpSEJX/
        NoxR2GMBZZK0+q0xRNc2KlsjqgTvDc8njbh7SXWStkpfJuKWY2qy39X5IXwQBVkW
        ZIeYmRIRXfUH7xUeTUyWvdd8CUCCoUmoy0UhcpMRxiOStq+fig9pI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDA031B9FCB;
        Tue,  5 Sep 2023 18:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A2921B9FCA;
        Tue,  5 Sep 2023 18:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] range-diff: treat notes like `log`
In-Reply-To: <843bc10e-03ab-b37a-68f7-d6055dc9308c@gmx.de> (Johannes
        Schindelin's message of "Tue, 5 Sep 2023 12:56:51 +0200 (CEST)")
References: <cover.1686505920.git.code@khaugsbakk.name>
        <cover.1693584310.git.code@khaugsbakk.name>
        <e9a59108311369d8197b9870a8810d5283ec124f.1693584310.git.code@khaugsbakk.name>
        <94b9535b-8c2a-eb8f-90fb-cd0f998ec57e@gmx.de>
        <8642763e-d3e7-49c4-b2ea-d5e4bebfbca5@app.fastmail.com>
        <843bc10e-03ab-b37a-68f7-d6055dc9308c@gmx.de>
Date:   Tue, 05 Sep 2023 15:19:55 -0700
Message-ID: <xmqqledkqn3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5808BB54-4C3A-11EE-B291-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Kristoffer,
>
> On Mon, 4 Sep 2023, Kristoffer Haugsbakk wrote:
>
>> I would like to use your solution instead. Thank you.
>
> Please do! You're welcome.
>
>> Maybe you could supply a commit message for v3? v3 would then consist of
>> two commits:
>>
>> 1. Your fix
>> 2. Those two tests
>>
>> Or should it be handled in some other way?
>
> Personally, I'd prefer it if you just squashed the changes into your
> patch. If you want, I'd be delighted about a Helped-by (or even
> Co-authored-by) footer, but taking ownership would be fine with me, too.

Sounds very sensible.

Thanks, both.  Will look forward to seeing an updated series.
