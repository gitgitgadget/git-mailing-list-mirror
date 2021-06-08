Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DBFC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCF361178
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhFHXUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:20:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57458 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhFHXUK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 19:20:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAAD5142CA3;
        Tue,  8 Jun 2021 19:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OI51RApzsiqA
        qr1UtBRD+VJKq+AfeDwBzz1hxUvLoag=; b=hgQzjCJVJXr+CThaeaLd4UD0tG6c
        kHNO2qVlbWcBTy4SYmeZ3aCMNT4LRX9AHEfeFw0iGU4x29V4Emj5eGGp4xDdgAec
        HYe/XZfzBXoK+2dhzbIO1kiZNOKWisX+MQgOk+u2B/s3VJHEt2poMBdXVWz+0whP
        XJf0cth3pVIuuhI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3320142CA2;
        Tue,  8 Jun 2021 19:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4F5E142C94;
        Tue,  8 Jun 2021 19:18:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #03; Tue, 8)
References: <xmqqeeddq7h5.fsf@gitster.g> <87r1hc35f8.fsf@evledraar.gmail.com>
Date:   Wed, 09 Jun 2021 08:18:12 +0900
In-Reply-To: <87r1hc35f8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 08 Jun 2021 14:25:54 +0200")
Message-ID: <xmqqh7i8ndxn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC6E2A76-C8AF-11EB-B923-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 08 2021, Junio C Hamano wrote:
>
>> [New Topics]
>
> Missing here is Jiang Xin's 2-patch series to fix a portability issue
> with the "git bundle" tests:
> https://lore.kernel.org/git/20210601144901.31375-1-worldhello.net@gmail=
.com/

Yeah, I'd expect that many things that are not regression fixes and
that were sent during the prerelease freeze to be missing.  Would
you mind arranging it to be resent with copyediting (I remember that
I saw the patches and found them needing some grammofixes)?

Thanks.
