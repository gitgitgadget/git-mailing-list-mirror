Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA652055E
	for <e@80x24.org>; Sat, 28 Oct 2017 16:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdJ1Q5C (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 12:57:02 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:48037 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdJ1Q5B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 12:57:01 -0400
Received: by mail-wr0-f170.google.com with SMTP id y39so8692858wrd.4
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oT2gK1/8Vd1e0OV4YYWcGXtKw2pJlnlr5v7PqjayU+M=;
        b=rzDkpkobRVUDrsAA4wKvgx/OgNEsFI0eXTzKuCcV9HlfY0MqW9rQUgQVzIsgzmQlzl
         WE2XgiDlyjRxfeayioa9h3PH0z7MKdF4xgk2FnLFcjrHlieK5Nt90//XE02oGNqU4Z9d
         x8Jd2gzAJk8U+H1+vF/FLYitTv0L4d/uJyvbwSwUSftbb2F+gnftTbxhutp2XZ+Ru+jA
         UpCzt7CoUb1l2XMueqYJxeSnYFf2k43hJ7pZozIWtkX9uODEiDTQ6HB2gfp0cuTCJFzk
         Q2Cii22ivpNy06JTsYEZoUrpoyAfVjJP6tc2rranOHYd2py5vTKMf5oyTRGMn3uSy5Pg
         qyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oT2gK1/8Vd1e0OV4YYWcGXtKw2pJlnlr5v7PqjayU+M=;
        b=WeEugHdyUpggy7dwu1vksMWsEkxC0VeZO8LUa3/ZoL3Y576jY3kg0+zjW2tnM3ELTc
         eGg3u7LeMbFjv0MTTkBAk1k3apH6JgcfRipJhR2ySNz4jIRLqAZBijghFBU2qeJYPMip
         LHUcb0uqtFMeV1ie2S6LqkrrJz4odYitwPC/uhPoLhtnxwyYuNPWO+V1lYT2YnHRvEfj
         UydxjllhAczVHXbjW9O9ez2W/VUf7bsA71+hFqjcU7Gx5vgCfzJX7UVStop+4lmkwmgq
         BvbGaHDZg0mpnCNxmfHsiQqSg3zxyQU6rzKChE6pq9/WCNSRKQb1PVIqYKNVc9mBLJ63
         n59w==
X-Gm-Message-State: AMCzsaUOirp0W6YC8oCWCvFJaDT+tcalcZN7vnLhLPEIyLl6uRVhxJ47
        GOj6Td1DjWv/SZ52zm9Bljw=
X-Google-Smtp-Source: ABhQp+Te5vnGmhU+vHAOfRyjtK9Q4uDcsitXN1bk+im3OtFqYIhnqdH1TFg8LxJWHM4dtgahC7qeLQ==
X-Received: by 10.223.171.6 with SMTP id q6mr3225112wrc.117.1509209820131;
        Sat, 28 Oct 2017 09:57:00 -0700 (PDT)
Received: from [10.32.248.84] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id v8sm8611346wrg.80.2017.10.28.09.56.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Oct 2017 09:56:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [git-for-windows] Git for Windows v2.15.0-rc prerelease, was Re: [ANNOUNCE] Git v2.15.0-rc2
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.21.1.1710281838230.6482@virtualbox>
Date:   Sat, 28 Oct 2017 18:56:57 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A5EBFA0-3DC4-4AA1-91DB-450DC89BA8E7@gmail.com>
References: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710210020290.40514@virtualbox> <18E24F0C-D518-46B6-A8D5-71B0E1B05DE0@gmail.com> <DC84FB2E-A26E-4957-B5FA-BE6DDEC3411B@gmail.com> <alpine.DEB.2.21.1.1710281838230.6482@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Oct 2017, at 18:40, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Lars,
>=20
> On Fri, 27 Oct 2017, Lars Schneider wrote:
>=20
>>> On 27 Oct 2017, at 14:11, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>>>=20
>>>> On 21 Oct 2017, at 00:22, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>>>>=20
>>>> [cutting linux-kernel]
>>>>=20
>>>> On Fri, 20 Oct 2017, Junio C Hamano wrote:
>>>>=20
>>>>> A release candidate Git v2.15.0-rc2 is now available for testing
>>>>> at the usual places.
>>>>=20
>>>> The Git for Windows equivalent is now available from
>>>>=20
>>>>  =
https://github.com/git-for-windows/git/releases/tag/v2.15.0-rc2.windows.1
>>>=20
>>> I just tested RC2 on Windows and I don't see my "Filtering content:"
>>> output if I clone a Git repository with Git LFS files (and Git LFS
>>> 2.3.3+ installed).
>>>=20
>>> The feature was introduced in the following commit which is be part =
of
>>> your RC2 build commit (b7f8941):
>>> =
https://github.com/git/git/commit/52f1d62eb44faf569edca360ec9af9ddd4045fe0=

>>>=20
>>> On macOS everything works as expcted with RC2:
>>>   ...
>>>   remote: Total 15012 (delta 0), reused 0 (delta 0), pack-reused =
15012
>>>   Receiving objects: 100% (15012/15012), 2.02 MiB | 753.00 KiB/s, =
done.
>>>   Filtering content:  43% (6468/15000), 33.30 KiB | 0 bytes/s
>>>   ...
>>>=20
>>> Do you, or other Windows experts, spot something in the commit =
linked
>>> above that could cause trouble on Windows?
>>=20
>> Well, it turns out the output works for my real life repos but not =
for
>> my Git LFS testing repo.
>>=20
>>    git clone https://github.com/larsxschneider/lfstest-manyfiles
>>=20
>> ... prints the filtering content output on macOS but not on Windows.
>> The progress function has some delay feature that suppresses the =
output
>> if it is only shown for a second or something. However, in this test =
case
>> the output should be visible for several seconds at least...
>> I am still puzzled.
>=20
> Nothing really strikes me as obvious.
>=20
> Do you do this in Git Bash? If so, maybe you can also test in Git CMD? =
I
> do remember having issues with stderr only showing up in time if it =
was
> fflush()ed explicitly, but only in Git Bash (i.e. a MinTTY problem).

Same behavior in Git Bash and Git CMD. I also noticed that this seems to
be a more general problem. Git is supposed to show "Checking out files"
and I don't see that if I clone the repository linked above.

IOW: This is not a Git LFS or Git filtering problem.

I am testing on Windows 8 with Git 2.15 RC2.

Thanks,
Lars=
