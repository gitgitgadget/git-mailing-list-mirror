Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D84F200B9
	for <e@80x24.org>; Mon,  7 May 2018 14:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeEGOU4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 10:20:56 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:41329 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeEGOUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 10:20:55 -0400
Received: by mail-qt0-f174.google.com with SMTP id g13-v6so36432483qth.8
        for <git@vger.kernel.org>; Mon, 07 May 2018 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=kTwCTmm+qM3kR6mErAin/0LCic7Kpz9w0+L56tTO+4Q=;
        b=WdlQx+DKSpkFS96iovFwHR3SgyfHXV+dGS1QIavPxU8U/0lcjqmfJHaZZPCrqpmFUS
         GGexgcg3Qhjt8M9OifVv2AFSvheBEIwt/9+zmOt6d+XrNEId9N7sDQ/T83bqtInhUalQ
         EIizZHq+mX8tVMW4VAAE5AhpM91EBb2h7tpSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=kTwCTmm+qM3kR6mErAin/0LCic7Kpz9w0+L56tTO+4Q=;
        b=P2NACZFMOeJf6fNUgsBZXVRBOAa084PbB8BD1LknfE2rObUDzkfQOrRTS5jdfH0u+T
         GhQ1EXAmNAc4/fbNcDIy+dWf0CvbmIjjkgKMbbRnqiaT+35sgLhRjdPz/Pxuph758VmS
         DeGSw4bHrQs4IajKuyMcY8wQsQsLRQNHlY5KJAromnDW0yqTskxLthhj0XOWt5LVYk+9
         g61nMOSpJjLXvXfeATF5qFO/MDu4UckKU3eucHQZaYjN46+54WGw3EjjBHFj5R+b+ZhP
         UerF+l3ceoQIGUnYKYIqlAO/2onw/LT8ix7iB6yNj8NgvLuFNkmHPIjvmnCvoy3im55u
         REHw==
X-Gm-Message-State: ALQs6tDXgjbqMFiVVB9sWNQgIDF//PWmx2Dhp5r3OzOytAwLkLa6Z710
        r5zMLljOv076zml998Nh4wqfcGCkSNk=
X-Google-Smtp-Source: AB8JxZoREOfz9ceUh2Z1SD+hLH1gCCDth6xCq7lBIbJ1PL39yM5UNTB09m+cb6b1hhyW6y1x32r+3g==
X-Received: by 2002:ac8:4293:: with SMTP id o19-v6mr33537786qtl.321.1525702853918;
        Mon, 07 May 2018 07:20:53 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id b12-v6sm7334936qtb.57.2018.05.07.07.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 07:20:53 -0700 (PDT)
Subject: Re: main url for linking to git source?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20180507063713.GA28961@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805070731580.77@tvgsbejvaqbjf.bet>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <4d2b13ae-7f13-4f9c-2baa-f3e04fa9526a@linuxfoundation.org>
Date:   Mon, 7 May 2018 10:20:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805070731580.77@tvgsbejvaqbjf.bet>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3SUxB5zA1Z6PpCnWqE3F9oXg8KjCXOT7p"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3SUxB5zA1Z6PpCnWqE3F9oXg8KjCXOT7p
Content-Type: multipart/mixed; boundary="KmAi7D2gvcMfdG5YZ08UQDVxmKQjZtpqt";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Message-ID: <4d2b13ae-7f13-4f9c-2baa-f3e04fa9526a@linuxfoundation.org>
Subject: Re: main url for linking to git source?
References: <20180507063713.GA28961@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805070731580.77@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1805070731580.77@tvgsbejvaqbjf.bet>

--KmAi7D2gvcMfdG5YZ08UQDVxmKQjZtpqt
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 05/07/18 07:38, Johannes Schindelin wrote:
>> The git-scm.com site currently links to https://github.com/git/git for=

>> the (non-tarball) source code. Somebody raised the question[1] of
>> whether it should point to kernel.org instead.
>>
>> Do people find one interface more or less pleasing than the other? Do =
we
>> want to prefer kernel.org as more "official" or less commercial?
>=20
> I don't really care about "official" vs "commercial", as kernel.org is
> also run by a business, so it is all "commercial" to me.

Kernel.org is a registered US non-profit organization, managed by a
non-profit industry consortium (The Linux Foundation). The entire stack
behind kernel.org is free software, excepting any firmware blobs on the
physical hardware.

I'm not trying to influence anyone's opinion of where the links should
be pointing at, but it's important to point out that kernel.org and
GitHub serve different purposes:

- kernel.org provides free-as-in-liberty archive hosting on a platform
that is not locked into any vendor.

- github.com provides an integrated development infrastructure that is
fully closed-source, excepting the protocols.

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--KmAi7D2gvcMfdG5YZ08UQDVxmKQjZtpqt--

--3SUxB5zA1Z6PpCnWqE3F9oXg8KjCXOT7p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvBgwwAKCRC2xBzjVmSZ
bOaZAQDZ0Ua5NjTHjMwDVoOtOi8FYgW7YaBQ0Xw/dX3Vx6me7QD8D4Mctih27kgC
1otZ5ECwnz3G0DZp9t71sSOlKzumvA0=
=eHxw
-----END PGP SIGNATURE-----

--3SUxB5zA1Z6PpCnWqE3F9oXg8KjCXOT7p--
