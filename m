Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC41200B9
	for <e@80x24.org>; Sat,  5 May 2018 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeEETlg (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 15:41:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:45545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbeEETlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 15:41:36 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LZmd6-1eTuzj2EMm-00lR1a; Sat, 05
 May 2018 21:41:27 +0200
Date:   Sat, 5 May 2018 21:41:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <019cce70-c109-496e-e043-c471dcb21e00@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1805052130360.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet>
 <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet> <019cce70-c109-496e-e043-c471dcb21e00@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MylsZhOde7n+iPzdHvIH+ZObZAIajMIPAWvhAPGeASHruHLEDpS
 YsLBRbSJcidj4vbyZ2GI3xJHBqdYNBiE54JIlBNCqPJURrpgVMESACnF4rNNtnGlUmr/OVg
 acjq9UTTn+s08rqD6ei2PYZ5qkvc1+bsEIMn7U1mXoC+T0UpD7QForFcjpdZg36U7B5SiPd
 0rW5Q3trnn9qKZ9sTjo5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HEDnmyUZ/HM=:yMj/0WaLwt/+40WkBvkhtc
 gXuwVmuEXpr2z1BGHHait3JVCxRoSc15HITTXrTI13tAaC11eHdTKnX+F4Ph4SPRPPvMa7X0n
 jOu4ZROJWKjgI3HdA4QcqniO18708H9wzvUPUdRL8BdOVMJXya01vZGQqz9hILWSMJkMBxvma
 wR7Aac6xoHstbpPv6JlPTuDmdrPdJIi5JyySi0gbCO+176qbpKV6WiOm52ebWKK32DN/HjcmT
 HZLcU+lglqSstSJFom3kaM3vEOcFO49o9jUVO1isPu1OTJJGKHVkGnNTeDdrjmPP/FTVBiEm7
 Fcfy+i20KVLOZZ4p84pLQzjGklNMbFE8tgfSDton+ZAw7J+RPNR/XMhPAldyLJLysGq5Khglo
 pglOW3HTSpLUrEqFQHoxh9ijdo0GGqETGeFq1X/xQl5QI2dPApww7IyCatxB6Kozf+vXUv/NV
 9qQXlHRmESIaeohrUv/YGG997PeEoz6vT9URtWXZqE1TdC2Nf7ip+Q5x4OPGkY+Q57D3lcgh7
 I3t8eNeSLVzXm1cbjmop1YMPXso0p0JsqPjJzYDpK0eFalBrwawXxbkoiU2aUhn+rHUxHojS9
 SRMAj4A80yPyr8ATbXBrWK/xq+5IG7EEzkEdnBHO9ZAhMpDeNShh6IR4LDTpzjvslU1/ED3Sa
 JtTuaY6fzTM1r4hEDNPBv8uDkpfdRPu8g1jTXkdqJWDkem2i4dHbdyazihS7JRD1R0nQe80R6
 /duOci3twEiPDYIydALK5ZiZC+CVS95TkLxdIvI98Vc1nPChU3MZVvGtqhauSA8hmtRbqde4r
 ms0yTB5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Fri, 4 May 2018, Ramsay Jones wrote:

> On 04/05/18 07:40, Johannes Schindelin wrote:
> [snip] 
> > BTW I ran `make sparse` for the first time, and it spits out tons of
> > stuff. And I notice that they are all non-fatal warnings, but so were the
> > ones you pointed out above. This is a bit sad, as I would *love* to
> > install a VSTS build job to run `make sparse` automatically. Examples of
> > warnings *after* applying your patch:
> > 
> > connect.c:481:40: warning: incorrect type in argument 2 (invalid types)
> > connect.c:481:40:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
> > connect.c:481:40:    got struct sockaddr *ai_addr
> > 
> > or
> > 
> > pack-revindex.c:65:23: warning: memset with byte count of 262144
> > 
> > What gives?
> 
> My stock answer, until recently, was that you are using a very
> old version of sparse.

Sure. I did this in an Ubuntu 16.04 LTS VM, via `sudo apt-get install
sparse`.

> Which is probably still true here - but I recently noticed that more
> up-to-date platforms/gcc versions also have many problems. (The main
> sparse contributors tend to stick with conservative distros and/or don't
> use sparse on any software that uses system headers - thus they tend not
> to notice the problems caused by new gcc/glibc versions! ;-) )
> 
> Since I am on Linux Mint 18.3 (based on the last Ubuntu LTS) and build
> sparse from source, the current 'master', 'next' and 'pu' branches are
> all 'sparse-clean' for me. (On cygwin, which is built with NO_REGEX, I
> have a single sparse warning).
> 
> I was just about to say that, unusually for me, I was using a sparse
> built from a release tag, but then remembered that I have some
> additional patches which fixes a problem on fedora 27!  Using sparse on
> fedora 27 is otherwise useless. (There are still many warnings spewed on
> f27 - but they are caused by incorrect system headers :( ).
> 
> The current release of sparse is v0.5.2, which probably hasn't been
> included in any distro yet (I think the previous release v0.5.1, which
> should also work for you, is in Debian unstable).  If you wanted to try
> building a more up-to-date sparse, the repo is at:
> git://git.kernel.org/pub/scm/devel/sparse/sparse.git.

Well, what I would want to do is let the cloud work for me. By adding an
automated build to my Visual Studio Team Services (VSTS) account, of
course, as I have "cloud privilege" (i.e. I work in the organization
providing the service, so I get to play with all of it for free).

So I really don't want to build sparse every time a new revision needs to
be tested (whether that be from one of my branches, an internal PR for
pre-review of patches to be sent to the mailing list, or maybe even `pu`
or the personalized branches on https://github.com/gitster/git).

I really would need a ready-to-install sparse, preferably as light-weight
as possible (by not requiring any dependencies outside what is available
in VSTS' hosted Linux build agents.

Maybe there is a specific apt source for sparse?

> Linux Mint 19, which will be released in about a month, will be
> using the Ubuntu 18.04 LTS as a base, so I guess it is possible
> that I will need to debug sparse again ...

:-)

> BTW, I spent some time last night playing with 'git-branch-diff'.

Great!

> First of all - Good Job! This tool will be very useful (thanks
> also go to Thomas, of course).

Both Thomases. Thomas Rast and Thomas Gummerer.

> I noticed that there seemed to be an occasional 'whitespace error'
> indicator (red background) directly after an +/- change character
> which I suspect is an error (I haven't actually checked). However,
> this indicator disappears if you add the --dual-color option.

Indeed. This is a quirk of the whitespace error paired with diffing diffs:
the whitespace error correctly treats the leading space as marker for a
context line, but if you diff diffs, the next character may still be a
marker for a context line (but this time the "inner" diff). And our
whitespace error detection mechanism cannot guess that it looks at a diff
of diffs.

However, in dual-color mode, we know that we will almost certainly look at
diffs of diffs (except if the change is in the commit message, in which
case I don't care about whitespace errors at all, anyway).

So I have this hack in 16/18:
https://public-inbox.org/git/b99ab186c4f11239a10950b9902d9c87d0e60513.1525448066.git.johannes.schindelin@gmx.de/T/#u

Essentially, I extend the dual-color mode to detect where such a bogus
whitespace error would be detected, and simply *skip the space*! I can get
away with that because dual-color is meant for human consumption, and if a
horizontal tab follows, it would not matter whether there was a space: it
would find the same tab stop. Likewise, if the space comes before a CR or
LF, or even just before the final NUL, the space can be safely omitted
from the output, too.

Ciao,
Dscho
