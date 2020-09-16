Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAABC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD4420684
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wPYHFSwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgIPUl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:41:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56762 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgIPUlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 16:41:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0D0FE6835;
        Wed, 16 Sep 2020 16:41:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gYlgoe+MV/xV
        NdaOx7zdFAUFD1Y=; b=wPYHFSwG8wYWffbShWNiawABnKv4IaOi3a84nuSfyjnM
        G58WEGBR39aGrIlWx8Ounu37Z5qLuraoqEDsVTWr65sVJNxqCD7yDGWo9YjhDJyh
        H2Rz+6nv7oF5y1y2TSNBpypP3pkfFOYoV547Zaa73M9N2So/zpGqdVzlaiEvtk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=n1IhcO
        UWywsUTEmm2dfdJtIqA7XG2EEWlmY9NyvEy9zyd1hfF+jzaGC6f2F4wF+ySWbry/
        NfAzwKFCnYtQvbD1tQYMu54F1eTyoeYNX8Cv45hajX4ytz0zH13K30HI9xf0Pl4H
        uXc2NgiMOTHBE4JbPTHhuK2n/Nltkw9UGCIqg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E853EE6834;
        Wed, 16 Sep 2020 16:41:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12BECE6833;
        Wed, 16 Sep 2020 16:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 03/15] remote-mediawiki doc: bump recommended PHP
 version to 7.3
References: <20200916102918.29805-1-avarab@gmail.com>
        <20200916102918.29805-4-avarab@gmail.com>
        <20200916134730.GA10150@danh.dev>
Date:   Wed, 16 Sep 2020 13:41:43 -0700
In-Reply-To: <20200916134730.GA10150@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Wed, 16 Sep 2020 20:47:30 +0700")
Message-ID: <xmqqlfh9wj20.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 08C4353E-F85D-11EA-99BC-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-09-16 12:29:06+0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> Change the version in the documentation to what's currently in Debian
>> stable. Ideally we wouldn't have to keep changing this version, but if
>> it's going to be hardcoded let's use something that works on a modern
>> installation.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>>  contrib/mw-to-git/t/README | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
>> index 2ee34be7e4..d9c85e2c63 100644
>> --- a/contrib/mw-to-git/t/README
>> +++ b/contrib/mw-to-git/t/README
>> @@ -14,11 +14,11 @@ install the following packages (Debian/Ubuntu name=
s, may need to be
>>  adapted for another distribution):
>> ...
> Debian also provides meta package for those packages, built from
> php-defaults [1]:
>
> * php
> * php-cgi
> * php-cli
> * php-curl
> * php-sqlite3
>
> They'll pull current php7.3-* packages as dependencies.
>
> 1: https://packages.debian.org/source/buster/php-defaults

Looks like a good way to go.  Thanks.
