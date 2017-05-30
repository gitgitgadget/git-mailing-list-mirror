Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBDC2027C
	for <e@80x24.org>; Tue, 30 May 2017 15:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750993AbdE3PpP (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 11:45:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:63809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdE3PpO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 11:45:14 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmOLO-1dpL3n0qZu-00Zyvx; Tue, 30
 May 2017 17:44:53 +0200
Date:   Tue, 30 May 2017 17:44:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 00/10] The final building block for a faster rebase
 -i
In-Reply-To: <CACBZZX4avOKJjWVSBSewNFMWyRj3FzHC2Onw3aWLf1F_MYi+Gg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705301635440.3610@virtualbox>
References: <cover.1493414945.git.johannes.schindelin@gmx.de> <20170526031508.24838-1-liambeguin@gmail.com> <6f0e176b-e638-c13c-6a6d-aa5b62297879@web.de> <alpine.DEB.2.21.1.1705291247000.3610@virtualbox>
 <CACBZZX4avOKJjWVSBSewNFMWyRj3FzHC2Onw3aWLf1F_MYi+Gg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-135437267-1496156336=:3610"
Content-ID: <alpine.DEB.2.21.1.1705301727060.3610@virtualbox>
X-Provags-ID: V03:K0:dl40SbKBAuOujokYTzHnPbtS4RD+9/TVugg0uE6089svf0hdcGk
 u6VOSIGRGXoAwosrplrS6dpTzzPpVMcHuucK+va2JbogJhRpoTnfx6dV6qsL3k2KbI8adNl
 kDIGDNdpKFcSIdSM1hmuEGmMvcgbv6tTfnQexyMnPgZFixxbeSlnkJlttObSmBPjURLx5kV
 /7KHGDnQXlNLVaJ0W9vog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6TOn0Fdj6t0=:8R24hcPbwncgi60nWTTW0o
 hS97XlcQC0GenwBdKr24b3irTYP+YyrI/xq13azTm6Z79MjebGellepT+Xy1+yMT74/RXnGnA
 uvJxIoaCKrok69RPPnrhmiExHe9T+F7CJ+hE4plcj5udaoR7AaTSEXsRoOFyXf+Uk7BXbHZLn
 qxg+7CIDDxa1I56F7Q8UJpKZmFch4FRP2hfEDCkw8i1PoFTvcLLkfF3Ojfm5zTw8RCHwqo4or
 FgkcuCqg6g/Aagd8jQdiKbFc/1M1/JGRkg4L02fQLlbMZWKvQyywlOv3e7qoKgB07VEa1rxw2
 FunJrJRLUhj5dgq1r4KXl6K72jp3/wubCZxwNYf/uzLVOz9fqOBO6taPBIE67J1KkRJS6oNGl
 m1Y9alSMi2SjA5D/UIXPi0wJcFcKMLC+/oCJKEXQMdXdnekuhGQtAYibkldBvpYUHSYMNNLy8
 9V8pRdp9ZpYV1qYsdbH7+OuhPKjWnvI07WHOr2m7y5V80+guhdQ33PAoK0juyKjH9JMj6jjy4
 /S3gTcMKNDVAvi6sZ5EjN2s+7BFuE5U1nacypzBMKm8+2zfsAxMtFghIfuQjDlccAo2oc7l+K
 QLiQnfQ2Aqvn5k2rA4Ag3MqDQ2YS/JqVrOLAJBXOyjfZSZHOL6OEtLYRLQgy6Yy0zjXv1h/jS
 JZnzJw6j9Tv0T5UKzGHX3hzVFoNNjcJLnJiUKwRyeWMDYQCAXoy4Kt/JeToD4ZH3G29lwRuux
 dRDJLLOxKtHuTPu3d3fkDpldRe8Geb+sOOwF4MynbWjQfzHVx3GOOUVOoj3dNVW3HldyrKutW
 XW9HDr/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-135437267-1496156336=:3610
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.21.1.1705301727061.3610@virtualbox>

Hi =C3=86var,

On Mon, 29 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, May 29, 2017 at 12:51 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 27 May 2017, Ren=C3=A9 Scharfe wrote:
> >> Am 26.05.2017 um 05:15 schrieb Liam Beguin:
> >> > I tried to time the execution on an interactive rebase (on Linux)
> >> > but I did not notice a significant change in speed.  Do we have a
> >> > way to measure performance / speed changes between version?
> >>
> >> Well, there's performance test script p3404-rebase-interactive.sh.
> >> You could run it e.g. like this:
> >>
> >>       $ (cd t/perf && ./run origin/master HEAD ./p3404*.sh)
> >>
> >> This would compare the performance of master with the current branch
> >> you're on.  The results of p3404 are quite noisy for me on master,
> >> though (saw 15% difference between runs without any code changes), so
> >> take them with a bag of salt.
> >
> > Indeed. Our performance tests are simply not very meaningful.
> >
> > Part of it is the use of shell scripting (which defeats performance
> > testing pretty well),
>=20
> Don't the performance tests take long enough that the shellscripting
> overhead gets lost in the noise?

Okay, here you go, my weekly (or so) clarification about the POSIX
emulation layer called MSYS2 (which itself kind of a portable Cygwin).

Whenever Git for Windows has to execute Unix shell scripts (which are not
native to Windows, as the "Unix" in "Unix shell scripts" so clearly
suggests), we resort to calling the Bash from the MSYS2 project, which
spins up a POSIX emulation layer. Git for Windows' own .exe files
(and in particular, git.exe) is *not* affected by the POSIX emulation
layer, as they are real Win32 programs.

Whenever execution has to bridge into, or out of, the POSIX emulation
layer, a few things need to be done. To emulate signal handling, for
example, a completely new process has to be spun up that itself has the
non-MSYS2 process as a child. The environment has to be converted, to
reflect the fact that some things are Unix-y paths (or path lists) inside
the POSIX emulation layer and Windows paths outside.

Even when staying within the POSIX emulation layer, some operations are
not as cheap as "Linux folks" are used to. For example, to spawn a
subshell, due to the absence of a spawn syscall fork() is called, followed
by exec(). However, fork() itself is not native to Windows and has to be
emulated. The POSIX emulation layer spins up a new process, meticulously
copies the entire memory, tries to reopen the file descriptors, network
connections, etc (to emulate the fork() semantics).

Obviously, this is anything but cheap.

And this is only a glimpse into the entire problem, as I am not aware of
any thorough analysis what is going on in msys-2.0.dll when shell scripts
run. All I know is that it slows things down dramatically.

As a consequence, even the simple act of creating a repository, or
spawning Win32 processes from within a shell, become quite the
contributing factors to the noise of the measurements.

> E.g. on Windows what do you get when you run this in t/perf:
>=20
>     $ GIT_PERF_REPEAT_COUNT=3D3 GIT_PERF_MAKE_OPTS=3D"-j6 NO_OPENSSL=3DY
> BLK_SHA1=3DY CFLAGS=3D-O3" ./run v2.10.0 v2.12.0 v2.13.0 p3400-rebase.sh

In my hands, a repeat count of 3 always resulted in quite a bit of noise
previously.

Mind you, I am working my machine. It has to run two VMs in the
background, has multiple browsers and dozens of tabs open, checks for
mails and Tweets and RSS feeds and a couple of Skypes are open, too.

So yeah, obviously there is a bit of noise involved.

> I get split-index performance improving by 28% in 2.12 and 58% in
> 2.13, small error bars even with just 3 runs. This is on Linux, but my
> sense of fork overhead on Windows is that it isn't so bad as to matter
> here.

Test
------------------------------------------------------
3400.2: rebase on top of a lot of unrelated changes

v2.10.0            v2.12.0                  v2.13.0
------------------------------------------------------------------
60.65(0.01+0.03)   55.75(0.01+0.07) -8.1%   55.97(0.04+0.09) -7.7%

(wrapped myself, as the ./run output is a lot wider than the 80 columns
allowed in plain text email format)

And what does it tell you?

Not much, right? You have no idea about the trend line of the three tests,
not even of the standard deviation (not that it would be meaningful for
N=3D3). It is not immediately obvious whether the first run is always a tad
slower (or faster), or whether there is no noticable difference between
the first and any subsequent runs.

In other words, there is no measure of confidence in those results. We
can't say how reliable those numbers are.

And we certainly can't know how much the shell scripting hurts.

Although... let's try something. Let's run the same command in a *Linux
VM* on the same machine! Yes, that should give us an idea. So here goes:

Test
------------------------------------------------------
3400.2: rebase on top of a lot of unrelated changes

v2.10.0           v2.12.0                 v2.13.0
---------------------------------------------------------------
2.08(1.76+0.15)   2.10(1.76+0.15) +1.0%   2.00(1.65+0.15) -3.8%


A ha! Not only does this show a curious *increase* in v2.12.0 (but I'd not
put much stock into that, again N=3D3 is way too low a repetition number),
it also shows that the Linux VM runs the same thing roughly 30x faster.

I did see a few speed differences between native git.exe on Windows and
the git executable on Linux, but it was barely in the two-digit
*percentage* region. Nowhere near the four-digit percentage region.

So now you know how much shell scripting hurts performance testing.

A lot.

It pretty much renders the entire endeavor of testing performance
completely and utterly useless.

> I'd also be interested to see what sort of results you get for my
> "grep: add support for the PCRE v1 JIT API" patch which is in pu now,
> assuming you have a PCRE newer than 8.32 or so.

pu does not build for me:

2017-05-30T11:38:50.0089681Z libgit.a(grep.o): In function `pcre1match':
2017-05-30T11:38:50.0289250Z .../grep.c:411: undefined reference to `__imp_=
pcre_jit_exec'
2017-05-30T11:38:50.0329160Z collect2.exe: error: ld returned 1 exit
status

> > Frankly, I have no illusion about this getting fixed, ever.
>=20
> I have a project on my TODO that I've been meaning to get to which
> would address this. I'd be interested to know what people think about
> the design:
>=20
> * Run the perf tests in some more where the raw runtimes are saved away

You mean a test helper designed to do the timing and the setting up so as
to time *just* the operations that should be timed?

If so: I am all for it.

> * Have some way to dump a static html page from that with graphs over
> time (with gnuplot svg?)

If you already go HTML, it would make much more sense to go d3.js. I would
even prefer to go c3.js (which uses d3.js) right away. Would make
everything so much easier.

Not to mention more portable.

> * Supply some config file to drive this, so you can e.g. run each
> tests N times against your repo X for the last 10 versions of git.

Sure.

> * Since it's static HTML it would be trivial for anyone to share such
> results, and e.g. setup running them in cron to regularly publish to
> github pages.

It does not need to be static. It can use, say, c3.js, for the added
benefit of being able to toggle multiple graphs in the same diagram.

Ciao,
Dscho
--8323329-135437267-1496156336=:3610--
