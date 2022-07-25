Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35152C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiGYUt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiGYUtz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:49:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86422BFC
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:49:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54FC61A498D;
        Mon, 25 Jul 2022 16:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VEvXz/nk9ABs
        sI4bbrLG0v8Snb3cxrRjpIJenNbhGhg=; b=rr9aUMqMIVylTspf1PU7kFBq+sS8
        ASXzUxPv3iyA//nDvL0HPt9IC/QUbS2Iq62uTJ7q3WlrzOXlqldb23EHG+mfh8bB
        YW84xVy5hsT6d7LNIjKY9isfwE6hQgSM7kvH/gKInPNZLYeIm4V/GDSR6RTCkwlA
        vjRjlTxNtxsGM4w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D3AC1A498C;
        Mon, 25 Jul 2022 16:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA3211A4989;
        Mon, 25 Jul 2022 16:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 00/10] typed sort of linked lists
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
        <xmqqk08bv0ax.fsf@gitster.g> <xmqqy1wh3tzy.fsf@gitster.g>
        <3c182e33-ee8e-0a1f-8915-8f97da2499e6@github.com>
Date:   Mon, 25 Jul 2022 13:49:48 -0700
In-Reply-To: <3c182e33-ee8e-0a1f-8915-8f97da2499e6@github.com> (Derrick
        Stolee's message of "Mon, 25 Jul 2022 16:35:59 -0400")
Message-ID: <xmqq8rog534j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 536FD87C-0C5B-11ED-827D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 7/25/2022 2:52 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>> A nicely presented coherent story that results in an overall code
>>> reduction.  Thanks for a pleasant read.
>>>
>>> Will queue.
>>=20
>> No comments or objections from anybody?  I am planning to merge the
>> topic to 'next' and to 'master' soonish.
>
> Sorry. I had started reading it and also found it to be a
> pleasant read, but did not get around to finishing it and
> saying so publicly. Consider that done now.
>
> Thanks, Ren=C3=A9!
> -Stolee

Thanks.
