Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178A21F406
	for <e@80x24.org>; Sat,  6 Jan 2018 20:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeAFUqf (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 15:46:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:64568 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbeAFUqe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 15:46:34 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeMOx-1eFYdQ0B0p-00Q8vg; Sat, 06
 Jan 2018 21:46:27 +0100
Date:   Sat, 6 Jan 2018 21:46:26 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
In-Reply-To: <87mv1raz9p.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801062116350.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <87mv1raz9p.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-369163640-1515271587=:1337"
X-Provags-ID: V03:K0:he/CLBbO9T0abqDd7yGmlPVP6PzY5r4mjhwxseFVX2g3PRbLzjl
 z9QNO7yNGdvTjsIEgRNuFI5FlxvsA+w2Ex5diaorAcuZjobDRM/lEfBCpxhjL64Xr1UREVp
 wXsdQ3rJWSqGtve2o9fLwbZD9ZEwuhauiAJnE6wXHFv3SdHLP3Rt2IC26JLGuAFbfsphKef
 AWVxX1OHpAc42RIW6LNXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8IrrZecdXDU=:kzm0mh+un/I0uz2E5hfbeb
 MAUS1tPY7nty1XSqzhm0IBlJ/zUAcdPGi6x/z2ihlgIN0uwdKko+jeCEkUTVF5XlALJg1iz1S
 l7eczUWMzrlJNR8RQA8e102zDUkrZpJ+oJ7KOt+lUFVW27rQOs5Ebh+zY0RzRDIkMHlDU+2tt
 orpzGYAZX64LqVXzWm+DS0iMa+VjwO31+Ps6glUHhM7INfkwsqujIHtKJ+bXrdjkwPQ63yzye
 UTD+UKXr2XdOnXCW+NWOPe0TyOgV6Te0YfsqCz3Hvy5TpEqfMoWx4e56IdsSgreZyAqIWRT40
 DpTWOzp2709D/DcECztSqOondv3oLWg552rRNUECw4AJnIcws5x3i79NwYk2DIjghrLWJ7Q9v
 xZO+0Sswooy9CqMlyxK2XJrzHKJRrq1x4KxdI28oWQCxf4px76Zvo3XY5/OQ92mFl1HpsO4A6
 +sR7RlyhH6iKTuWa8XcNGAIscq1YFDlyG3PWm3/DBTIV7P9u8cbKZLkMaFYpiPhpoftLZwEyx
 pf9dSvCWRJS6pnRn+MyUgtiX8RQtIuh53p2gC7eel5VaxODxlpyOzJkNHSHLaWX/8Kgqg3B+3
 b/GHLkq5+PCIHXwc3t0vneVyy3t9dzJHrcjjL55IgbzM72iO62fUJAi01uQl8DiZ6PXL2TOvt
 GNYBdOqXtD0P5iipwcbdqWTX7BBajp3JuL6T8QtF0Nz7Y9sta1t5ghKp9np5A28V+2YrXGfOH
 3fcNfQJWnz+M4vAKFSzpg1AE4hZ59x4VPUw4BgrvWVuL4XuJdYHF7iOrweVxdRcCaVrnZ5GJg
 8CRXum9/Hke/UVhsT+e6XeYAXFY4Q+Z/rBPlk+90V9A40ZZdK7pU9JdICzes76WGO+eKNFl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-369163640-1515271587=:1337
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Sat, 6 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> As I explained in 20180105221222.28867-1-avarab@gmail.com the actual
> benefit of this test is that as much as possible is tested
> *somewhere*.

And what I am trying to get across is that your tests are excessive. I do
not see the benefit in running such an excessive, overzealous test.

You say that Linux will not overnight stop supporting colons in filenames,
which kind of misses the point that the question is more about new
platforms needing Git support with a *filesystem* that simply does not
meet one of your many tests' expectations.

But what is equally true is that few changes are to be expected in the
wildmatch code. And you know as well as I that it is possible to come up
with a careful, small set of test cases that will most likely identify
breakages.

After all, when there is a bug in some patch to the wildmatch machinery,
you do not need 512 test cases to fail. A single failing test case is
definitely enough.

I'll test the branch you indicated on Monday, just because you put effort
into it.

But please note that it does not change the fact that an effective test
suite requires a balance between the need to run fast (if *every* aspect
of Git was tested as extensively as your current t3070, even on Linux it
would take hours and hours to finish the test suite, making it stupidly
expensive for everybody to run) and the need to catch regressions.

It is a well-established rule in effective DevOps that you want lean test
suites. Actionable test suites. It is enough for *one* test to fail. When
a test fails, it should be as easy to understand as possible what is going
wrong. If there are no regressions, the test suite should be passing
*fast*.

On Windows, it takes 70-90 minutes *on a fast* machine. That is a huge
failure on our part: this is the test suite we designed "to be portable".
All I am trying to do here is to prevent even more damage. I will
appreciate any assistance to that end. I understand that most developers
on this list simply don't care. And that's just too bad, because we could
do a lot better. And we should, too.

Ciao,
Johannes
--8323328-369163640-1515271587=:1337--
