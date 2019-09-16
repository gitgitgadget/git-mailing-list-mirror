Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F4F1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 17:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfIPRoE (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 13:44:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59736 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfIPRoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 13:44:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DE1F92031;
        Mon, 16 Sep 2019 13:44:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K5+KGubQ0swn
        UEAwI/R8MO4dzM8=; b=OjrkHaEyspwKYNAfHVwy3hZ5upQnqdEW+dHILdrLovyg
        bJqGEO26dLLBVbFGbzmEXRoCpSNkCkszThiOLUQJAubPuK2LXmVJKMjZ6zKlRteS
        V4jt6SMch5VAzgQM005SfIneOWTJaOCnv9lnoVe4yS5TgbNvbWD98SnlVa7/1Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nEHnA3
        3lGYr20VEk1+9Uzmgg7BCtFjKh0VkWRgkGQt6+dMno45bLJbi4oIi72PksTHKq1d
        hLIhi3EqG1YCC5e4EcH/CK8Cz1cDQlAtGvuX3BpcGfxV5ym5KhdbwL9oqIebsXyo
        jwUTBMTqFvAyr/joQ6yY04zp4uiW9pjS5md/M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16CDF92030;
        Mon, 16 Sep 2019 13:44:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2CC69202D;
        Mon, 16 Sep 2019 13:43:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: fix build with Asciidoctor 2
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
        <20190913015240.686522-1-sandals@crustytoothpaste.net>
        <20190913050634.GB21172@sigill.intra.peff.net>
        <CAN0heSqcKR_HV3jt2vVU2iafA77cqTyjFaTmiyXaHChmmUBhgg@mail.gmail.com>
Date:   Mon, 16 Sep 2019 10:43:56 -0700
In-Reply-To: <CAN0heSqcKR_HV3jt2vVU2iafA77cqTyjFaTmiyXaHChmmUBhgg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 16 Sep 2019 12:47:46
 +0200")
Message-ID: <xmqqd0g0b0gz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8FE6A936-D8A9-11E9-B6B4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>>   -Git omitted                       01/01/1970                       =
 GIT-ADD(1)
>>   +  omitted                         1970-01-01                       =
 GIT-ADD(1)
>
> Yeah, I should be able to post v3 of my refmiscinfo-series this evening=
,
> which should fix this, so that the only difference that remains here is
> how the date is formatted.

Thanks.
