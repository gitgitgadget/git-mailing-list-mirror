Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8E31F404
	for <e@80x24.org>; Mon,  5 Mar 2018 22:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeCEWPw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 17:15:52 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:52008 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeCEWPw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 17:15:52 -0500
Received: by mail-it0-f49.google.com with SMTP id u66so11334590ith.1
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 14:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5X3YgVb36FdMZXN+Jc5txErL8E3yt8ZMxtnXznI33Uc=;
        b=llVrjKTwwWgnUGSR1cW2wo1oonp5haCMGuD1bvX6rXujJ9sTxv0+UDTMx55XZcvB+m
         0BOhMxRqoSd/crigf5a+ddmeSgzKxkmJ95nfVzibuq5wFPeS7/3pk1Q6MFAjLIe4x9/i
         2sNNAK+rfH0RmhK2CPQnLJrFE5bR6GOwUKP/HAStaabnsYJTx1mqLB3yNkjfwCJEx4yb
         sEkB7LeB2k7kNjt0u0ZYa0CoTUFpy3kicJem/2Np+dsOXWA0aQLwEQAKmBXNxsVNkwzr
         Q4Ga4p27SwFXph/7BXkU9geNpI/S+Pt4v4OVK6QrvCkToXn0Y4od5/VCRrFpIPi8LS/d
         cuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5X3YgVb36FdMZXN+Jc5txErL8E3yt8ZMxtnXznI33Uc=;
        b=onbvUFNu+IXFRtk5Kwr7qPAMMfkSMKs96T31rkVNjXD9fJ8AQ30l6fm4DHJD1b0AZw
         gDFPGFaCcj6vekqmbvXYv6HYretIeUUzTuet/rg06iJTO3095j7osGJuFPQGxmNuMdoH
         wLb/oJwbbOrESSrWOa4Ya+07vBxGyiGAdjXMJqVtsPm0TMzr1nZwpPRjkrOUFmK6EGg8
         rQEpX20nCxLPbYHT4NphgkQs+/mYm2KWW2Bu1SFYg1ie69gTv+uQhOgYTZyq1x47n6Vq
         YNww9G8KgSkXZlZhJhscNYsqQTOYrPg52bSYXFKQBhp9YjoUw9LlDgVjAYS/sDXdPYPr
         WyyQ==
X-Gm-Message-State: AElRT7EcSCdAq6Ab/8JvrsGceVYZ8yd6XegZH8/eA6vRJCZPXILH8iWK
        E59dlji11fQFjZeRDBwftfTd5VoRDKq1FnoQ69g=
X-Google-Smtp-Source: AG47ELsoR4deOtOW+PPE6yiSbcGPHLhVObMvy9JSeJ/XysYzKWAhU1vOTlkXcQhfM82KSzp8i2hlllcF4TI5eiLZoDA=
X-Received: by 10.36.67.1 with SMTP id s1mr956483itb.145.1520288151535; Mon,
 05 Mar 2018 14:15:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.133.69 with HTTP; Mon, 5 Mar 2018 14:15:30 -0800 (PST)
In-Reply-To: <xmqqbmg2898w.fsf@gitster-ct.c.googlers.com>
References: <20180303055715.GH27689@sigill.intra.peff.net> <20180303055849.GB15952@sigill.intra.peff.net>
 <878tb6nr6u.fsf@evledraar.gmail.com> <xmqqbmg2898w.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 5 Mar 2018 23:15:30 +0100
Message-ID: <CACBZZX5H2aiswHNkWVrva20vaEQqN0GGBTidM1htksY6Q3at2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] add--interactive: detect bogus diffFilter output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 5, 2018 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sat, Mar 03 2018, Jeff King jotted:
>>
>>> +    if (@colored && @colored !=3D @diff) {
>>
>> nit: should just be:
>>
>>     if (@colored !=3D @diff) {
>>
>> It's not possible for @arrays in scalar context to be undefined.
>
> It is true that @array can not be undef, but your rewrite I think is
> wrong.
>
> The first "do the comparison only @colored is true" is not about
> definedness.  It is "@colored can be an empty array when the user is
> not using separate 'show these colored lines to the end user, feed
> these noncolored lines to git-apply command' feature, so @colored=3D=3D0
> and @diff > 0 is perfectly fine".

Yes, sorry for the noise. I misread the intent of the code.
