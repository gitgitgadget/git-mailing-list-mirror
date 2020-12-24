Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD001C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5534022AAC
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgLXG3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 01:29:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59425 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgLXG3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 01:29:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8872510E980;
        Thu, 24 Dec 2020 01:28:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dutd7YHeFaiorWcfiKnrj7zDQWY=; b=L+JMhi
        q+IOSlQegDoBnIdqL7kzIe9+fH0n9UjG7celY0Nn9eU9LxquVT5bnV2XTXyXLLLw
        K43scxd6cD4CxQ/j1gMASElqg6F/tdBF1EeUwyQv0UUw/PgquF2F2HLLJrDN1rdn
        jMuv45+1Diw/b64/mnyZ/C9k4XqkiyZD+2sto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DcA5HgVcEcDQLqV6e93G/aMmiyKP9iyI
        9rTc0UCDjtC5Z17Y54BWPep9Hz1103xH5v6A1YkxNKhdgJD/JYZUmppvQ7Oml3WE
        giqV2yiLbgboZnM9PvskH90CS0/nrwK4hb526HsFPoxs1Ywoh1/2xCmafkt3GEBT
        HfoGedmOe2s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73E7D10E97F;
        Thu, 24 Dec 2020 01:28:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B210C10E97E;
        Thu, 24 Dec 2020 01:28:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.30.0-rc2
References: <xmqqtusc5djv.fsf@gitster.c.googlers.com>
        <CAP8UFD3aHEpHZWxzwz=RQr7DNAmJhLeoiOzubRqk1=7gRyG4_g@mail.gmail.com>
Date:   Wed, 23 Dec 2020 22:28:17 -0800
In-Reply-To: <CAP8UFD3aHEpHZWxzwz=RQr7DNAmJhLeoiOzubRqk1=7gRyG4_g@mail.gmail.com>
        (Christian Couder's message of "Thu, 24 Dec 2020 07:13:57 +0100")
Message-ID: <xmqqblej4t1a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 364C81FE-45B1-11EB-BBDA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Most of the suggestions below are found by GMail.
>
> On Thu, Dec 24, 2020 at 12:08 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> A release candidate Git v2.30.0-rc2 is now available for testing
>> at the usual places.  It is comprised of 19 non-merge commits since
>
> Maybe: s/is comprised of/comprises/

Funny.  

I do recall somebody else (perhaps Peff but I may be misremembering)
helped me grammofixing the use of verb "comprise" in the sentence
when I started listing the names of commit authors back in v2.3.3 or
v2.4.0 era.  Perhaps I failed to follow the advice given?  I dunno.

Thanks for all the other typofixes.
