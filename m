Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAFBC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 18:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C11060F11
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 18:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhI0SDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:03:00 -0400
Received: from mout.web.de ([212.227.17.12]:46347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235900AbhI0SDA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 14:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632765650;
        bh=wI07I2HX5Hehk4rcSgEoAIHz+3EwitWkHYed6hydJHk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NRdLrB5Me6RTRgyzjB9Th/CapiUPlv6y+GmG9beYjIJDUEyW51eQA2EWCgg5/n2pP
         DwgOtkmuysjEtP3DbtspIERT8VbLhPxz7kF78XoiVjVE2TfVHVEvjC58ky5FiJ6czp
         UbfhrQ/oXuCCiLJXZmNiNsEEWODibfR+K6IL0k5I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MVu1U-1mK2xO1zpo-00X77g; Mon, 27 Sep 2021 20:00:50 +0200
Subject: Re: [PATCH v2 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
 <patch-v2-8.8-7420267ce09-20210926T185800Z-avarab@gmail.com>
 <xmqqfstqq80j.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0e07cee4-079a-af12-880f-d4a99300df28@web.de>
Date:   Mon, 27 Sep 2021 20:00:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqfstqq80j.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CVFSB0JOqEZWcfNjrWe9d9JwYHWnAtuq6o6D5eU7QdgBNOTRK5D
 absKzEeEvbM1PwLUToh2qe0rlVWXcFWwb0ChAk1JOOBqSUOpc0zSn6Q7PHItZZ1N0PZwIcg
 dRnCbNgdNHDUl7k2Qhr1701EO5KaVsn6l+69T5/bvtF4I27gLc/bVefnoxXf2xx7Ss4dX3h
 7JhKsrdL1iZEODRs9VHWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rTM1IknzYOs=:GjDP6uaxhIn3rLpKgy86qi
 Jo1xzV7EvQP4jTNW5JEia6T91h5bbGETgR3joJndKlPI7kMUKIiY5dBhSh+TgfrRzdTX6DHLk
 2D1hRUMtTXo7seequYSNZ5meOilfvHt1H5Bs3eGBBqkISubQy6E81s956JwgSqrnX6mlTPzXM
 9lqmkKNx4Iq7Z7oT49yDl2CgEcFOGMHn7k1HgyqC20NyDR/HZNP3t+lLASa0mOecObveZSguH
 ks9lT3g+4T3JX3FUjWGxqmaxlUWGm50F0aMHub/kawHzD7305DnqlYTBDf3NCE13lwsmKpH7D
 BRNLOWlhahu6ye4Y/dacxkYaqgISGGw99PgfvEp+Jzugh/CLkC9KVQ8hBmBKxZDLY0RDVwTRl
 xHGkA8L4e62oZP924YOzmllZFmuviKRdG4EM7rcv3uvEkHzafMpkooRtJPA7xUCsLt8tp21zx
 Ry6e3x02/u44/lZ7nxsXsD+DH4cn9QBBJVcMdQkXdFJSGX0cekk/DaL8KxCEOGvZeBtXND+2A
 DrUBjY0ITiwPG5zOjuDpsbvch4d3zPK+I1nAYFXCyEKmNGAw5u/SD2G7/D3O2eF9CAtYydqz4
 ThuoJtsYSWxx2wEpDNfLbmt2uayqRb90cucSfAMj4wkBJu80SUSLyYycnbN0aVEVH5JUr/tZj
 KTXWGwNHECWB4r9Sno+o8okZEwvGk+GB2V3rqbM5cBGNByo9ujrdCua5f508MO3MCUCPQb2BN
 Sh6iHFoc7G7nNUZS+EIP8GN+FEUnRe+OwUBxfG+b3EjE4dXMkXaaBnYL9AbK2fpayKgkZz25m
 TDWcbXuqgnWW6q1RVAx4wRc/ulKfCOkNpIFh+bhUzxznmKCGQOFPHrYLrvDHX4oBHNojXW1WM
 7nHwiRBlmVNnLi9LfYf4llHn0WW9rZbrrU1bpy8ajzaZzRr5vNaShRGRybBKVrEKiO2hbYIje
 cNKypLyng8uTV7awF1Vh/gkSmEoDzenHqpEJCg2/PGFDIFK2fVFOZ3IFdGg/M3Os4Xdby24+V
 vSQCRl6Ic4or6enu1PIr8V9DYwtidwQr2MJrInVhowXlMEs4SavojeVFHCIbqvvXcA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.09.21 um 18:48 schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +sed -n \
>> +	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
>> +	-e 'x' \
>> +	<Documentation/githooks.txt |
>> +	LC_ALL=3DC sort
>
> Thanks.  It is not wrong per-se, but if you are willing to do a
> multi-line script for readability, wouldn't a much more readable
> "single long and multi-line string" approach, i.e.
>
>     sed -ne '
> 	/^~~~~*$/ {
> 		x
> 		s/^.*$/ "&",/
> 		p
> 	}
> 	x
>     ' Documentation/githooks.txt |
>     LC_ALL=3DC sort
>
> work better?
>

It is more readable, but according to OpenBSD's sed(1) manpage it would
also be non-portable (https://man.openbsd.org/sed#STANDARDS).  That note
was added in 2006 (https://github.com/openbsd/src/commit/24ce9718),
though, so perhaps it needs an update.

FWIW, generate-cmdlist.sh uses such a multi-line sed script in its
function get_synopsis.

Ren=C3=A9
