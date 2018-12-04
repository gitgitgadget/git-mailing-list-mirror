Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F427211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 02:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLDCX3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 21:23:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56978 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDCX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 21:23:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23FF610DC0A;
        Mon,  3 Dec 2018 21:23:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZD2DWyvHw5jW
        fskjyDa8KiREl2g=; b=JF2q9hqWTiR25qp82qJ5h/FqhTx/XWlQnuz20/gR6AzU
        rMAwH0fTxe5WmUmri0D08DNqRhdCsV2YBQFFqFSijFwuIzmC18Y0WA1dBKnaACW+
        962fPlVOhueg4LWDnLlqitTsIVQ34K9bcEyr+zUwJZRt0abe3CJvywymRsFo1y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kAD97+
        llSd/s0o96hUwXl0JJgP08tLlj9ws8dbpYt0CdfVrdsgyasavsgYEp+DHfvgt0Li
        MEcawLP3S/BLFlV19qTf//b9N6t513o4VJsqd0b3WHTx3fBNI5+PV29+jAvIz4K4
        NC7RN+e3N7Tw9FipDJy31E2fXAu3LnGtU8HaM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CE6E10DC09;
        Mon,  3 Dec 2018 21:23:27 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C00E10DC08;
        Mon,  3 Dec 2018 21:23:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] RelNotes 2.20: clarify sentence
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com>
        <cover.1543868120.git.martin.agren@gmail.com>
        <eccb7edd082b55ba1ddd8f0eebb7c2bb9a1f6ada.1543868120.git.martin.agren@gmail.com>
Date:   Tue, 04 Dec 2018 11:23:25 +0900
In-Reply-To: <eccb7edd082b55ba1ddd8f0eebb7c2bb9a1f6ada.1543868120.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 3 Dec 2018 21:21:50
 +0100")
Message-ID: <xmqqy396f2si.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94DC826E-F76B-11E8-928E-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> I had to read this sentence a few times to understand it. Let's try to
> clarify it.

Great.  Thanks.

>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/RelNotes/2.20.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes=
/2.20.0.txt
> index e5ab8cc609..201135d80c 100644
> --- a/Documentation/RelNotes/2.20.0.txt
> +++ b/Documentation/RelNotes/2.20.0.txt
> @@ -305,7 +305,7 @@ Performance, Internal Implementation, Development S=
upport etc.
> =20
>   * The overly large Documentation/config.txt file have been split into
>     million little pieces.  This potentially allows each individual pie=
ce
> -   included into the manual page of the command it affects more easily=
.
> +   to be included into the manual page of the command it affects more =
easily.
> =20
>   * Replace three string-list instances used as look-up tables in "git
>     fetch" with hashmaps.
