Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7F1F1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 11:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbeDCLnh (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 07:43:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:38897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755135AbeDCLnf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 07:43:35 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Luxaj-1eL5cm1uOv-0105vU; Tue, 03 Apr 2018 13:43:13 +0200
Date:   Tue, 3 Apr 2018 13:43:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
In-Reply-To: <87fu4hwgfa.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804031150030.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com> <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet> <87fu4hwgfa.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1941110784-1522752445=:5026"
Content-ID: <nycvar.QRO.7.76.6.1804031328440.5026@qfpub.tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K0:TyWxuF3mcZvr1kOECkpxkj/yFf4ZTQrMZr8WH77iT8acBUMTX9w
 F1hDWyc9HPhW27uceNqoQCzup1qU5ieI0KmEcEaiT3PSoCrixmddvyumdJOIrATUyvi9IQ+
 yTY5OoNGRR+kktEjpFn+pgROfo7Eb5KIN2PzDRv2X6B+sSWG+VICKX/w04QtZbC1CUxPC0t
 3VPpOtcioLDhcrKiAvong==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UJ9eZSUvSLw=:UIC4udT7beiL7O7Z5lN1G/
 Q4i1qGYdX6EZG+nzlVi8EioB4sSZfRjG50PaG3LgQlVa3Hz7HxDBM0UAGyOQCWaoL1cy9D0rQ
 xHYougH4+NUzwQ63BpULwqc3dtYOO2keEc5/G5hzL/8nm7Id89IvxgRbalLkahcDLnB4cXW/e
 IqWvkkBq2hygmXRQ7D9bGnjG5ncV+vTUJFfhG8IYVOVybIXgKiXTvs53dU1byI+nf4db2NARl
 SramlXVX8gFxSfv0MSujvl8YERFUESye9/R4Wy1x8t45OqMG3CCIfqoDsO/F9EZ7NdHV5varV
 ntSu+YhQ1F0Hso8+oyakqmOef8bLaLiHQcOIHppkOPFLzLhu3GKbZqMJbBLO+mBs1WK7cRDCk
 c9A1S7WzEXEFjWWpMsFKxyPQhzKZSRrLiD2LRThYxi9HP+OoGyvikaOgBHXEpIlDhJRb741N7
 C47pevpF2lvGRXxeMNYS68L1gHZxf71tvc7lJXzJDb6t24aHTxjzj8EJCL6Gv6Y9kXMZvT4Hp
 nE+NpQjQzFmC/nipJ15JWVqQAyXzPJvGNiK/7Qi/IeUj6Xdp1fme5+TQBffn0Tc/PXhxw7VKc
 fy2TI/Q9vtXOS7JziDGpHsv10JfcnEok5BYdD/0gJbgIk+FH451rsNeljOnbZtVq6RMZEycy9
 c+QwMgBWsmFgXhVjXm6emmyTkj3xvA6MYzkiDiLTdZioxequzIHGzk3N0V76fxZ4yFAKGWn5i
 GJHUmV8ni6prn2znRL1NZj/ah5yYA+U9g65DuDjzsl8WXeWbk3BRariY1nSF3YiZ8ubUcSx3h
 chz5cHqmzos9k3mrGz1WIBz3T30FGPNZ2mY1guHWFI0kUrxLSraJrBqLCBYGvfIuhJkcIiV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1941110784-1522752445=:5026
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <nycvar.QRO.7.76.6.1804031328441.5026@qfpub.tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Fri, 30 Mar 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Mar 30 2018, Johannes Schindelin wrote [expressing frustrations
> about Windows test suite slowness]:

To be precise (and I think it is important to be precise here): it is not
the Windows test suite about which I talked, it is Git's test suite, as
run on Windows. It might sound like a small difference, but it is not: the
fault really lies with Git because it wants to be a portable software.

> I've wondered for a while whether it wouldn't be a viable approach to
> make something like an interpreter for our test suite to get around this
> problem, i.e. much of it's very repetitive and just using a few shell
> functions we've defined, what if we had C equivalents of those?

There has even been an attempt to do this by Linus Torvalds himself:

https://public-inbox.org/git/Pine.LNX.4.64.0602232229340.3771@g5.osdl.org/

It has not really gone anywhere...

To be honest, I had a different idea (because I do not really want to
maintain yet another piece of software): BusyBox. The source code is clean
enough, and it should, in theory, allow us to go really fast.

> Duy had a WIP patch set a while ago to add C test suite support, but I
> thought what if we turn that inside-out, and instead have a shell
> interpreter that knows about the likes of test_cmp, and executes them
> directly?

The problem, of course, is: if you add Git-test-suite-specific stuff to
any Unix shell, you are going to have to maintain this fork, and all of a
sudden it has become a lot harder to develop Git, and to port it.

Quite frankly, I would rather go with Duy's original approach, or a
variation thereof, as snuck into the wildmatch discussion here:

=09https://public-inbox.org/git/20180110090724.GA2893@ash/

> Here's proof of concept as a patch to the dash shell:
>=20
>     u dash (debian/master=3D) $ git diff
>     diff --git a/src/builtins.def.in b/src/builtins.def.in
>     index 4441fe4..b214a17 100644
>     --- a/src/builtins.def.in
>     +++ b/src/builtins.def.in
>     @@ -92,3 +92,4 @@ ulimitcmd     ulimit
>      #endif
>      testcmd                test [
>      killcmd                -u kill
>     +testcmpcmd     test_cmp
>     diff --git a/src/jobs.c b/src/jobs.c
>     index c2c2332..905563f 100644
>     --- a/src/jobs.c
>     +++ b/src/jobs.c
>     @@ -1502,3 +1502,12 @@ getstatus(struct job *job) {
>                     jobno(job), job->nprocs, status, retval));
>             return retval;
>      }
>     +
>     +#include <stdio.h>
>     +int
>     +testcmpcmd(argc, argv)
>     +       int argc;
>     +       char **argv;
>     +{
>     +       fprintf(stderr, "Got %d arguments\n", argc);
>     +}
>=20
> I just added that to jobs.c because it was easiest, then test_cmp
> becomes a builtin:
>=20
>     u dash (debian/master=3D) $ src/dash -c 'type test_cmp'
>     test_cmp is a shell builtin
>     u dash (debian/master=3D) $ src/dash -c 'echo foo && test_cmp 1 2 3'
>     foo
>     Got 4 arguments
>=20
> I.e. it's really easy to add new built in commands to the dash shell
> (and probably other shells, but dash is really small & fast).
>=20
> We could carry some patch like that to dash, and also patch it so
> test-lib.sh could know that that was our own custom shell, and we'd then
> skip defining functions like test_cmp, and instead use that new builtin.

Or even use the output of `type test_cmp` as a tell-tale.

> Similarly, it could then be linked to our own binaries, and the
> test-tool would be a builtin that would appropriately dispatch, and we
> could even eventually make "git" a shell builtin.
>=20
> I don't have time or interest to work on this now, but thought it was
> interesting to share. This assumes that something in shellscript like:
>=20
>     while echo foo; do echo bar; done
>=20
> Is no slower on Windows than *nix, since it's purely using built-ins, as
> opposed to something that would shell out.

It is still interpreting stuff. And it still goes through the POSIX
emulation layer.

I did see reports on the Git for Windows bug tracker that gave me the
impression that such loops in Unix shell scripts may not, in fact, be as
performant in MSYS2's Bash as you would like to believe:

https://github.com/git-for-windows/git/issues/1533#issuecomment-372025449

Ciao,
Dscho
--8323328-1941110784-1522752445=:5026--
