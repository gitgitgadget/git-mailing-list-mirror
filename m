Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B2E1F406
	for <e@80x24.org>; Thu, 14 Dec 2017 10:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdLNKnx (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 05:43:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48097 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbdLNKnw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 05:43:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20171214104350euoutp013ee0d7188bf33c826a8b4ceb8535aa0b~AIz9oErky1810218102euoutp01O;
        Thu, 14 Dec 2017 10:43:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20171214104350euoutp013ee0d7188bf33c826a8b4ceb8535aa0b~AIz9oErky1810218102euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1513248230;
        bh=BQjwU0hV9n+LMi4k1SHof74eJzRe/qpWOeOLgItFE98=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=lJ7oFh3n/6A6Nz8iJ7M4JpSJvqg9IIFVCrSR+fEJo38hm2qloyRq90k0WN/A72DvT
         N2qHbCTsoqCseF/6t7qz4f8vArdWPV7eP8Yx0qL/pfDDYuFcnCZmOd5zlZyLXsAZkq
         JqxhPaiBkcGUs0SaFKfwBrkboHlRQVsFxZL7WGEI=
Received: from eusmges3.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171214104349eucas1p1b9d4bcc5c1ed16121f903f61d260738f~AIz9A7Evp3269932699eucas1p1W;
        Thu, 14 Dec 2017 10:43:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3.samsung.com (EUCPMTA) with SMTP id 9C.56.12867.4E5523A5; Thu, 14
        Dec 2017 10:43:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171214104348eucas1p2921cdc8df00c90055927ec99eba3040a~AIz8NQ8OL2860828608eucas1p2B;
        Thu, 14 Dec 2017 10:43:48 +0000 (GMT)
X-AuditID: cbfec7f2-f793b6d000003243-64-5a3255e40eec
Received: from eusync2.samsung.com ( [203.254.199.212]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.2C.18832.4E5523A5; Thu, 14
        Dec 2017 10:43:48 +0000 (GMT)
Received: from localhost ([106.116.147.110]) by eusync2.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0P0Y00BKZ5T0PKB0@eusync2.samsung.com>; Thu, 14 Dec 2017 10:43:48
        +0000 (GMT)
From:   =?utf-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] git-gui: Prevent double UTF-8 conversion
Date:   Thu, 14 Dec 2017 11:43:38 +0100
In-reply-to: <CAPig+cTYYGRynG8r_2DR53u77eCFDGe1BEDcEK3_cJQxT3yncQ@mail.gmail.com>
Message-id: <87o9n16145.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-version: 1.0
Content-type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd2noUZRBt2XGC26rnQzWTT0XmG2
        6F/exWbxrvM2i8WZN42MDqweHz7GeVy8pOyx+IGXR9OpdlaPz5vkAlijuGxSUnMyy1KL9O0S
        uDI2fXnBWjCPv6L1u0ID43TeLkZODgkBE4ldT8+xQdhiEhfurQeyuTiEBJYySlzedZgdwvnM
        KNG9cgErTMftOWtYIRLLGCWmXGlkAkkICXxhlLj0hR/EZhOwl+g/so8FxBYR0Jb4sGETI4jN
        LLCKUeLmUSMQW1jAQeLagx6w1SwCqhJf3mwGqufg4BQIlth5KhQkzCtgLHH2bCsziC0qYClx
        r+8uG0RcUOLH5HssECNzJT41/Qc7VELgMpvE+7bNLBCHukg82DeTEcIWlnh1fAs7hC0j0dlx
        kAmioZ9R4vD871CJKYwSixc6QNjWEn9WTWSD2MAnMWnbdGaQ4yQEeCU62oQgSjwkVrb8hGp1
        lLg/8ScLJFCWMEpsu/qEfQKj7Cwkx85CcuwsoFHMApoS63fpQ4S1JZYtfM0MYdtKrFv3nmUB
        I+sqRpHU0uLc9NRiY73ixNzi0rx0veT83E2MwJRx+t/xTzsYv56wOsQowMGoxMO7QdcwSog1
        say4MvcQowrQmEcbVl9glGLJy89LVRLhVZsIlOZNSaysSi3Kjy8qzUktPsQozcGiJM5rG9UW
        KSSQnliSmp2aWpBaBJNl4uCUamCs37dOZm9XsXdQ8XtOblGPx27PWxjPVG7SNtTd9Mqr/p7n
        8f2JfB45ph4vj0xcGaV8q/GCA2ebnECxz8XU/F3nHvjGvtOM2/vowMV7SxgXbttSXrKp4H5p
        0oxplxe2Z045w/RiAX8eF6NJecqkAjvVd/FVGqqrJKxSPDzExJNNmqNyTqTW/VJiKc5INNRi
        LipOBADFqDEWIQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xK7pPQo2iDDrvyVp0XelmsmjovcJs
        0b+8i83iXedtFoszbxoZHVg9PnyM87h4Sdlj8QMvj6ZT7awenzfJBbBGcdmkpOZklqUW6dsl
        cGVs+vKCtWAef0Xrd4UGxum8XYycHBICJhK356xhhbDFJC7cW8/WxcjFISSwhFGi8cFHVgjn
        G6NE0+nbTCBVbAL2Ev1H9rGA2CIC2hIfNmxiBCliFljFKLHj70OwUcICDhLXHvSwgdhCAgES
        Pz/tZgaxWQRUJb682QzWzCkQLNF09y9YPa+AscTZs61gNaIClhL3+u6yQcQFJX5MvgdWzyyQ
        LXHh4huWCYz8s5CkZiFJzWLkALI1Jdbv0ocIa0ssW/iaGcK2lVi37j3LAkbWVYwiqaXFuem5
        xYZ6xYm5xaV56XrJ+bmbGIEBvu3Yz807GC9tDD7EKMDBqMTDu0HXMEqINbGsuDL3EKMK0JhH
        G1ZfYJRiycvPS1US4VWbCJTmTUmsrEotyo8vKs1JLT7EKM3BoiTO27tndaSQQHpiSWp2ampB
        ahFMlomDU6qBUUX79oEDJ22OTFuf//LvlFuP7O6VOFT68tjUrH2kqHlM1q5t9pFZ3F4ybnN1
        wiS8bK/yh7DEHLnTkugq+t6/9lRRWE+L/maFS4Zu5qsEKvZP4vi8927TxX8xT67IvOSOV3y1
        pXjZ/5oiZ0+3Ndv8LOJ2rPx6Zk7IhmTtoKQlV/U+PWXo31AhqcRSnJFoqMVcVJwIANCViPp4
        AgAA
X-CMS-MailID: 20171214104348eucas1p2921cdc8df00c90055927ec99eba3040a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171214104348eucas1p2921cdc8df00c90055927ec99eba3040a
X-RootMTR: 20171214104348eucas1p2921cdc8df00c90055927ec99eba3040a
References: <CAPig+cTYYGRynG8r_2DR53u77eCFDGe1BEDcEK3_cJQxT3yncQ@mail.gmail.com>
        <CGME20171214104348eucas1p2921cdc8df00c90055927ec99eba3040a@eucas1p2.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2017-12-14 czw 10:42>, when Eric Sunshine wrote:
> On Thu, Dec 14, 2017 at 4:32 AM, =C5=81ukasz Stelmach <l.stelmach@samsung=
.com> wrote:
>> Convert author's name and e-mail address from the UTF-8 (or any other)
>> encoding in load_last_commit function the same way commit message is
>> converted.
>>
>> Amending commits in git-gui without such conversion breaks UTF-8
>> strings. For example, "\305\201ukasz" (as written by git cat-file) becom=
es
>> "\303\205\302\201ukasz" in an amended commit.
>>
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> ---
>> Changes since v3:
>>
>> - Added Reviewed-by footer. Thank you Johannes Schindelin, for review.
>
> No need to re-send. If you consult Junio's latest "What's cooking"[1],
> you'll find that your patch has already graduated from his 'pu' branch
> to 'next' and is slated to graduate to 'master' (at some point).
>
> [1]: https://public-inbox.org/git/xmqqzi6mutcc.fsf@gitster.mtv.corp.googl=
e.com/

I am sorry. I didn't get any notifiaction by mail and I haven't studied
Documentation/SubmittingPatches throughly enough.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCAAGBQJaMlXbAAoJELCuHpyYpYAQd9YH/3z8XMDrPl8pRlA20CclUfcl
Md7Ige8jvirrw4oBu9g3veauOaac5lL2+FxDasxsB5dAhtLS6uD1H4vJot97pcFH
LDEU2qCeEDyYDgHfuEBtBHcI3vitudjD+B+zZlk2LoRlKJuWh714ufBwoMM/OZNf
22LADBq1UgrdDLE941pWm6MsmDz+G3tK+C5RIuu05oHPStmjCIiixL3I5m5gnt27
TgT+ZR6wLyqwu0EMuSGa47CGYiX7rv1BLNhliWDEuaTsYWn3nDE50MSQpmPgimGW
YF79SfuhQPDsiuiWNLbOCGePBtLNWN2VOUl/oLSvAKP73Op7gxhtWI/Sb3n41BM=
=yL5/
-----END PGP SIGNATURE-----
--=-=-=--
