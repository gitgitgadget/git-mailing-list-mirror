Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3582047F
	for <e@80x24.org>; Mon, 18 Sep 2017 22:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdIRWRN (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 18:17:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:50098 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbdIRWRM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 18:17:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbR3e-1dWbQz1GQc-00kzls; Tue, 19
 Sep 2017 00:16:39 +0200
Date:   Tue, 19 Sep 2017 00:16:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Gilles Van Assche <gilles.vanassche@st.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keccak Team <keccak@noekeon.org>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <59BFB95D.1030903@st.com>
Message-ID: <alpine.DEB.2.21.1.1709182340350.219280@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com> <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com> <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <59BFB95D.1030903@st.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-44118582-1505772999=:219280"
X-Provags-ID: V03:K0:YjE3Syy3v4cpVXV1TsXit4W6ZL9rhFGdmG4m99ctXMmhu3M+tYc
 fwPaV7Sgd4RN+8NQCy6lElUq0FtBDt0RpVEKQlVPhnVYCTGedeTKjABibqsfaes3ZhJ8Zxx
 TjHoI8W+MmmbosHlf3Y6wSOozOpLj1lf03wo75fH8+uxEuBT8mxtIOXxo/9TJPCmaV3Y0Vk
 vzVFLO2W/YjYPL4Lc5HOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MoMwL4Uq+iw=:cMxAs4zPMX5DQtiK8e3Hjo
 x7UoDVedHzDEw8rtvTULJa0U91KAuDPrVg6xn0b6L22bm6prZ59xXutddSeb2nb13oG/0E80L
 Ni8MXAOz8Rs1vZz3cqZAWeDbPIc9AsxQ3/kwlyIxerwrLe86oTv8yLGe+P/i4XEmIKem6lL3g
 02ZlVYaCWokngXN2d7cNUcRSs+9hTrXj09cgL8/6I2JJyu5bZZe75j6zt/oCMIBtfCS1Fp+RV
 fBYcwsf8EYNymuM7FtHBOrCpJTjQ2pkGTgpTqiciHvYXT6uE635OWCSkWhoTvtxvVj2xUluX9
 Md5LesbicFseE/aQLGyuTTdz+xmGYcBeG73hUnh929aCIS5SSGsmpfQxneAZfoNX3F5Cc8Flt
 eS/mnAWSHcZaducHtCGuMFnlSyKXTz5TG/grK5Xim3zTXZgt9bgqET2PlhwO3rR2/zPlalQjm
 aRyvBNkUxn8Ri1H6iWox0P9NhQGdsC4K3eqDSsq5iBzl+NDlkWH/2w4IYMrqfXMh7Mm4mstSQ
 w43GqaIQijU67LJoCyNo9cX5UGiJMkKVT6DKdD3633CpISnMW9gKXCmWOjZtNlybSsNjZ9+3y
 IF5jcqZtQxnUj159CiR1akrHm40XXCDL26EPAyU8cTyt+tWcsXQr6iVBVG9SNXr4wGZoec/TO
 0OMJeKdMAkYfOQcZ6idX962WYbee4a9WvCXucqKm+kojZpUGbTFUvVeB70JsGZj0IkaItbfj5
 05gp7px3ulvng95V4f5iEl0TL65gHciOja9IbKmrqk6JQ1fxe3Jau/W5uQKQmjjgdSleYpGuN
 x4l2+cv4Scknu/OuZ+wvhGUMALYW1YAfqyl04aZXWR4L1BOEkw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-44118582-1505772999=:219280
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Gilles,

On Mon, 18 Sep 2017, Gilles Van Assche wrote:

> > SHA-256 got much more cryptanalysis than SHA3-256 [=E2=80=A6].
>=20
> I do not think this is true.

Please read what I said again: SHA-256 got much more cryptanalysis than
SHA3-256.

I never said that SHA3-256 got little cryptanalysis. Personally, I think
that SHA3-256 got a ton more cryptanalysis than SHA-1, and that SHA-256
*still* got more cryptanalysis. But my opinion does not count, really.
However, the two experts I pestered with questions over questions left me
with that strong impression, and their opinion does count.

> Keccak/SHA-3 actually got (and is still getting) a lot of cryptanalysis,
> with papers published at renowned crypto conferences [1].
>=20
> Keccak/SHA-3 is recognized to have a significant safety margin. E.g.,
> one can cut the number of rounds in half (as in Keyak or KangarooTwelve)
> and still get a very strong function. I don't think we could say the
> same for SHA-256 or SHA-512=E2=80=A6

Again, I do not want to criticize SHA3/Keccak. Personally, I have a lot of
respect for Keccak.

I also have a lot of respect for everybody who scrutinized the SHA2 family
of algorithms.

I also respect the fact that there are more implementations of SHA-256,
and thanks to everybody seeming to demand SHA-256 checksums instead of
SHA-1 or MD5 for downloads, bugs in those implementations are probably
discovered relatively quickly, and I also cannot ignore the prospect of
hardware support for SHA-256.

In any case, having SHA3 as a fallback in case SHA-256 gets broken seems
like a very good safety net to me.

Ciao,
Johannes
--8323329-44118582-1505772999=:219280--
