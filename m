Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF8CD6131
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378512AbjJIUCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378490AbjJIUCx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:02:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45594F4
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:02:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C82EC1A12B0;
        Mon,  9 Oct 2023 16:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q2hctMKfAqnf
        058WXR/2krfFywdtPjxGr7z8BNegdZA=; b=kC6b24xckGusVfJBZxtWQxhX4lN/
        EHW5ew2cgy0CwuD5dSbloojOTjfhoPec1v0/6N4tXdnpyhvXYHVlKHdSuTrZkxWe
        d9mfmECOyybBXrS7CehT7tJs0kQs5zeDXCLnH4h+UPdtpsihP6H9BInwGrVW8s72
        ghHR1MhaGSrQWWs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE54B1A12AD;
        Mon,  9 Oct 2023 16:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 186A41A12AB;
        Mon,  9 Oct 2023 16:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: make synopsis and description less confusing
In-Reply-To: <20231009183352.GA3270793@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 9 Oct 2023 14:33:52 -0400")
References: <20231009155603.GA3251575@coredump.intra.peff.net>
        <20231009175604.2361700-1-stepnem@smrk.net>
        <20231009183352.GA3270793@coredump.intra.peff.net>
Date:   Mon, 09 Oct 2023 13:02:44 -0700
Message-ID: <xmqqil7fy36j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D07593B4-66DE-11EE-9218-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 09, 2023 at 07:56:04PM +0200, =C5=A0t=C4=9Bp=C3=A1n N=C4=9B=
mec wrote:
>
>> > Yup, that is a good suggestion. Do you want to wrap all of this
>> > discussion up as a patch?
>>=20
>> Certainly, here it is.  I just wanted to hash out some of the details
>> first and found the plain text more fit for that purpose.
>
> This looks good to me. Thanks for taking the time to collect and fix al=
l
> of the issues.
>
> -Peff

Thanks, both.  Will take a look.
