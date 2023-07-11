Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D43EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 15:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjGKP5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjGKP5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 11:57:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1FBE
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 08:57:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C06429F9B;
        Tue, 11 Jul 2023 11:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ndso+ArwYxg8
        Vdjbz3LSG26GRy+nOJCYj1az48vcd1Q=; b=gMcY5uTO/dXq4XINPuEBa8iU6MuB
        3EYHZYQjsEjgHJMD0rlpvwEIuV9N96XHwMSEC/SiThkyqZjycDKN4pXyTzAc5xj/
        v4qlXe/6RjuUrLF6LDaIk6WbNoOOpIaTvt22kHr88tOiH4oLJTsPzE01YrvHn/Y3
        yOCjGMgySrnPQx4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4442729F98;
        Tue, 11 Jul 2023 11:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC8A529F96;
        Tue, 11 Jul 2023 11:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 00/16] refs: implement jump lists for packed backend
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1689023520.git.me@ttaylorr.com> <xmqq5y6r4con.fsf@gitster.g>
        <eddehgbfqnmkhvhkacbvnqiiripbn6jvjawpy76ysfnpohsygt@a43fbutqg64z>
Date:   Tue, 11 Jul 2023 08:56:57 -0700
In-Reply-To: <eddehgbfqnmkhvhkacbvnqiiripbn6jvjawpy76ysfnpohsygt@a43fbutqg64z>
        (Patrick Steinhardt's message of "Tue, 11 Jul 2023 11:37:56 +0200")
Message-ID: <xmqqilaq30hi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9139C796-2003-11EE-A133-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jul 10, 2023 at 03:35:52PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>=20
>> > Here is another reroll of my series to implement jump (n=C3=A9e skip=
) lists
>> > for the packed refs backend, based on top of the current 'master'.
>>=20
>> I've skimmed the whole set again and nothing jumped at me as an
>> unexpected change.  Let's wait for a few days to see if we have
>> others comment on the patches and then merge it down to 'next'
>> unless there is something spotted in there.
>>=20
>> Thanks.
>
> The patch series looks good to me, too, so please feel free to add my
> Reviewed-by. Thanks for these exciting changes!

Thanks.
