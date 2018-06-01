Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C829F1F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 08:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbeFAIPv (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 04:15:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:48343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbeFAIPs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 04:15:48 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0La2Xx-1g9s4h2xqv-00lobX; Fri, 01
 Jun 2018 10:15:26 +0200
Date:   Fri, 1 Jun 2018 10:15:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=98yvind_R=C3=B8nningstad?= <ronningstad@gmail.com>
cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>, git <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <CAA8fPEkNjy+ETz4Mx+C2kUfLjLzR9uuOmO3GfN48ZH1SwyfE1A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806011013340.82@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com> <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet> <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com> <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet> <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com>
 <CAGZ79kZbRCH2OiTW1Ge31R9JN+vWD6tcjNWVGSzkSBcYZvwDjw@mail.gmail.com> <20180508034429.GA7242@sigill.intra.peff.net> <87in7f9aym.fsf@evledraar.gmail.com> <CAGZ79kZg-24OtWp-qk4gAyU3O8vJBdDH_maTERqzqHSE86_fqg@mail.gmail.com>
 <CAA8fPEkNjy+ETz4Mx+C2kUfLjLzR9uuOmO3GfN48ZH1SwyfE1A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1838849697-1527840928=:82"
X-Provags-ID: V03:K1:ACqZyznsJpLaPsWH9lU8xf5NZoAqQUquh5RGwd7eJfkhkbNUoVZ
 w89JUxWVfI5MmoeeHdzlKtvfeRARSVBssJ2m5kgeDxXnMWdojO/cE+3N894+OvHmptsp5wJ
 yr2S8nAiLnZk9QsQgBdchUF0xk8n4NUqfo/Tfe0lykgaszQq5pVpTtKqL6mBacx210XlNW3
 x7QnAZYsAPi4Ue2XCGf4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KmcbGFMg+OU=:5tbyjuEN7gTjlXizGeVqjc
 cloG0BAk+aBc2R4uwvQPIu0+9iHbw7Zu94bOI+DeFk7QYyr2p2iPUKayeVbXyOd0YROwmi5S7
 pdakIkbvNi96vrFi0Pgmh87w7UZiOb7SebTcEVjg/tnhxT3y2Fz23bKKXrBr1QwMLl7VKNiXZ
 H3147/IwGWXx4LhcGllbxhx6/1Cb9wycQd6fnHLNAX1+oCGEDjJwrsFtMwag6Qn3jQoxtiPUb
 X330u9Acvr24t3kjl1i5UNuUyC9RlTLCtyarPX1tXrctYXd9M05Vnf8BGx5Z9QChHuGjaT8Sa
 aSAFTjCgjE7cKQDX2BIMjXxBJPgLNrnHA53WujoqN9T5EGR7x0kJky2OlzLr5j9+lwByFzrtF
 thLD8pllPdWeEQvfqV21HQYQGxqsrUm6zwhKwNgqtc20XVqB42YRmGbAOIGslhWlLkNkr9Obs
 mFiCD9QAoz/RY64NZjPNVGQORodUjjgd+02rIrRldRkuiPtJoe5fCJDKoILWxvdM9QVvopjO4
 7RBfv2soxwlvdUsh99V2ZBkY2tsU29Dw/LlXackW3nYi1j7PHFd713Qk4xF7A0JuGbbwFvIV9
 yFifW3n9d14BCu3QlYDmbrGrQA9BqrQU7ptJM+E7ZD7jQ6c4CZ8Sn3xQD3KWbOqiQsfXn5+6c
 Zn0fefhdtyLLh8QGNaL7I82VnETqd4EIIFTyd13oBoK9T0d50ccMeB+7Lh4RNhg8JHEeyRDmr
 lZdQ77WhJXjDNqBbpp/eMIXZ2PMo8bGIMf5BhnvYcSjE8PuG2MMZtIG/xYubTX0FLSPxB8VcK
 IP916Dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1838849697-1527840928=:82
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi team,

especially Stefan: your thorough investigation about a better name than
range-diff gives me confidence that my decision to retract my objection
against has merit: it seems to be by far the one name that everybody but
me agrees on. And I can adapt easily.

On Sat, 26 May 2018, =C3=98yvind R=C3=B8nningstad wrote:

> Just want to throw my support in for range-diff since ranges is what you
> pass to the command.

`range-diff` it is.

Ciao,
Dscho
--8323328-1838849697-1527840928=:82--
