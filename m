Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C661F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 16:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfHMQkm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 12:40:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62118 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHMQkl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 12:40:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB9F471698;
        Tue, 13 Aug 2019 12:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MVBLJBruFA/N
        XbbC6Lj3COfwDDo=; b=qjENfI/snKrjUogmrfm1swgwG7BduTSxy5KQ29yAw6yc
        uKw1BABwblcOXLodXhQMWCBOtLxLWI7MNCRi+5aqJ/YfNRgE36eebW7gzG+uPiRW
        kr9yt5hcwHVmu5DpNUulhQ3xYMV1KvU1jo4cmOQSIUhchqO/DqghBKi3ZtMm0CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MJo8QI
        UdtPk9A438qTCxLHxScYMSfjq55lkjSN/M6nA8BW+f6s58wrgd3SRcH0bK3k82F3
        TE5qlPCYTVh7HQkCCSrYjbl0KlWSnL/dk0F3LbZhs3J1MPEdQiLA/HSDbFvVW4qj
        j81Vjm3ESgVUj+IYid5Ld6vvP5/wQI1cv4oJ0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3A4C71697;
        Tue, 13 Aug 2019 12:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5CA771696;
        Tue, 13 Aug 2019 12:40:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "Yagnatinsky\, Mark" <mark.yagnatinsky@bofa.com>,
        "'git\@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
References: <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
        <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
        <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
        <20190811121004.guygurnopwwggvsp@tb-raspi4>
        <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
        <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
        <aae529ce1b084b7bbcca3977e6909417@bofa.com>
        <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
        <20190813032452.qg2ufgljm4bjeznr@tb-raspi4>
        <a5b84e2b8184414bb416f3aa83361a1c@bofa.com>
        <20190813154033.uhi7w5jgwcj4xan7@tb-raspi4>
Date:   Tue, 13 Aug 2019 09:40:34 -0700
In-Reply-To: <20190813154033.uhi7w5jgwcj4xan7@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 13 Aug 2019 17:40:33
 +0200")
Message-ID: <xmqq8srx9fy5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13D929AC-BDE9-11E9-BB81-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Sigh.  Okay, great, life makes sense again.  I want to yell at my
>> IDE now.
>>
>> I now feel brave enough to attempt to come up with better wording
>> for autocrlf docs, if you think that's worth trying.
>
> That would be good, I am happy to review patches.

Good.  Thanks for a good discussion.
