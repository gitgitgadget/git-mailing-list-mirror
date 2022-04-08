Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CBBC433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 20:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiDHUsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 16:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiDHUsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 16:48:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25CF3B67A3
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 13:46:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4196F1899F4;
        Fri,  8 Apr 2022 16:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hE11rDzifgIUsn3+bKFWRTEYT37cbsGEez73FW
        LqBe8=; b=T2Hg0ow3Ss7sSE4oasYzRw2iNBOo0zxC4bpDgkyocUgM4hhWupZNoA
        WUXMEW0QNMTJE9VA9KoTKTPd9PZ8OKbhbWawnmzeu+hsM0D10XuwXsvzyGIvGC87
        zDaFkNyiHswxgt766Y8VWW9KqJDDO6QkBgoohmkuEJN0T5J65Y/No=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A52F1899F3;
        Fri,  8 Apr 2022 16:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8C4701899F0;
        Fri,  8 Apr 2022 16:46:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        git <git@vger.kernel.org>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC] Contributor candidate introduction
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
        <Yky7xb7nQRR8Vqtj@nand.local>
        <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
        <Yk21JvirO6FyQ3Va@nand.local>
        <e312b18b-f0d6-8980-9cad-74602043a1db@gmail.com>
        <CAP8UFD1x-JEX8MAmpabK4RbKgmVm1VQYNJdX3fP8Op5WMfUgVg@mail.gmail.com>
        <YlCcQw6FuWufLe74@nand.local>
Date:   Fri, 08 Apr 2022 13:46:05 -0700
In-Reply-To: <YlCcQw6FuWufLe74@nand.local> (Taylor Blau's message of "Fri, 8
        Apr 2022 16:34:11 -0400")
Message-ID: <xmqqk0bzl2wi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9ACD2B0-B77C-11EC-88F6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> My thinking is roughly that of the sub-projects listed:
>
>   - investigate replacing EWAH with Roaring+Run
>   - add a "table of contents" to the .bitmap file
>   - append-only bitmap generation
>   - amorphous / larger related projects
>
> ...the first two both require serious (re-)consideration of the .bitmap
> format, and I don't think it's possible to split that up among multiple
> GSoC projects.

Yeah, also I doubt that bitmap stakeholders want to assign such a
centrally important design task to an apprentice, even with a
competent mentor or two.

> The "append-only" project is interesting, but probably not large enough
> for a GSoC student to occupy their time with completely.

I have to preface this with the fact I always am the one that is the
least optimistic about the timeline, but "append-only" somehow
sounds like a project with an interesting enough size and complexity
to me.

Just my two cents.

    (me goes back to preparation of -rc1)

