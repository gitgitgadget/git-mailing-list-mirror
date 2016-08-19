Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D081F859
	for <e@80x24.org>; Fri, 19 Aug 2016 12:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbcHSMhv (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 08:37:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:62050 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750889AbcHSMhv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 08:37:51 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M39zL-1bHXg73HEt-00sspI; Fri, 19 Aug 2016 14:37:44
 +0200
Date:   Fri, 19 Aug 2016 14:37:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
In-Reply-To: <20160818154908.GB17141@tb-raspi>
Message-ID: <alpine.DEB.2.20.1608191426470.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de> <20160818154908.GB17141@tb-raspi>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2043465594-1471610264=:4924"
X-Provags-ID: V03:K0:1bBMi7lLBXvL9W5CXrfdTR9CK6jtE30E3T3WSC3LqH7msRW7GnK
 FnUTBQhHsK9VOtRe3vCpos4QSCrekKOnbvbT3V6pneI708aQMdgMHPWvRwM3JPD7tfOSwZq
 PiTej4v4ywu2zfZBBZ7O3yegbKyVS75FZP3w2nbcEifeFlJIT9dtZKJQQtGjQrwif9/iq8X
 Lej+nafezKhH2lTnMy/2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:amCwRuexmBM=:x0KahS23u5WI/mmx8RhfnJ
 mfctdYDIsAPoAsf1Ca+ZRUztNYTxdHEQ6uADVrI2doC1KM5rVJkdV8pOjLNG9T8KWb73guFou
 pQcJAOq2DBzMoPRJO02mfmb74MTw8y0nopslNU6wj0fDloHqQWAgbSQVQycMPvXshYC2P8vTK
 II8hYIWaRFQtHcCiQ8PD5I+lLaftXKsKxYSs69Us3BIfW7KHq2MMX7iTXrO7gMVr3M1oqSqSZ
 2tSwnRhw6r9o7NXm5fEFTugH1HwQSrbWcdTXCMfvm8XT77Q+YR8mbMlN11W+OzNBT0+gAeBvQ
 HwQq425KS/BMW/HKnTAMkjwJLr/J0ufCr5X6HjmZK7ul6eulDbmWGgYf4c18PLmbptyIYTr2b
 y/r/P/elNA6cyWhP+gIiqSQY6VsXaoZC283HfAQ6jqHmM7/lEVuI2u1MISFFuBCiWHdFhK1YK
 51nNJZPtD4c+BeAq503GQr0wXOcrCe4RpB0LA0ekSCLib82qsRB4iAvo0HXu+RtIPTQAth3J6
 7pq+4RBLqVOFXMhbR2XUIVn3s85ng7W9npnT2shkDgXR9dBQ90mD4AwM7pV9VV4DS0iXjGAAb
 vZCgfA3wdNcLIpMQE/aqllw4s+5PQvPu5s9xNwr1Q0RH4th2cZh4v3e/zfbV6/7B/HkzNdUcZ
 Ao9XhtuVYjJq4+wXuitA5zrNyKe5qbjKFGgbpl4lilKw3g/pjLgyh7UAJHF1swB1cMhDLxoLn
 IeOXv0B2gW6db4b6C5f+vNLgxTo6g+11IBb4b3dKB+Lj6002kQPA8jG7jBXdPke51URQM4CzX
 lvln4fk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2043465594-1471610264=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Thu, 18 Aug 2016, Torsten B=C3=B6gershausen wrote:

> On Thu, Aug 18, 2016 at 02:46:17PM +0200, Johannes Schindelin wrote:
> > As suggested by its name, the --filters option applies the filters
>=20
> []
> > diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
>
> Does it make sense to integrate tests into t1006-cat-file ?

t1006 is already a 500+ line script, running 110 cases in 13 seconds over
here. I really rather have a new, small, concise and parallelizable
script.

> > +test_expect_success 'no filters with `git show`' '
> > +=09git show HEAD:world.txt >actual &&
>
> I would prefer to have something using
>   cat >expect <<-\EOF &&
>   xxx
>   test_cmp expect actual
> to make it easier to debug in case of a failure ?

Actually, I find it much harder to debug these "the output must match
these precise bytes, else we fail" type of test cases. Instead, I describe
in a natural way what is expected:

=09! has_cr actual

Now, when the test fails, whoever is that poor soul tasked with debugging
and fixing the breakage knows *what* goes wrong, conceptually.

So I do not think it would be a good idea to change the test in the way
you requested.

And now I have a request of my own. When you quote parts of my mail, you
insert your answers without surrounding them by empty lines. That makes it
extraordinarily hard for me to read your mails (in fact, I almost missed
your second comment).

Could you please start surrounding your replies by empty lines?

Thank you,
Dscho
--8323329-2043465594-1471610264=:4924--
