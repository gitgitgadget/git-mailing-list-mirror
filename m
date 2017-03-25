Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DA620966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbdCYVxK (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:53:10 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37515 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdCYVxK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 17:53:10 -0400
Received: by mail-it0-f43.google.com with SMTP id 190so20590446itm.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1ruzp3LgynPwBlwnVWPjBoHDjIUcXhpZmwKHT1U9wfk=;
        b=RLEbMEc6PgVJbnxRhjE7qBQN8JY3B0EomKuU8ntLxR9QL4X2PC7WJUTkVj0RBuT8f8
         aOxxiV8rW8AktKvBN2jLF2blvWQYxE/sWtGQHsMXd/UwiI1SfpbzYR4kgBjJsifWzBWy
         lwNOQkTPEJo4XmDxIsKiJK+izQLZ45+x4oKoDpxLZvP4fijwExaHneFfSJ9CUpmwXoS2
         NSECoqZkW4I1w+8SW5U2a6u2yrAwxbyBTc95b621rPOV6RHhJvYHFjvhsPazhrjtEz9A
         QzE/IPZrSuRwxEWmigMY3xoUiBMlU0rI5GGvZ+tR1OFNrRrjHykkg+NMfKS6QOrseAs/
         4t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=1ruzp3LgynPwBlwnVWPjBoHDjIUcXhpZmwKHT1U9wfk=;
        b=WHRQDIljwUTnL4i4KXMTqmUFOzz6KkINMx+rPWohetHguMiKoELYItRZv6SlmOWsmu
         ez36R0GsfTzyZYCzMwLasZXnsV0/GY5NQ4m3c1yn6pl1r/oUPXmL3WECq/3FbFewjcpY
         Ja8+g0YgZKXsQpjT9Z2EwKQscGZerl4nVMxobI9ofbkVgo2ARv7yls074PP5M7LG7Ai9
         xMKXaraMf3ZZfowPAc2OBWltBiilffJd4Bpx3uY15AXqcpEDz9Fz/NayIkIUL9IAvTFC
         SdYC8bExhmtizjmpSH1bXe/ksxBNsWFDKMdx0lKZJojUlX1qS0nmsWlu/pN1w/dwURAj
         lC8Q==
X-Gm-Message-State: AFeK/H1t98z8kTvjsWDdL1sJV6FVKfJy0Q53sdpaNboI2cjFzUN0UQbMoXe1werY4P2K8VatfF8SUOLEV+Eoyg==
X-Received: by 10.36.76.11 with SMTP id a11mr3628580itb.60.1490478788546; Sat,
 25 Mar 2017 14:53:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 25 Mar 2017 14:52:47 -0700 (PDT)
In-Reply-To: <20170325214427.f3kdxgrldpnar4ag@genre.crustytoothpaste.net>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
 <20170325214427.f3kdxgrldpnar4ag@genre.crustytoothpaste.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 22:52:47 +0100
Message-ID: <CACBZZX6=zEHkYUZ3qOQLmB+6658YN1Hy+3TY8zLAxjpUtivQpA@mail.gmail.com>
Subject: Re: Will OpenSSL's license change impact us?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 10:44 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sat, Mar 25, 2017 at 12:51:52AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> They're changing their license[1] to Apache 2 which unlike the current
>> fuzzy compatibility with the current license[2] is explicitly
>> incompatible with GPLv2[3].
>>
>> We use OpenSSL for SHA1 by default unless NO_OPENSSL=3DYesPlease.
>>
>> This still hasn't happened, but given the lifetime of git versions
>> packaged up by distros knowing sooner than later if this is going to
>> be a practical problem would be good.
>>
>> If so perhaps we could copy the relevant subset of the code int our
>> tree, or libressl's, or improve block-sha1.
>
> I think that most distros don't link against OpenSSL because they can't
> take advantage of the system library exception.  I don't think that's
> going to change.

"ldd -r" against git itself on my Debian testing doesn't return
libssl, but git-imap-send is dynamically linked to it:

$ ldd -r /usr/lib/git-core/git-imap-send|grep ssl
        libssl.so.1.0.2 =3D> /usr/lib/x86_64-linux-gnu/libssl.so.1.0.2
(0x00007f244b2f6000)
$ apt-cache show libssl1.0.2:amd64
Package: libssl1.0.2
Source: openssl1.0
Version: 1.0.2k-1
[...]
Homepage: https://www.openssl.org

> If we want to consider performance-related concerns, I think the easier
> solution is using Nettle, which is LGPL 2.1.  Considering that the
> current opinions for a new hash function are moving in the direction of
> SHA-3, which Nettle has, but OpenSSL does not, I think that might be a
> better decision overall.  It was certainly the implementation I would
> use if I were to implement it.

Yeah there's a lot of options open for just sha1-ing, but we also use
OpenSSL for TLS via imap-send.
