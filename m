Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D39AC432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 11:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1024F20857
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 11:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JPxQ0eit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfKTLhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:37:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56102 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfKTLhW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 06:37:22 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C910A2D437;
        Wed, 20 Nov 2019 06:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KVXxa7f8F2G3
        E133/ezlfmadU30=; b=JPxQ0eitYDJma/diY7v8aTys4QZWi0CRKSPowL5JfQD7
        lgXkZUc4+0MoXQ/W4vLcmj29QF2nIanbbkweF3Z2ycGbmMCb8VWoHtwbNQUU/j0s
        VaBHXL77aikr3/+spQcD3roeiPidd3zXY9PHdOwmfs30gCshZzA+xbGwyvYoSTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Z09s66
        CSjwiXMlXfNoxZFBer1/+kOsFt0nQfg8EH6vRwA+cmZQCJm8yTToR1QbvsFGO/1E
        5axRoltXnRVHjPYqghODHNKFVMV2RdfvicruiDhvsna6zWyTsfzfervutc+cDgoj
        hdpPOkludBY3sBSTEMhcUf67tm6N/V09ocyak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFF842D436;
        Wed, 20 Nov 2019 06:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1207E2D434;
        Wed, 20 Nov 2019 06:37:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kerry\, Richard" <richard.kerry@atos.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
References: <20191115230637.76877-1-emilyshaffer@google.com>
        <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
        <20191118214519.GH22855@google.com>
        <20191119184919.GM23183@szeder.dev>
        <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
        <AM0PR02MB3715245F0CB1C7678DA8794F9C4F0@AM0PR02MB3715.eurprd02.prod.outlook.com>
Date:   Wed, 20 Nov 2019 20:37:18 +0900
In-Reply-To: <AM0PR02MB3715245F0CB1C7678DA8794F9C4F0@AM0PR02MB3715.eurprd02.prod.outlook.com>
        (Richard Kerry's message of "Wed, 20 Nov 2019 10:45:44 +0000")
Message-ID: <xmqqk17ubwy9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BF8B9BA-0B8A-11EA-B8BB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kerry, Richard" <richard.kerry@atos.net> writes:

>> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
>> Of Johannes Schindelin
>> Sent: Tuesday, November 19, 2019 9:30 PM
>> To: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ... except people with an @outlook.com address (all of their emails wi=
ll
>> bounce) and people who do not know how to suppress HTML in their email=
s
>> (which I believe constitutes the vast majority)...
>
> [RK>] And even those of us who can find the plain/html format
> selection control may find that our employer's system turns
> everything into base64 anyway, thus again making it impossible to
> post to vger.  I fully expect this email to reach all those of you
> who are To or CC, but not to reach vger.

You actually can read it on public-inbox.org/git/ which means vger
correctly forwarded ;-)
