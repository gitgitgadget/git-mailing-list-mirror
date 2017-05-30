Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9E22027C
	for <e@80x24.org>; Tue, 30 May 2017 20:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbdE3UWz (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 16:22:55 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34844 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdE3UWy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 16:22:54 -0400
Received: by mail-io0-f195.google.com with SMTP id o12so15406iod.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hRcsv8i0vLe76fNI3MS3dsZAM+gNKzqicW+LX+bnLkM=;
        b=fAAFR+Zs1xJjHYscrBK2MICmbkyNcpM1HZ1yr53bt8idQkgxEMRt/bStt2EkFRiWyz
         Se7A+w1Fi6YOhIJg+75sNfbKV7H56UBSMZjPpuM2kyMqrc8qx+ImcF2asgP+jp02vbUR
         6z7w4z2sN/kH5Zm8vbfyZwPesQ9OnMIIOf624u4SQpNMgdxiVV4v7YhOBsjlGT9rIHWj
         jHjtA0tIYcPmJbDhYgZN6ihwIK6065H3gjA9eOKEfsppv+mzHC49Sr/UEshWISi5YBzQ
         HoDfm6i4DBhpqA4XFOTpP+G/oCHrnADCMnJtdPa4udRUffqjGrl5p78t7oGIUg9xSgf/
         nCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hRcsv8i0vLe76fNI3MS3dsZAM+gNKzqicW+LX+bnLkM=;
        b=OdE330/r2Eu5w+9ojlUiSpYZgFIL7tJGAQHApGp4LHOH2UMugG2BtEigm1A6fzuGkr
         uLIHMmmZZxNFUvdcZbWC9LnEj7yJ+NxV8SF7TDuB5JBa+Q7AxL4vPoiPHPrUf2b/8mAA
         Fmw7RDhdtN6SkSAIe66s0dTfTa9/EN+I9WwBnMFMgowcPdfL0onJ0fHN4vi6uzHTaPCq
         MK6iKkfyUNduhf9xxJavlRqlcPsS2n2wd+PtfL+fea2EKemrTDyY5/h4W+U6wzkeKVjZ
         Smxth0jHdJFgD/jiDr87+Be+mzp9Szc+rRs6JPDiwGKyRzb3lYCMkEwmftamSauO9U0q
         tHAw==
X-Gm-Message-State: AODbwcAxVRlgxvyTWmIahArxPauyiABRI1UH7P3X4Kz9UN3D+HbTxsYp
        6eewT+3vspFtmOJ21jeDhIb95LjUzw==
X-Received: by 10.107.201.131 with SMTP id z125mr17913665iof.160.1496175772530;
 Tue, 30 May 2017 13:22:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 30 May 2017 13:22:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705301635440.3610@virtualbox>
References: <cover.1493414945.git.johannes.schindelin@gmx.de>
 <20170526031508.24838-1-liambeguin@gmail.com> <6f0e176b-e638-c13c-6a6d-aa5b62297879@web.de>
 <alpine.DEB.2.21.1.1705291247000.3610@virtualbox> <CACBZZX4avOKJjWVSBSewNFMWyRj3FzHC2Onw3aWLf1F_MYi+Gg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705301635440.3610@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 30 May 2017 22:22:31 +0200
Message-ID: <CACBZZX6h1qEC5Drt0LzNLh=_ZXFTHjGCa=DDbhLUMtK9KjPjCg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] The final building block for a faster rebase -i
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 5:44 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Mon, 29 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, May 29, 2017 at 12:51 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Sat, 27 May 2017, Ren=C3=A9 Scharfe wrote:
>> >> Am 26.05.2017 um 05:15 schrieb Liam Beguin:
>> >> > I tried to time the execution on an interactive rebase (on Linux)
>> >> > but I did not notice a significant change in speed.  Do we have a
>> >> > way to measure performance / speed changes between version?
>> >>
>> >> Well, there's performance test script p3404-rebase-interactive.sh.
>> >> You could run it e.g. like this:
>> >>
>> >>       $ (cd t/perf && ./run origin/master HEAD ./p3404*.sh)
>> >>
>> >> This would compare the performance of master with the current branch
>> >> you're on.  The results of p3404 are quite noisy for me on master,
>> >> though (saw 15% difference between runs without any code changes), so
>> >> take them with a bag of salt.
>> >
>> > Indeed. Our performance tests are simply not very meaningful.
>> >
>> > Part of it is the use of shell scripting (which defeats performance
>> > testing pretty well),
>>
>> Don't the performance tests take long enough that the shellscripting
>> overhead gets lost in the noise?
>
> Okay, here you go, my weekly (or so) clarification about the POSIX
> emulation layer called MSYS2 (which itself kind of a portable Cygwin).
>
> Whenever Git for Windows has to execute Unix shell scripts (which are not
> native to Windows, as the "Unix" in "Unix shell scripts" so clearly
> suggests), we resort to calling the Bash from the MSYS2 project, which
> spins up a POSIX emulation layer. Git for Windows' own .exe files
> (and in particular, git.exe) is *not* affected by the POSIX emulation
> layer, as they are real Win32 programs.
>
> Whenever execution has to bridge into, or out of, the POSIX emulation
> layer, a few things need to be done. To emulate signal handling, for
> example, a completely new process has to be spun up that itself has the
> non-MSYS2 process as a child. The environment has to be converted, to
> reflect the fact that some things are Unix-y paths (or path lists) inside
> the POSIX emulation layer and Windows paths outside.
>
> Even when staying within the POSIX emulation layer, some operations are
> not as cheap as "Linux folks" are used to. For example, to spawn a
> subshell, due to the absence of a spawn syscall fork() is called, followe=
d
> by exec(). However, fork() itself is not native to Windows and has to be
> emulated. The POSIX emulation layer spins up a new process, meticulously
> copies the entire memory, tries to reopen the file descriptors, network
> connections, etc (to emulate the fork() semantics).
>
> Obviously, this is anything but cheap.
>
> And this is only a glimpse into the entire problem, as I am not aware of
> any thorough analysis what is going on in msys-2.0.dll when shell scripts
> run. All I know is that it slows things down dramatically.
>
> As a consequence, even the simple act of creating a repository, or
> spawning Win32 processes from within a shell, become quite the
> contributing factors to the noise of the measurements.
>
>> E.g. on Windows what do you get when you run this in t/perf:
>>
>>     $ GIT_PERF_REPEAT_COUNT=3D3 GIT_PERF_MAKE_OPTS=3D"-j6 NO_OPENSSL=3DY
>> BLK_SHA1=3DY CFLAGS=3D-O3" ./run v2.10.0 v2.12.0 v2.13.0 p3400-rebase.sh
>
> In my hands, a repeat count of 3 always resulted in quite a bit of noise
> previously.
>
> Mind you, I am working my machine. It has to run two VMs in the
> background, has multiple browsers and dozens of tabs open, checks for
> mails and Tweets and RSS feeds and a couple of Skypes are open, too.
>
> So yeah, obviously there is a bit of noise involved.
>
>> I get split-index performance improving by 28% in 2.12 and 58% in
>> 2.13, small error bars even with just 3 runs. This is on Linux, but my
>> sense of fork overhead on Windows is that it isn't so bad as to matter
>> here.
>
> Test
> ------------------------------------------------------
> 3400.2: rebase on top of a lot of unrelated changes
>
> v2.10.0            v2.12.0                  v2.13.0
> ------------------------------------------------------------------
> 60.65(0.01+0.03)   55.75(0.01+0.07) -8.1%   55.97(0.04+0.09) -7.7%
>
> (wrapped myself, as the ./run output is a lot wider than the 80 columns
> allowed in plain text email format)
>
> And what does it tell you?

For all the above: Yes I get that various things are slower on
Windows, but I think that regardless of that by far the majority of
the time in most of the perf tests is spent on the code being tested,
so it doesn't come into play:

$ parallel -k -j4 '(printf "%s\t" {} && (time GIT_PERF_REPO=3D~/g/linux
GIT_PERF_LARGE_REPO=3D~/g/linux ./run {}) 2>&1 | grep ^real | grep -o
[0-9].*) | awk "{print \$2 \" \" \$1}"' ::: p[0-9]*sh
0m34.333s p0000-perf-lib-sanity.sh
4m26.415s p0001-rev-list.sh
1m41.647s p0002-read-cache.sh
28m45.001s p0003-delta-base-cache.sh
0m55.767s p0004-lazy-init-name-hash.sh
0m15.891s p0005-status.sh
3m53.143s p0006-read-tree-checkout.sh
3m28.627s p0071-sort.sh
0m49.541s p0100-globbing.sh
14m42.273s p3400-rebase.sh
0m0.573s p3404-rebase-interactive.sh
0m54.103s p4000-diff-algorithms.sh
0m8.102s p4001-diff-no-index.sh
17m34.819s p4211-line-log.sh
4m50.497s p4220-log-grep-engines.sh
3m59.636s p4221-log-grep-engines-fixed.sh

I.e. I'd expct this to come into play with e.g.
p4000-diff-algorithms.sh, but most of the time spent in e.g.
p4220-log-grep-engines.sh on any non-trivially sized repo is hanging
on git-grep to finish.

Also if you look at test_run_perf_ in perf-lib.sh we only
/usr/bin/time some tiny shell code, actually I can't see now why we're
not just doing *only* /usr/bin/time <code to perf test>, right now we
measure some setup code & sourcing the shell library too.

> Not much, right? You have no idea about the trend line of the three tests=
,
> not even of the standard deviation (not that it would be meaningful for
> N=3D3). It is not immediately obvious whether the first run is always a t=
ad
> slower (or faster), or whether there is no noticable difference between
> the first and any subsequent runs.

Right, this could really be improved, but it's  purely in the
presentation layer, we log the raw runtimes:

    $ GIT_PERF_REPEAT_COUNT=3D6 ./p4220-log-grep-engines.sh
    $ cat trash\ directory.p4220-log-grep-engines/test_time.*
    0:00.01 0.01 0.00
    0:00.01 0.01 0.00
    0:00.02 0.01 0.00
    0:00.02 0.02 0.00
    0:00.01 0.01 0.00
    0:00.02 0.01 0.00

> In other words, there is no measure of confidence in those results. We
> can't say how reliable those numbers are.
>
> And we certainly can't know how much the shell scripting hurts.
>
> Although... let's try something. Let's run the same command in a *Linux
> VM* on the same machine! Yes, that should give us an idea. So here goes:
>
> Test
> ------------------------------------------------------
> 3400.2: rebase on top of a lot of unrelated changes
>
> v2.10.0           v2.12.0                 v2.13.0
> ---------------------------------------------------------------
> 2.08(1.76+0.15)   2.10(1.76+0.15) +1.0%   2.00(1.65+0.15) -3.8%
>
>
> A ha! Not only does this show a curious *increase* in v2.12.0 (but I'd no=
t
> put much stock into that, again N=3D3 is way too low a repetition number)=
,
> it also shows that the Linux VM runs the same thing roughly 30x faster.
>
> I did see a few speed differences between native git.exe on Windows and
> the git executable on Linux, but it was barely in the two-digit
> *percentage* region. Nowhere near the four-digit percentage region.
>
> So now you know how much shell scripting hurts performance testing.
>
> A lot.

Maybe that rebase test is just very fuzzy. Could you try to run this please=
:

$ cat p0000-perf-lib-sleep.sh
#!/bin/sh

test_description=3D"Tests sleep performance"

. ./perf-lib.sh

test_perf_default_repo

for s in 1 2 5
do
        test_perf "sleep $s" "sleep $s"
done

test_done

I get:

$ ./run p0000-perf-lib-sleep.sh
=3D=3D=3D Running 1 tests in this tree =3D=3D=3D
perf 1 - sleep 1: 1 2 3 ok
perf 2 - sleep 2: 1 2 3 ok
perf 3 - sleep 5: 1 2 3 ok
# passed all 3 test(s)
1..3
Test              this tree
---------------------------------
0000.1: sleep 1   1.00(0.00+0.00)
0000.2: sleep 2   2.00(0.00+0.00)
0000.3: sleep 5   5.00(0.00+0.00)

I'd be very curious to see if you get any different results on any of
your systems, particularly Windows.

Unless I'm missing something, if those numbers are 1, 2, 5 or close
enough and with small enough error bars, then the perf framework's use
of shellscripting should be fine, if not we've got something...

> It pretty much renders the entire endeavor of testing performance
> completely and utterly useless.
>
>> I'd also be interested to see what sort of results you get for my
>> "grep: add support for the PCRE v1 JIT API" patch which is in pu now,
>> assuming you have a PCRE newer than 8.32 or so.
>
> pu does not build for me:
>
> 2017-05-30T11:38:50.0089681Z libgit.a(grep.o): In function `pcre1match':
> 2017-05-30T11:38:50.0289250Z .../grep.c:411: undefined reference to `__im=
p_pcre_jit_exec'
> 2017-05-30T11:38:50.0329160Z collect2.exe: error: ld returned 1 exit
> status

Ouch, looks like I've missed some spot in my pcre1 jit series. What's
the PCRE version you have? This is somehow doing the wrong thing with
this bit in grep.h:

    #include <pcre.h>
    #ifdef PCRE_CONFIG_JIT
    #if PCRE_MAJOR >=3D 8 && PCRE_MINOR >=3D 32
    #define GIT_PCRE1_USE_JIT
    [...]

>> > Frankly, I have no illusion about this getting fixed, ever.
>>
>> I have a project on my TODO that I've been meaning to get to which
>> would address this. I'd be interested to know what people think about
>> the design:
>>
>> * Run the perf tests in some more where the raw runtimes are saved away
>
> You mean a test helper designed to do the timing and the setting up so as
> to time *just* the operations that should be timed?
>
> If so: I am all for it.

No I just mean save away the raw trash*/test_time.* files, so you can
do any sort of analysis on them later, e.g. render stdev, percentiles
etc. But this is assuming the raw numbers are useful, let's find that
out.

>> * Have some way to dump a static html page from that with graphs over
>> time (with gnuplot svg?)
>
> If you already go HTML, it would make much more sense to go d3.js. I woul=
d
> even prefer to go c3.js (which uses d3.js) right away. Would make
> everything so much easier.
>
> Not to mention more portable.
>
>> * Supply some config file to drive this, so you can e.g. run each
>> tests N times against your repo X for the last 10 versions of git.
>
> Sure.
>
>> * Since it's static HTML it would be trivial for anyone to share such
>> results, and e.g. setup running them in cron to regularly publish to
>> github pages.
>
> It does not need to be static. It can use, say, c3.js, for the added
> benefit of being able to toggle multiple graphs in the same diagram.

Right, I mean "static" in the sense that it wouldn't require some
dynamic backend, it requiring JS is fine, i.e. I'd just like someone
to be able to publish some raw data, point some JS/html at it, and
have it be rendered.
