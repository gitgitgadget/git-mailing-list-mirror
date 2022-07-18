Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094DAC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiGRQyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiGRQyb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:54:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EAABF56
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:54:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95C4C1B2FE4;
        Mon, 18 Jul 2022 12:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dbBqrrdp2Zar
        omdEBbxr8FjNBTUOBMgN3C1aW05DhSM=; b=p6uftaIY3O+80JaHvfsigniyCcqa
        t9C257YVkgxPdlCCjIUmxHgic3cr6Cy14HZYD/eKgysWke+r971pYm4cuS3wPLwE
        pxAcLhoxX6ahwuBiKyNjZRiYnpNWXFTPcAJNSCtPjK2hhaui0Bj5DbopCIIN5lup
        CU9s47tyNavA3IM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DC121B2FE3;
        Mon, 18 Jul 2022 12:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E6F01B2FE2;
        Mon, 18 Jul 2022 12:54:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 0/8] git doc + "git help": move "format" docs from
 technical/*
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
        <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
Date:   Mon, 18 Jul 2022 09:54:24 -0700
In-Reply-To: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 18 Jul
 2022 15:29:26
        +0200")
Message-ID: <xmqqy1wqqs3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4790F078-06BA-11ED-8A47-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series improves the discoverability of the technical/*
> documentation covering those "formats" where we interact with users
> (e.g. "gitattributes") by moving them to its own "git help" category.
>
> It then moves various technical documentation from technical/* to our
> main documentation namespace, allowing us to cross-link e.g. from
> "git-bundle(1)" to a new "gitformat-bundle(5)".

This may be a good direction to go in in the longer term, but there
are already topics in flight that change these documents.  Luckily
none in 'next' yet, but there are two that have been in 'seen' and
need to coordinate with this change.


