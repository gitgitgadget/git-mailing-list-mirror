Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB661C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACE320872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xbc4FyJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH1VAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:00:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54012 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1VAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 17:00:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88CD1FE991;
        Fri, 28 Aug 2020 17:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yD0hvNpZi+sy
        gcR8hZUE/Up+v2Q=; b=Xbc4FyJ28KjWDHauazVqph9vXCbdYx/H3PdHOQg/64NL
        PfZ32mr2h4OyXPJuOga4vuP+ionfCZ78qrkCRCzIKJgQJnqN768aK2Mb1tj3nSGk
        QxbLpeYGlfqGNSO9/x/Lst4xq972Rae4BR71F6vIXHxJxCAofQRGsgweqZR6BDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Us74+S
        bKCP1d+E2/KyYASvC1ZXB8qwq4PBobYaoE/6GDee3Tgp8baXw7REja5eBMLT77RG
        2ULP0HVRnJdCKYuqhipoWDFd044RckURmIkIISLna8ZV5xtXBVVuzkeJbMv8aG8v
        B6OkNhUM+AYrffXcZIQrCIAdoiQKA/63qbENo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8111AFE990;
        Fri, 28 Aug 2020 17:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FFF2FE98F;
        Fri, 28 Aug 2020 17:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] po: add missing letter for French message
References: <20200827223527.36788-1-sandals@crustytoothpaste.net>
        <xmqq8sdzpu71.fsf@gitster.c.googlers.com> <2398329.Am1n9C2Xzm@cayenne>
Date:   Fri, 28 Aug 2020 14:00:40 -0700
In-Reply-To: <2398329.Am1n9C2Xzm@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Fri, 28 Aug 2020 17:53:32 +0200")
Message-ID: <xmqqft86o58n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88ED1EBA-E971-11EA-8C9F-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> On Friday, 28 August 2020 01:04:02 CEST Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>=20
>> > Add the missing "e" in "de".  While it is possible in French to omit=
 it,
>> > that only occurs with an apostrophe and only when the next word star=
ts
>> > with a vowel or mute h, which is not the case here.
>> >
>> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> > ---
>> > I noticed this the other day when trying to delete a remote branch t=
hat
>> > I'd already deleted.  I'm not sure what the preferred approach is fo=
r
>> > this, whether Junio should pick it up or whether Jean-No=C3=ABl will=
 want to
>> > incorporate it first, but I've CC'd both so y'all can fight it out.
>>=20
>> Unless it is in the pre-release period (in which case I'd prefer not
>> to touch po/ myself at all, to give i18n/l10n teams a stable base to
>> work from), I can take it dircetly as long as somebody from the l10n
>> team for the language gives an Ack, as I cannot read most of the
>> files under po/ directory.
>>=20
>> Thanks.
>>=20
>
> Acked-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>

Thanks, will queue.
