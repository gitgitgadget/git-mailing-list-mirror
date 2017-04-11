Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 203F220970
	for <e@80x24.org>; Tue, 11 Apr 2017 19:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbdDKTuT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 15:50:19 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37169 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753273AbdDKTuS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 15:50:18 -0400
Received: by mail-wm0-f44.google.com with SMTP id u2so8819692wmu.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7PQUq4ADBAthayWVHPudPVCiQS+Vl9dwHeo5981wKVs=;
        b=GzkTxQpBY9GoU+Iblt4go8TZCC0nR7xypUNvng1JIBz9NAH9IxwBkJYSO0PhYDUVRY
         EOOYlpvkpAe5VWnqpI1XI1MlgSLdElrIU/RMAbHhv9tMrDJRBwGySIiR3xFKf3bfPFYK
         O7zMr4G7jBp/tMtv9YhqCKpS7h9VLFeIcuReYyPIzrkJiYDOIq7b8X5TzzAHltBECDaR
         VYWL9tE86quACB1Tz/1zMO11eaPrPDcNH6FKCtg+S8WrR6IlyIwD8AYkpxFMSPPC7X6j
         NEfwYl9bU4oO3UMrdw18XFRP6vSFCLqhx05yrm+J/hfvTCGKnjr+vCZJtRrUGHYkaCUf
         jFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7PQUq4ADBAthayWVHPudPVCiQS+Vl9dwHeo5981wKVs=;
        b=HqbcQN1Cx6gKT3m5gjwFpWcpp0v7GiCwryi3nvy2FoGaLTugZk87BBYv0sgbliXKJ2
         rEtyo0WkRMuPPB4bfPIYGR4H5IKBM0kLZtr3Dw5xG6n8uGCjFbIhnqdUfgURGfirCswx
         25VuVVsHuuWvosk4GcwVGAkqVuBL9cYf+gqg8ZeZVt1qJ8F5PObgEhnDLJQHX0p/DqPB
         CP+RGssaJjpIm6y95SwGiHGFrMeBVe+zh1AAoCW6HvaGLb8guE1R4vjwETD7njEsFyJC
         /+z768sDbQLkhbLD9cWwR53txXehQhHWAYwjFTXNVYCMqeyF+0Uv5alyLxpgJZfTyMBA
         Qq2Q==
X-Gm-Message-State: AN3rC/6oONaGd3sbdTZNt17pLqHe/q4HS/dnEM3a9b9r1AGhSAaDbz+wZMDjDIIh6EWJtQ==
X-Received: by 10.28.186.3 with SMTP id k3mr14668030wmf.74.1491940216396;
        Tue, 11 Apr 2017 12:50:16 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB53F4.dip0.t-ipconnect.de. [93.219.83.244])
        by smtp.gmail.com with ESMTPSA id f135sm3735053wmd.7.2017.04.11.12.50.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 12:50:15 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <a7fd3bef-49b2-0b0a-8ca4-89e41a402661@web.de>
Date:   Tue, 11 Apr 2017 21:50:14 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net, e@80x24.org,
        ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <388C3F2A-AC77-499F-9C74-216F5DC00FD8@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com> <20170409191107.20547-5-larsxschneider@gmail.com> <a7fd3bef-49b2-0b0a-8ca4-89e41a402661@web.de>
To:     =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Apr 2017, at 22:54, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>=20
> On 2017-04-09 21:11, Lars Schneider wrote:
> []
>> +------------------------
>> +packet:          git> command=3Dsmudge
>> +packet:          git> pathname=3Dpath/testfile.dat
>> +packet:          git> delay-able=3D1
>> +packet:          git> 0000
>> +packet:          git> CONTENT
>> +packet:          git> 0000
>> +packet:          git< status=3Ddelayed
>> +packet:          git< 0000
>> +packet:          git> delay-id=3D1
>> +packet:          git> 0000
>> +packet:          git< status=3Dsuccess
>> +packet:          git< 0000
>=20
> (not sure if this was mentioned before)
> If a filter uses the delayed feature, I would read it as
> a response from the filter in the style:
> "Hallo Git, I need some time to process it, but as I have
> CPU capacity available, please send another blob,
> so I can chew them in parallel."
>=20
> Can we save one round trip ?
>=20
> packet:          git> command=3Dsmudge
> packet:          git> pathname=3Dpath/testfile.dat
> packet:          git> delay-id=3D1
> packet:          git> 0000
> packet:          git> CONTENT
> packet:          git> 0000
> packet:          git< status=3Ddelayed # this means: Git, please feed =
more
> packet:          git> 0000

Actually, this is how I implemented it first.

However, I didn't like that because we associate a
pathname with a delay-id. If the filter does not
delay the item then we associate a different
pathname with the same delay-id in the next request.=20
Therefore I think it is better to present the delay-id=20
*only* to the filter if the item is actually delayed.

I would be surprised if the extra round trip does impact
the performance in any meaningful way.


> # Git feeds the next blob.
> # This may be repeated some rounds.
> # (We may want to restrict the number of rounds for Git, see below)
> # After these some rounds, the filter needs to signal:
> # no more fresh blobs please, collect some data and I can free memory
> # and after that I am able to get a fresh blob.
> packet:          git> command=3Dsmudge
> packet:          git> pathname=3Dpath/testfile.dat
> packet:          git> delay-id=3D2
> packet:          git> 0000
> packet:          git> CONTENT
> packet:          git> 0000
> packet:          git< status=3DpleaseWait
> packet:          git> 0000
>=20
> # Now Git needs to ask for ready blobs.

We could do this but I think this would only complicate
the protocol. I expect the filter to spool results to the
disk or something.


>> +------------------------
>> +
>> +If the filter supports the "delay" capability then it must support =
the
>> +"list_available_blobs" command. If Git sends this command, then the
>> +filter is expected to return a list of "delay_ids" of blobs that are
>> +available. The list must be terminated with a flush packet followed
>> +by a "success" status that is also terminated with a flush packet. =
If
>> +no blobs for the delayed paths are available, yet, then the filter =
is
>> +expected to block the response until at least one blob becomes
>> +available. The filter can tell Git that it has no more delayed blobs
>> +by sending an empty list.
>> +------------------------
>> +packet:          git> command=3Dlist_available_blobs
>> +packet:          git> 0000
>> +packet:          git< 7
>=20
> Is the "7" the same as the "delay-id=3D1" from above?

Yes! Sorry, I will make this more clear in the next round.


> It may be easier to understand, even if it costs some bytes, to answer =
instead
> packet:          git< delay-id=3D1

Agreed!


> (And at this point, may I suggest to change "delay-id" into =
"request-id=3D1" ?

If there is no objection by another reviewer then I am happy to change =
it.


>> +packet:          git< 13
>=20
> Same question here: is this the delay-id ?

Yes.


>> +packet:          git< 0000
>> +packet:          git< status=3Dsuccess
>> +packet:          git< 0000
>> +------------------------
>> +
>> +After Git received the "delay_ids", it will request the =
corresponding
>> +blobs again. These requests contain a "delay-id" and an empty =
content
>> +section. The filter is expected to respond with the smudged content
>> +in the usual way as explained above.
>> +------------------------
>> +packet:          git> command=3Dsmudge
>> +packet:          git> pathname=3Dtest-delay10.a
>> +packet:          git> delay-id=3D0
>=20
> Minor question: Where does the "id=3D0" come from ?

That's the delay-id (aka request-id) that Git gave to the filter
on the first request (which was delayed).


>> +packet:          git> 0000
>> +packet:          git> 0000  # empty content!
>> +packet:          git< status=3Dsuccess
>> +packet:          git< 0000
>> +packet:          git< SMUDGED_CONTENT
>> +packet:          git< 0000
>> +packet:          git< 0000
>=20
> OK, good.
>=20
> The quest is: what happens next ?
>=20
> 2 things, kind of in parallel, but we need to prioritize and =
serialize:
> - Send the next blob
> - Fetch ready blobs
> - And of course: ask for more ready blobs.
> (it looks as if Peff and Jakub had useful comments already,
>  so I can stop here?)

I would like to keep the mechanism as follows:

1. sends all blobs to the filter
2. fetch blobs until we are done

@Taylor: Do you think that would be OK for LFS?


> In general, Git should not have a unlimited number of blobs =
outstanding,
> as memory constraints may apply.
> There may be a config variable for the number of outstanding blobs,
> (similar to the window size in other protocols) and a variable
> for the number of "send bytes in outstanding blobs"
> (similar to window size (again!) in e.g TCP)
>=20
> The number of outstanding blobs is may be less important, and it is =
more
> important to monitor the number of bytes we keep in memory in some =
way.
>=20
> Something like "we set a limit to 500K of out standng data", once we =
are
> above the limit, don't send any new blobs.

I don't expect the filter to keep everything in memory. If there is no =
memory
anymore then I expect the filter to spool to disk. This keeps the =
protocol simple.=20
If this turns out to be not sufficient then we could improve that later, =
too.


Thanks,
Lars=
