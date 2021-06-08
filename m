Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9FDC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C375461351
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 13:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhFHN7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:59:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65136 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhFHN7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 09:59:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48016B2167;
        Tue,  8 Jun 2021 09:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fRiqidpFiREC
        2nKdj6xrJsdagvlfw7Ke2b08OOLHTU8=; b=jkwhRyNKvCl3CXSghNYuBQ5GLbbV
        GJzHh8U89ngd6r/MybUtZvq4L64xasWgEgUI0Y+2JkpBYirpGqL1SN9Tnc12Ort6
        YPt/W6WZWW+jUfP2KxpPrHuyk/wHZlydFiAo9ADarswi25VOHMOUGsDNvEUJKLFr
        eWhlLmyPUM/CnbI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F163B2165;
        Tue,  8 Jun 2021 09:57:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3F37B2164;
        Tue,  8 Jun 2021 09:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6] help: colorize man pages
References: <20210523054454.1188757-1-felipe.contreras@gmail.com>
        <87o8cg34t8.fsf@evledraar.gmail.com>
Date:   Tue, 08 Jun 2021 22:57:42 +0900
In-Reply-To: <87o8cg34t8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 08 Jun 2021 14:35:24 +0200")
Message-ID: <xmqq4ke8pig9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F44F656-C861-11EB-B82F-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I've been running with this on my personal git build since May 26th. I
> haven't had any issues with it, and I like the new coloring.
> ...
> I think this is a good example of a change that we're better off just
> merging down and then reverting if the wider audience of git users hate=
s
> it, rather than trying to come to some perfect consensus here
> on-list.

My impression was tht we already had a rough consensus here on-list
that it may be good to educate users who like this "new coloring"
like you do to configure their "less", so that they consistently get
the "new coloring" they like whether they are doing "git help git",
"man git", or even "man ls", and the approach the posted patch takes
will not help (it only affects "git help git" among these).

I'd rather not to take it.

Thanks.
