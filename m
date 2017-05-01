Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56BA01F790
	for <e@80x24.org>; Mon,  1 May 2017 10:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969233AbdEAK73 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 06:59:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:54094 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969229AbdEAK71 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 06:59:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAxyW-1dCsHw0CSi-009vUI; Mon, 01
 May 2017 12:59:16 +0200
Date:   Mon, 1 May 2017 12:59:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t7400: add BSLASHPSPEC prerequisite to 'add with \\ in
 path'
In-Reply-To: <4f88f1ec-eedc-1249-ef12-238a73d1dc7a@ramsayjones.plus.com>
Message-ID: <alpine.DEB.2.20.1705011221480.3480@virtualbox>
References: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com> <xmqqk265kz2v.fsf@gitster.mtv.corp.google.com> <7cd09c17-30a1-b157-2454-4c9b399a8628@kdbg.org> <a575542a-e5b6-389f-e240-d5ac5a4b4107@ramsayjones.plus.com> <f9dfd9b4-e753-1a53-175e-8f20fe904501@kdbg.org>
 <alpine.DEB.2.20.1704291232410.3480@virtualbox> <4f88f1ec-eedc-1249-ef12-238a73d1dc7a@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TxasvlatYBwkVnBja4ThbqQXGI+uF/XzDOUTSI8HYE6KOcT1Tso
 EU64v4ststJP+6LMdQCHX97QPxa5dsO4ZUCkjm6L6hxXMMGPaIGly2v7WbodHBblBalTW3Q
 AB84ev+zcOPtwScCwNjcwOye2g2X2tN0IkBAcPQTnAJvWKEuUkUNKEZwFzNLz+2JOiGB6NV
 GVU1HELOo0NJ/oyTvQBVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c9B0/i5owNU=:B4QlJndsbXefxo01l05NcD
 kr+wJhGTzwDLI+ocmxcrj+3Eh/hEQWY8V2dmejTAVEZRaVmwTag/2i8xi0/G+RPy1F6JXRCfD
 2UmDCdyDoK6vLjlWOlA50SJ1qWTtbgNZphOaUloZPOvN49d2x8R86drPQus8O+6COzJ3KNdXx
 tt64UDDs2xC/PDABYSJnXiRkvqzZpWJqo0FBVhQA3UREvUQ+OdoH0OCUN9mNeOl4mhGxE/Fgv
 gqIL7ThNq/Hyw7Qi6HBN+fgz0gRlGUW3qhJO7hgjyg1BXIiAPieCbJk2nRukU3fnO0PNa8+ao
 qPyUCVD3xch0GraVUGa1fbCr4EhnwufzwINH5IDizNxLuYMXFM8tzVJaOQYnTRVySZLXICKHg
 rwSO6/pbOTLZZv9uIGxLCjrQPsKQKCrtCUopwtoIcsd3x7rDuthOmdEjn5SfwXQ7FnUbWGi0n
 3Z2UwGfx86++jph/42neiUU5PsQ5p4fT6VajKPSigCuLzk/KT/RxbDCFbtgY2J4EMn4Ktw66B
 oXzTNJa7UNeGuFkFAQXqKcQ8/jX1sCuUHswEUgjjiN8tgWoXvt5qSCtjbpwIOoCMi2JzDWW3k
 4lKzcsokeGzDjhWaAd0d9+KGeAaYFXiERmrIlZPxkMfHjLz/PYiWXQAdVaxts/YGLM84p9POZ
 y3yoWcAzwVMyUoG1vHrDXhx+En1FMqa8Fhmo+qeHHotmvO81zCXyXH1+FZTolNF9fCd+/uKbV
 o42qY8LZA2xyghqEegi8IQ8xQBat9Qz7gzztbHAljdT7kWOsNlgUU6x07qt4qk+iLvDwjnH5B
 reaFPtu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,


On Sun, 30 Apr 2017, Ramsay Jones wrote:

> On 29/04/17 11:44, Johannes Schindelin wrote:
> 
> > On Sat, 29 Apr 2017, Johannes Sixt wrote:
> >> Am 29.04.2017 um 02:15 schrieb Ramsay Jones:
> >>> On 28/04/17 20:54, Johannes Sixt wrote:
> >>>> Am 28.04.2017 um 05:09 schrieb Junio C Hamano:
> >>>>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> >> I don't observe these failures. Are you using a vanila MSYS2
> >> environment?
> > 
> > Please note that the "vanilla MSYS2 environment" is *not* expected to
> > pass the test suite when compiling in MINGW mode. In fact, it is
> > expected to fail.
> > 
> > In 2015, I made a couple of changes to the MSYS2 runtime in
> > preparation for the big bump to Git for Windows 2.x (which switched
> > from the old MSys environment to the new MSYS2 environment), and
> > released Git for Windows 2.5.0 with a heavily patched msys-2.0.dll. My
> > hope was that those changes would be welcome in the MSYS2 project, but
> > well, they kinda weren't. So I was forced to abandon my original plan
> > to contribute all of those fixes to "upstream MSYS2".
> 
> Oh WOW. I didn't know you were maintaining your own version of
> the MSYS2 runtime. That must be a huge PITA. :-D

I manage. The long years of maintaining Git for Windows as a fork of Git
helps. I use the exact same strategy: merging rebases.

Amazingly, the Cygwin project itself has been quite open to accept my
patches, and the only problem there is time: I would like to contribute
more patches there, I get really valuable feedback, and I just need to
find the time to iterate the patches so they can be accepted.

> > I even started collecting the exact tests that are failing with the
> > vanilla MSYS2 runtime vs Git for Windows' fork, when I still had hopes
> > that we could test things with AppVeyor (but the builds were already
> > too slow, we hit the timeout even before trying to run the tests, so I
> > gave up on that front):
> > 
> > 	REM MSYS2's runtime does not carry Git for Windows' tweaks yet, so these
> > 	tests cannot pass:
> > 	set GIT_SKIP_TESTS='t0003 t0006 t0024 t1100 t1400 t1402 t1501 t1504 t1506
> > 	t1508 t1513 t3001 t3070 t3200 t3301 t3400 t3404 t3513 t3703 t4116 t4150
> > 	t4208 t4211 t5000 t5001 t5002 t5004 t5500 t5601 t5602 t5603 t5801 t6006
> > 	t6018 t6041 t6130 t6132 t6300 t7201 t7400 t7501 t7502 t8002 t8006 t9001
> > 	t9350 t9700 t9903'
> 
> I have only (fairly) recently installed MSYS2, so I've only ever
> run the MinGW64 test-suite once, which for me failed on tests:
> 
>    t0003, t0006, t0026, t0060, t0200, t0204, t1100, t1400, t1402,
>    t1501, t1504, t1506, t1508, t1513, t3001, t3070, t3200, t3301,
>    t3400, t3404, t3406, t3703, t3903, t3905, t4208, t4211, t5000,
>    t5500, t5516, t5601, t5602, t5603, t5615, t5801, t6006, t6018,
>    t6030, t6038, t6130, t6132, t6300, t7201, t7400, t7401, t7406,
>    t7501, t7610, t9001, t9020, t9350, t9700, t9903
> 
> (which I found somewhat intimidating!).

Yes, I expected the number to rise. Note that almost every patch in Git
for Windows' fork fixes a couple of test scripts at a time.

> So, as you would expect, it hasn't improved much! :-P
> 
> Hmm, I was hoping to use this installation to test some git patches
> on MinGW, but that looks like a lost cause. I may as well save some
> disk space and delete it!

Hopefully I (or other Git for Windows contributors) will have some time to
make installing a Git for Windows development environment as easy as

	git clone --depth 1 https://github.com/git-for-windows/git-skd-64

Then you do not even need to worry to keep a local installation
up-to-date. You'd just reclone when (if) needed.

Ciao,
Dscho
