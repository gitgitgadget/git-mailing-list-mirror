Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464DAC2D0A3
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA07121D7E
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 20:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hivp0pn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgKPUHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 15:07:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59566 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgKPUHl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 15:07:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF52FF4D18;
        Mon, 16 Nov 2020 15:07:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dXof+J4aWE0L
        tcXpkLcYRusB12Y=; b=hivp0pn+x8MnwMOChUOk/qpoDINUD849JrNqYIv9XBet
        Py9x2+05oRyoRdCcNeD1q1sFWym8x5Thfy/gQnsSqpSMU6HHLcFQH71M7KINAnSq
        89pYBFgrIFKehyamZ3yo47Ac/GnvplUb62lIxKJNlhkouFgB+BpvfVZHZGfO3so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iN8MTW
        jmyLSVmJ74JH7qBAQzKBa9DTtmzKrOquvPIINP5wmETSW3fnFN6bmjjUTEZcemO7
        IeztMbLm/meatJaUGeCv4PjF+bPzn0vC1oz5Bn2/U4vsX9wmIlXuJA+MDy099gmX
        UVBMZu/pZiS0v3OFbweqo31Dt54VhnUiLqLLg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4FC9F4D17;
        Mon, 16 Nov 2020 15:07:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF001F4D16;
        Mon, 16 Nov 2020 15:07:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 14/28] t55[23]*: adjust the references to the default
 branch name "main"
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <3aef39320e96aad10e133f1c97a9010aa85aa894.1605221039.git.gitgitgadget@gmail.com>
        <87sg9dfucb.fsf@evledraar.gmail.com>
Date:   Mon, 16 Nov 2020 12:07:35 -0800
In-Reply-To: <87sg9dfucb.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 13 Nov 2020 11:02:12 +0100")
Message-ID: <xmqqima583qw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F29B7B8-2847-11EB-9380-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Is there some meaning to the name "nain" and "naster" that I'm missing?

Not for "naster", which came from me who just chose "any single
letter" followed by "aster" to match 'master', and there is no other
reason.  I think Dscho just followed suit.

> If not can we just call this "topic" or something while we're at it?
> I.e. this on top (just s/nain/topic/g):
>
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index 9fcec604c3..4e33ec1fb9 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -201,12 +201,12 @@ test_expect_success 'cover everything with defaul=
t force-with-lease (protected)'
>  	setup_srcdst_basic &&
>  	(
>  		cd src &&
> -		git branch nain main^
> +		git branch topic main^
>  	) &&
>  	git ls-remote src refs/heads/\* >expect &&
>  	(
>  		cd dst &&
> -		test_must_fail git push --force-with-lease origin main main:nain
> +		test_must_fail git push --force-with-lease origin main main:topic
>  	) &&
>  	git ls-remote src refs/heads/\* >actual &&
>  	test_cmp expect actual
> @@ -216,16 +216,16 @@ test_expect_success 'cover everything with defaul=
t force-with-lease (allowed)' '
>  	setup_srcdst_basic &&
>  	(
>  		cd src &&
> -		git branch nain main^
> +		git branch topic main^
>  	) &&
>  	(
>  		cd dst &&
>  		git fetch &&
> -		git push --force-with-lease origin main main:nain
> +		git push --force-with-lease origin main main:topic
>  	) &&
>  	git ls-remote dst refs/heads/main |
> -	sed -e "s/main/nain/" >expect &&
> -	git ls-remote src refs/heads/nain >actual &&
> +	sed -e "s/main/topic/" >expect &&
> +	git ls-remote src refs/heads/topic >actual &&
>  	test_cmp expect actual
>  '
> =20
