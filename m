Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81D01FF30
	for <e@80x24.org>; Tue, 23 May 2017 08:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935955AbdEWInP (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 04:43:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33627 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933976AbdEWInK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 04:43:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id w50so9341991wrc.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4PRVV6k6HHJE/kUej/3Q2BAIifOAE522wJ6DRIQuT+A=;
        b=dXychjzwCIwVbXLfYfg2dqAUKIsAQP9i0HSxJwIacxK8eCuTibeedDwWhHfy0lv8a7
         28QHE9KrMBIq+pmt4Yi/lMsSZYIwPhG0hDZdyeZZSyl+7d7Z7iCHmk0UwC5Wm+/iHeVX
         +nAQxxDa8vbQGLC9GHTvhhnD+M9W/9y/FJNtkfJEnOdl0VrtICzI3mHDjuC6GOUn8zv9
         V3sdMOMpzF/3LQ7Hh/WqS9eBGxFD206vdOQ8r2qe2s++GDZC4Fo7MLahJrEtQEa9y0ND
         h6EmZsRDU9UHVEtsgnrQlvuaUDyKGPtr53JiT8o0+m3KCLDuU+mEoyIWus/NvlKdBJo0
         dKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4PRVV6k6HHJE/kUej/3Q2BAIifOAE522wJ6DRIQuT+A=;
        b=VJ0QajX4b8nOHL1lv+fB62btUKjVMfpYiiBkRk2Ce7Vry3CsCGrTYIsun9KMfknkSX
         qjrMudShn1SthJjWjmZoyKTTv7nJxO/QyV3gXEGucbUcmeLnYCRKUxwxPkNkhUJRR1lY
         f8bWZ5Nj6Lm/fnurm5iyWoul6HE0D1x7DfpL1BBcuuotsCskcr0dE1qlaW/+0f8Sx9H3
         n+vLmbujrAMZNeS9t6dvwwDa7joKJWa6+b0+4CeiRe2uVDhdXQ5yWuUVRkWqqMYBQO2o
         haEdsXVLFptImeGBTm4wIKh1CXdhQ/NbG1dRTci5B3JpIP3h87kLStylU//Hwf0QROua
         GUsg==
X-Gm-Message-State: AODbwcB+h7hPfzAHCQF+fZSIjUXrPbVOD7GscpMwoQPVmhRGhuc7tTzh
        vcvM/iO93XF2rg==
X-Received: by 10.223.153.181 with SMTP id y50mr14408846wrb.41.1495528984211;
        Tue, 23 May 2017 01:43:04 -0700 (PDT)
Received: from [10.146.248.58] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l190sm81812wmb.18.2017.05.23.01.43.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 May 2017 01:43:03 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq1srgm9kq.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 23 May 2017 10:43:02 +0200
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB31E695-B7D5-4337-BACD-5191EB642F40@gmail.com>
References: <20170522135001.54506-1-larsxschneider@gmail.com> <20170522135001.54506-5-larsxschneider@gmail.com> <64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de> <04ECEBE5-CAC8-4344-B07A-6B7A7C795C94@gmail.com> <xmqq1srgm9kq.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 May 2017, at 07:22, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>>> +	sigchain_pop(SIGPIPE);
>>>> +
>>>> +	if (err || errno =3D=3D EPIPE) {
>>>=20
>>> This looks strange, at first glance.
>>> Do we set errno to 0 before ?
>>> Or is there a trick that EPIPE can only be reached,
>>> if it is "our" error ?
>>=20
>> You are right and I'll fix it!=20
>> Thanks for reminding me!=20
>> Peff also noticed that some time ago:
>> =
http://public-inbox.org/git/20170411200520.oivytvlzkdu7bfh5@sigill.intra.p=
eff.net/
>=20
> Ben Peart's bp/sub-process-convert-filter topic also had the same
> EPIPE issues in its earlier incarnation, IIRC.  I haven't looked at
> this topic for some time, but I wonder if we can share code with it.

That's right. There might be some code sharing opportunity with Ben's
code that is already in "next":
https://github.com/git/git/blob/next/convert.c#L660-L677

Would it be useful for you if I send v5 with the changes rebased=20
onto "next"?

Thanks,
Lars


