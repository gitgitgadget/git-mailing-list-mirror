Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC417C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED1B214AF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jEVi9Tr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMV6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:58:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50430 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMV6V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:58:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB928A8856;
        Fri, 13 Dec 2019 16:58:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oxecnC8NILaz
        nX9ip4zsLJrnfaM=; b=jEVi9Tr0xEVok7e6VgsXPLjk0qw5pm8sGUVlUEPpcaZ1
        y6W9n7kIjqe2vtPct1gyDhdI5vaXdnVTZmf3OqUmNs3TPFAhLyxl2GAPs5cmdG/g
        TlvZKC+O46MZikLcR+/xDW3+3eV7NPFkWYy+MuAY8Mb2hkobLjSV3FcSiI0zY0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Uc15tt
        A7OImfk+ovgwkIUEaL8j14a5Z3aeKbdoWFG6dt2uzd2A2ox0QQuWuDQvv8o7sYZV
        9Lk4avr6XvnzVGWK2yWHf6fDeZ9xQlXlguhzkBbCoT6Ve+/9ANwaYnXv8niFwhoU
        56LOzFzgviN3NqAyrJJEUQJqY0t/DCkMcyBK4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D330DA8855;
        Fri, 13 Dec 2019 16:58:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E73AA8854;
        Fri, 13 Dec 2019 16:58:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] doc: remove non pure ASCII characters
References: <20191212204655.10425-1-jn.avila@free.fr>
        <20191212204655.10425-2-jn.avila@free.fr>
        <xmqqk170j938.fsf@gitster-ct.c.googlers.com>
        <2958852.hm7A7XRobS@cayenne>
Date:   Fri, 13 Dec 2019 13:58:14 -0800
In-Reply-To: <2958852.hm7A7XRobS@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Fri, 13 Dec 2019 22:37:50 +0100")
Message-ID: <xmqqmubvhoqx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AAB77184-1DF3-11EA-A8FD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> Thanks.  I've always wanted to do this, but it is a bit surprising
>> that there is only this single instance?
>
> There's another one in git-format-patch.txt, "Uwe Kleine-K=C3=B6nig die=
t", but this one does not seem to cause issues and it is difficult to rep=
lace it with ASCII only.
>
> Should I try to find an alternative text?

No, let's keep names of people as-is, if they are not causing
issues.

What surprised me was the apparent lack of these "smarter"
apostrophes and quotes.

Thanks.

>
>>=20
>> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.t=
xt
>> > index 34011c2940..2e8babe671 100644
>> > --- a/Documentation/git-clone.txt
>> > +++ b/Documentation/git-clone.txt
>> > @@ -262,9 +262,9 @@ or `--mirror` is given)
>> >  	All submodules which are cloned will be shallow with a depth of 1.
>> > =20
>> >  --[no-]remote-submodules::
>> > -	All submodules which are cloned will use the status of the submodu=
le=E2=80=99s
>> > +	All submodules which are cloned will use the status of the submodu=
le's
>> >  	remote-tracking branch to update the submodule, rather than the
>> > -	superproject=E2=80=99s recorded SHA-1. Equivalent to passing `--re=
mote` to
>> > +	superproject's recorded SHA-1. Equivalent to passing `--remote` to
>> >  	`git submodule update`.
>> > =20
>> >  --separate-git-dir=3D<git dir>::
>>=20
