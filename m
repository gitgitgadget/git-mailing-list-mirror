Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B43CC43462
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46647613FC
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhELXZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:25:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56457 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhELWle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:41:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59F0E12AFBB;
        Wed, 12 May 2021 18:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c1O45kAY9yHu
        HZm5FNh9ZlWBRk9gAQvXEbTaT/QJlxY=; b=tEI9HMu3vt4J6yf+TdvNhMOwSnBa
        0syxh/cBc3DpQUrh4kuK+OzhAayYe+y51kXi+i9qHE5y3s8Bi13+mqPwP7NszL0a
        FyxeUo+0lDxf+ShMq6TVw4eulzhScSj7wJ3GAgUWUtMXMW3nEZ8nCCBudVkHICB4
        50335N5rMt/QkWQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5214412AFB9;
        Wed, 12 May 2021 18:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 854DD12AFB8;
        Wed, 12 May 2021 18:40:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 2/3] SubmittingPatches: replace discussion of Travis
 with GitHub Actions
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
        <patch-2.3-7add00cc87-20210512T084137Z-avarab@gmail.com>
Date:   Thu, 13 May 2021 07:40:13 +0900
In-Reply-To: <patch-2.3-7add00cc87-20210512T084137Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 12 May
 2021 10:45:01 +0200")
Message-ID: <xmqq4kf7fueq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 053FC474-B373-11EB-8DE0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -If you have an account at GitHub (and you can get one for free to work
> -on open source projects), you can use their Travis CI integration to
> -test your changes on Linux, Mac (and hopefully soon Windows).  See
> -GitHub-Travis CI hints section for details.
> +If you have an account at GitHub pushing to a fork of
> +https://github.com/git/git will use their CI integration to test your
> +changes on Linux, Mac and Windows. See the GitHub CI section for detai=
ls.

s/If you have an account at GitHub pushing/Pushing/

Whether pushing to a fork is possible is not even need to be said
with "If you have an account" here, as you begin the "GitHub CI"
section with "With an account at GitHub".

    Side note: I initially started to point out the lack of comma
    before "pushing", but after re-reading the paragraph, realized
    that the part before that missing comma is better left out.

> @@ -451,12 +450,12 @@ their trees themselves.
>    the status of various proposed changes.
> =20
>  [[travis]]
> -=3D=3D GitHub-Travis CI hints
> +=3D=3D GitHub CI
> =20
> -With an account at GitHub (you can get one for free to work on open
> -source projects), you can use Travis CI to test your changes on Linux,
> -Mac (and hopefully soon Windows).  You can find a successful example
> -test build here: https://travis-ci.org/git/git/builds/120473209
> +With an account at GitHub you can use GitHub CI to test your changes

Here, insert comma before "you can use".

> +on Linux, Mac and Windows. See
> +https://github.com/git/git/actions/workflows/main.yml for examples of
> +recent CI runs.

Thanks.
