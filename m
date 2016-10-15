Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F108A20988
	for <e@80x24.org>; Sat, 15 Oct 2016 14:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbcJOOpy (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 10:45:54 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34198 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbcJOOpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 10:45:52 -0400
Received: by mail-pf0-f171.google.com with SMTP id r16so38173019pfg.1
        for <git@vger.kernel.org>; Sat, 15 Oct 2016 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ozyX3d6w15/mCxT80s2T7TNnl2OCXLDnF/UDVcUoO/Q=;
        b=aQwwo4eVSP1U8qG/Npy8CGumf2l5Kzb95QKrPIRDBiD6TpBi6vF8J3ZEkUgF2sm/N0
         7uz1Yb2Cihu9cL1H4xNbl4V6UZt15QvrKc3jwd3forUT3NOFWZSOkcLF2lqH3jsfe86x
         MY4dGoVMA7NkFh97EYto6CYbyfygjoIe+4lO09q0kGX8Artzlb7XeY+B8Z/z6v6o4QxD
         vCHKjN+9rK7/p9cIQJ87IeES6r2FE2qYi5Cb0fzy2DJFdfDB4QGMPaSpozt1illaEZzI
         VCFktasuOyX3QRxhNT7mJey9pgVaq+tsPEdmYVl+HwIoVhTkGEr/awQLG5rwd+WD/rOb
         eZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ozyX3d6w15/mCxT80s2T7TNnl2OCXLDnF/UDVcUoO/Q=;
        b=RT4rGds9FiPY8O+/SV3Dp1rYi/OO8BodkDk+2qq04wqtwjDKr6IGz5gJt8tUG6LVH0
         iMb9tfNZxPmNrsRaVINRF04quhN/sc/LWfkGa/N73CpJz6MpJngoonAvfUeHZA987P6o
         TNJpzogl+W42wFn5hSFQhevxX00DyZJc/0B1zAoOT4wrpO5WX3Pq3K7CwHM4GxBAiviC
         fPjbXxA/ohao5uiHLNHH3wIb3GsnIC/BI0bOe7JY1OR51F+dm4NfxTz9nCOxAY5M1tWh
         pFDBOkfl+w+3FZDA+gEWjtsJXsdL1gnuJC9rj1OfwJ80aMhhAiAlrQ2LMxBeHfVncXx2
         eCYg==
X-Gm-Message-State: AA6/9Rm5S/fu0kBXIH5dwv6tYF2Kzn44jKhfG2BlEDvUA2mqF6mrznSAAWFZYn+3BXXPRQ==
X-Received: by 10.99.3.77 with SMTP id 74mr21762903pgd.174.1476542751702;
        Sat, 15 Oct 2016 07:45:51 -0700 (PDT)
Received: from mtl3z26wz1.ads.autodesk.com (adsk-nat-ip11.autodesk.com. [132.188.71.11])
        by smtp.gmail.com with ESMTPSA id yk6sm35695825pab.43.2016.10.15.07.45.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Oct 2016 07:45:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <37c12539-3edd-e04b-6e09-e977a854661c@gmail.com>
Date:   Sat, 15 Oct 2016 07:45:48 -0700
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3732E902-2FE9-4C99-B27D-69B9A3FF8639@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-14-larsxschneider@gmail.com> <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com> <03278DA5-34B8-42F1-B52E-A42A3BCD5FB8@gmail.com> <37c12539-3edd-e04b-6e09-e977a854661c@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@Peff: If you have time, it would be great if you could comment on
one question below prefixed with "@Peff". Thanks!


> On 12 Oct 2016, at 03:54, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> W dniu 12.10.2016 o 00:26, Lars Schneider pisze:=20
>>> On 09 Oct 2016, at 01:06, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>>>=20
>>=20
>>>> After the filter started
>>>> Git sends a welcome message ("git-filter-client"), a list of
>>>> supported protocol version numbers, and a flush packet. Git expects
>>>> +to read a welcome response message ("git-filter-server") and =
exactly
>>>> +one protocol version number from the previously sent list. All =
further
>>>> +communication will be based on the selected version. The remaining
>>>> +protocol description below documents "version=3D2". Please note =
that
>>>> +"version=3D42" in the example below does not exist and is only =
there
>>>> +to illustrate how the protocol would look like with more than one
>>>> +version.
>>>> +
>>>> +After the version negotiation Git sends a list of all capabilities =
that
>>>> +it supports and a flush packet. Git expects to read a list of =
desired
>>>> +capabilities, which must be a subset of the supported capabilities =
list,
>>>> +and a flush packet as response:
>>>> +------------------------
>>>> +packet:          git> git-filter-client
>>>> +packet:          git> version=3D2
>>>> +packet:          git> version=3D42
>>>> +packet:          git> 0000
>>>> +packet:          git< git-filter-server
>>>> +packet:          git< version=3D2
>>>> +packet:          git> clean=3Dtrue
>>>> +packet:          git> smudge=3Dtrue
>>>> +packet:          git> not-yet-invented=3Dtrue
>>>> +packet:          git> 0000
>>>> +packet:          git< clean=3Dtrue
>>>> +packet:          git< smudge=3Dtrue
>>>> +packet:          git< 0000
>>>=20
>>> WARNING: This example is different from description!!!
>>=20
>> Can you try to explain the difference more clearly? I read it =
multiple
>> times and I think this is sound.
>=20
> I'm sorry it was *my mistake*.  I have read the example exchange =
wrong.
>=20
> On the other hand that means that I have other comment, which I though
> was addressed already in v10, namely that not all exchanges ends with
> flush packet (inconsistency, and I think a bit of lack of =
extendability).

Well, this part of the protocol is not supposed to be extensible because
it is supposed to deal *only* with the version number. It needs to keep=20=

the same structure to ensure forward and backward compatibility.

However, for consistency sake I will add a flush packet.


>>> In description above the example you have 4-part handshake, not =
3-part;
>>> the filter is described to send list of supported capabilities last
>>> (a subset of what Git command supports).
>>=20
>> Part 1: Git sends a welcome message...
>> Part 2: Git expects to read a welcome response message...
>> Part 3: After the version negotiation Git sends a list of all =
capabilities...
>> Part 4: Git expects to read a list of desired capabilities...
>>=20
>> I think example and text match, no?
>=20
> Yes, it does; as I have said already, I have misread the example.=20
>=20
> Anyway, in some cases 4-way handshake, where Git sends list of
> supported capabilities first, is better.  If the protocol has
> to prepare something for each of capabilities, and perhaps check
> those preparation status, it can do it after Git sends what it
> could need, and before it sends what it does support.
>=20
> Though it looks a bit strange that client (as Git is client here)
> sends its capabilities first...

Git tells the filter what it can do. Then the filter decides what
features it supports. I would prefer to keep it that way as I don't
see a strong advantage for the other way around.


>>> By the way, now I look at it, the argument for using the
>>> "<capability>=3Dtrue" format instead of "capability=3D<capability>"
>>> (or "supported-command=3D<capability>") is weak.  The argument for
>>> using "<variable>=3D<value>" to make it easier to implement parsing
>>> is sound, but the argument for "<capability>=3Dtrue" is weak.
>>>=20
>>> The argument was that with "<capability>=3Dtrue" one can simply
>>> parse metadata into hash / dictionary / hashmap, and choose
>>> response based on that.  Hash / hashmap / associative array
>>> needs different keys, so the reasoning went for "<capability>=3Dtrue"
>>> over "capability=3D<capability>"... but the filter process still
>>> needs to handle lines with repeating keys, namely "version=3D<N>"
>>> lines!
>>>=20
>>> So the argument doesn't hold water IMVHO, and we can choose
>>> version which reads better / is more natural.
>>=20
>> I have to agree that "capability=3D<capability>" might read a
>> little bit nicer. However, Peff suggested "<capability>=3Dtrue"=20
>> as his preference and this is absolutely OK with me.
>=20
> =46rom what I remember it was Peff stating that he thinks "<foo>=3Dtrue"=

> is easier for parsing (it is, but we still need to support the harder
> way parsing anyway), and offered that "<foo>" is good enough (if less
> consistent).
>=20
>> I am happy to change that if a second reviewer shares your
>> opinion.
>=20
> Also, with "capability=3D<foo>" we can be more self descriptive,
> for example "supported-command=3D<foo>"; though "capability" is good
> enough for me.
>=20
> For example
>=20
> packet:          git> wants=3Dclean
> packet:          git> wants=3Dsmudge
> packet:          git> wants=3Dsize
> packet:          git> 0000
> packet:          git< supports=3Dclean
> packet:          git< supports=3Dsmudge
> packet:          git< 0000
>=20
> Though coming up with good names is hard; and as I said "capability"
> is good enough; OTOH with "smudge=3Dtrue" etc. we don't need to come
> up with good name at all... though I wonder if it is a good thing =
`\_o,_/

How about this (I borrowed these terms from contract negotiation)?

packet:          git> offers=3Dclean
packet:          git> offers=3Dsmudge
packet:          git> offers=3Dsize
packet:          git> 0000
packet:          git< accepts=3Dclean
packet:          git< accepts=3Dsmudge
packet:          git< 0000

@Peff: Would that be OK for you?


>>>> +------------------------
>>>> +packet:          git< status=3Dabort
>>>> +packet:          git< 0000
>>>> +------------------------
>>>> +
>>>> +After the filter has processed a blob it is expected to wait for
>>>> +the next "key=3Dvalue" list containing a command. Git will close
>>>> +the command pipe on exit. The filter is expected to detect EOF
>>>> +and exit gracefully on its own.
>>>=20
>>> Any "kill filter" solutions should probably be put here.
>>=20
>> Agreed.=20
>>=20
>>> I guess
>>> that filter exiting means EOF on its standard output when read
>>> by Git command, isn't it?
>>=20
>> Yes, but at this point Git is not listening anymore.
>=20
> I think it might be good idea to have here the information about
> what filter process should do if it needs maybe lengthy closing
> process, to not hold/stop Git command or to not be killed.

I've added:

"Git will wait until the filter process has stopped."


Thanks,
Lars=
