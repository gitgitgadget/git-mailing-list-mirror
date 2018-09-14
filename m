Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56391F404
	for <e@80x24.org>; Fri, 14 Sep 2018 18:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeIOACE (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 20:02:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:60963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeIOACE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 20:02:04 -0400
Received: from MININT-6BKU6QN.attlocal.net ([108.198.118.51]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LngRb-1fKz2g2UkJ-00ht4u; Fri, 14 Sep 2018 20:46:14 +0200
Date:   Fri, 14 Sep 2018 13:46:09 -0500 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with --write-junit-xml
 upon failure
In-Reply-To: <CAE5ih787aEOAGoC9Ze8qgq+veLQYNkpKgjAG7MpkP0=nyQ5MMA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809141338360.73@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com> <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com> <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet>
 <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com> <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet> <CAE5ih787aEOAGoC9Ze8qgq+veLQYNkpKgjAG7MpkP0=nyQ5MMA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qasUh8XrHFyqLXWuroDL1O63AX2DBmsf53NzSiU9jIzR9Mb7HV/
 WfGCB3jf2cpk8KgH0SB2BFb0Ia+1LfTFRzzuhdEoxt2cRnhWupRYsoXcN1nPb1vd9t0sdCD
 d9xrwxQWfLkDpIU0/Bmh/fCjZ4+Q8q5CoRZ9zxarJ9xeObj0c3CkwEVsGwyi846SpPe66hv
 Txz88NFDtblVjEibpwqPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V7y5lyViMu4=:EV4hI5vhkuSqGEuVaF7l9x
 mLFRpKNN/MlVqOOkV+pwLiiBLOGPowiVnCbWXeZ264fmpHEGCqCGcKLobIzb+l8lADz9PS1Xo
 QmWd92oBLesihtY3zG9/wAYjipKbHfrcyBU6V4dkxCPC4YvjSjGWWJFU24ICwrS5gm8EgX1Mq
 zvDj1iSvIVa/qVgMFcF/0MRp4Pgvl9Mmj4DMn3WM9qp2Gi0B0+O9O5SppUwU8/r6IffYIxG2b
 hYGBpjNg/pWqj1OJu8tIgVkLccbJ5jWkZn3HevqJm7pt2qEYzWn31SZBXHBuyawAtW7JGu9A0
 IXjtCLnv9t7wptQXDlUMT0OJd5ZfBY18IgMjyvYxu7XgSBYRFpTyvOi4uGVp2l8nnFltlp2Cb
 l13aCdom+caZ/pIOsBOyytIw1po4Ri3oOhE5hKZ0CQS+KxcZGlw2HEuTngtVbMfq4hWAo1Cu0
 7RZb0SYkNe0FpIfZDO89y5fTkPNx0dH1YpMBBlpOPhCf56W/17nwcaoV080gtlb+1nl9P9aDM
 Xu3WHKHfPaLIMPwCYajL8+uYU1Ag1zlE+f7JiDLMNKu7xYxKfTONnHO3GYdW+4rnQo2h43nHA
 RRxZy6HQ/InKTUExCWE13BEev8JOBGvTEoNIn82ULLZYXS2F7plV3v3b4aie+20piNRKH8CZi
 5Z4cqX9aBkCOTl8w7tt7w2dBzHUQQboy7QZk3Re2JOeyTucjO7gmr2dsjGpoZWeuB0Il3tY63
 VQRrN8Q6PeSJrzUDS/6f7Nyj/oaFE7ZqXD8dKvz0gqsFjkZQqm0mxaf/EVXYT85w6pI+51gQw
 wN5jj8Jwqe9tWbvfVRiisPMjsNBHUSimXjEHyoz6e2Oi3hHAB0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Wed, 5 Sep 2018, Luke Diamand wrote:

> On 5 September 2018 at 13:39, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 5 Sep 2018, Luke Diamand wrote:
> >
> >> On 4 September 2018 at 12:09, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >
> >> > On Tue, 4 Sep 2018, Eric Sunshine wrote:
> >> >
> >> >> On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
> >> >> <gitgitgadget@gmail.com> wrote:
> >> >> > So let's do something different in VSTS: let's run all the tests with
> >> >> > `--quiet` first, and only if a failure is encountered, try to trace the
> >> >> > commands as they are executed. [...]
> >>
> >> Is this re-running just an individual test on its own or all the tests
> >> within a single file?
> >
> > Upon encountering a failed test, it is re-running the entire test script
> > afresh.
> >
> >> The latter shouldn't need this at all.
> >
> > Please do not let me die dumb. In other words, I would love for you to
> > explain what exactly you mean by that sentence.
> 
> Just re-run the script. You shouldn't need to kill p4d, as each script
> starts up its own instance of p4d, and shuts it down when it exits.
> 
> $ cd t
> $ ./t9800-git-p4-basic.sh
> Ctrl^C

That Ctrl^C is not possible in the automated builds (which are the subject
of this patch series).

What *is* possible is to detect in the test script that there was a
breakage, and then re-run the test script.

Unfortunately, at this stage the first test script has not exited yet, so
your p4d has not exited yet, and we have to clean up in some way before
re-running (because the port in use is determined by the test script's
number, so we really need to kill the old daemon).

And this is exactly what my patches try to achieve here.

> $ ./t9800-git-p4-basic.sh -v
> 
> There's a cleanup() function in lib-git-p4.sh which kills the p4d
> server, and that's invoked via:
> 
>   trap cleanup EXIT
> 
> That's the only cleanup that each of the scripts require AFAIK.

Good.

However, we really will want to consider introducing something consistent
here, something that works for *all* test scripts. IOW if any test script
wants to start a process for the life-time of that script, and needs to
kill that process at the end, we will want to have a consistent,
documented way to register a function (or commands) to be called at the
end.

And that function (or commands) need to be run also when stopping
everything in preparation for a re-run.

> >> And the former, I'm not sure will actually work - most of the tests
> >> assume some particular p4 state. But perhaps I'm missing something?
> >
> > No, the former would not work at all. Not only for the p4 tests: Git's
> > tests frequently commit the deadly sin of relying on output of one another
> > (wreaking havoc e.g. when test cases are skipped due to missing
> > prerequisites, and latter test cases relying on their output). It is not
> > the only thing that is wrong with the test suite, of course.
> >
> >> I also think it does look kind of ugly. And if there's one thing I've
> >> learned, it's that the ugly hack you write today with the words "we'll
> >> tidy this up later" goes on to live with you forever!
> >
> > Okay.
> >
> > (And having read lib-git-p4.sh, I kind of see where you learned that.)
> >
> > But maybe you also have some splendid idea what to do instead? Because
> > doing something about it, that we need. We can't just say "oh, the only
> > solution we found is ugly, so let's not do it at all".
> >
> > I am even going so far as to say: unless you have a better idea, it is
> > pretty detrimental to criticize the current approach. It is the opposite
> > of constructive.
> >
> > So let's hear some ideas how to improve the situation, m'kay?
> >
> > Just as a reminder, this is the problem I want to solve: I want to run the
> > tests in a light-weight manner, with minimal output, and only in case of
> > an error do I want to crank up the verbosity. Instead of wasting most of the
> > effort to log everything and then throwing it away in most of the common
> > cases, I suggest to re-run the entire test.
> >
> > What do you suggest to solve this?
> >
> 
> I don't know about any other tests, but the git-p4 tests don't take
> any longer in verbose mode.

That statement is too general to be correct. It may be the case in your
setup, but I found that even a redirected, chatty stderr can slow down
things on Windows substantially, probably due to the POSIX emulation going
on in the background that needs to prepare for all kinds of eventualities
(that we do not even need, but the MSYS2 runtime has no way of knowing
that).

> So one simple solution is to just run it in verbose mode - unless there
> are other tests which have more overhead.

It is a bit of an overhead. As the entire test run on Windows takes
*quite* a while (due to said POSIX emulation issues), I was not able to
quantify it exactly.

> The trap/exit/cleanup method that the git-p4 tests already use would
> seem to be ideally suited to cleaning up everything on exit.

Yes. On exit. But I cannot exit here, not before re-running the script.

> There might be some specific tests where this doesn't quite work out,
> if you let me know what they are I can have a look at fixing them for
> you.

Thanks. I will let you know when I encounter other tests than the p4 and
git-daemon tests (which I fixed in this patch series).

Ciao,
Dscho
