Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43BB31F404
	for <e@80x24.org>; Fri, 14 Sep 2018 19:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeIOAUV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 20:20:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:58491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeIOAUV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 20:20:21 -0400
Received: from MININT-6BKU6QN.attlocal.net ([108.198.118.51]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LrZOj-1fpJZw11nJ-013QJ1; Fri, 14 Sep 2018 21:04:21 +0200
Date:   Fri, 14 Sep 2018 14:04:17 -0500 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with --write-junit-xml
 upon failure
In-Reply-To: <20180905202445.GA8953@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1809141351590.73@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com> <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com> <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet>
 <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com> <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet> <CAPig+cQkC4-6DyQdJHc8QUfBx+L6o1SK4ODy4MoP44+VHHk96Q@mail.gmail.com> <20180905202445.GA8953@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9sU2IKvUg/8rlUNC60xwpe3y2mB4Qw4el5sHqJnCjvyTaykwMri
 J6OBPSXt6aQeEia+4PmftqnisHumKQA01Eq5yTNd7UBj/fpi5yn4QRGN8c/FQPQGfUHJE3z
 r4MSYLOo7dug9fxYMqP/eyDSCktM6zwougae2dzn1essRlI+lui2s+j1c6MKePEPSv1C8Hy
 XV5hT8RLfL5CUmwoUJjxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PDGQJh1JDPQ=:gQqSldBWluHYWmVQafe+fO
 10Tv9N9RpWmvw9MKSa7uCf5PBsusje1wzhqt+96ucSS/S8DsFGOlu+txQ9/CL3cynDcE8TQbG
 xsEyaG1EKzpOofen5is0Lzyp5dYdOQ1FEl9eYJ4y13vms3J2NykuPMIRFdsPLFqip+0oNTcuJ
 +7BuIMlAY7aWU8uG7DGeAEu3bzIW9u8uXQ4azc58VcAXmQW6yeEaJ0gcn4ySUIsmu+8toTJ/w
 vLSs+urjAwKC9SyX6byCKQSEVdXRsNdawI5br1eQCNRrWJlz5d18WbDrGs/3Q3ZhO4/QxNhHy
 K57e56/oP8YPIm62iuiujQlvhH6i8l+MDZveWdw1yb8RTD3ORl53AE1wcDv0ftGqKLTeBtMvf
 kIffhFX/Lxhfztrg+11q1LPfE2wTWNWSCmb2WDvvsZpsTga/0v69lPwjJJH+VR0BdRtl//4m7
 +mJtjrozggM0F3lOo9AJ/khdEBkoe/GGwJAQbc7XjqU+tjJiUxCnNbaiowJd0R0UwAQPx9mek
 zKXV6XHT+eOdyfygi5T7VbCe0CYop6VBvVPB7Fq4ahLqCrSJ5HR5/YC0tMvFQvcFeMzZYcy2H
 Zz5Uv25eRWleiN94ZJVKALbymtPRlFGX141hyF6Dp3hbOWBCia5kjWWz4qy7CJhIAtTQ2wz7j
 tBWwiDaLeBLuHnVE+1/QtxdX3o4SLVUW9vEWDB0EHeCUnrYNvuMYvN4eC9Bl9ENqnEB1SoPLf
 0i4450cfsFNHwbN7RePjd2BU+a2Ms5LmVFuMQDv2YJZHJTn6HqWK0/AyLQXkT+SstDWDUfDw1
 WDQvRMmsH3y35PRdgfVkK9clsOe3HM1bsV5NYkm3e/QpSRR11Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 5 Sep 2018, Jeff King wrote:

> On Wed, Sep 05, 2018 at 02:38:34PM -0400, Eric Sunshine wrote:
> 
> > On Wed, Sep 5, 2018 at 8:39 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > So let's hear some ideas how to improve the situation, m'kay?  Just
> > > as a reminder, this is the problem I want to solve: I want to run
> > > the tests in a light-weight manner, with minimal output, and only in
> > > case of an error do I want to crank up the verbosity. Instead of
> > > wasting most of the effort to log everything and then throwing it
> > > away in most of the common cases, I suggest to re-run the entire
> > > test.
> > 
> > What about the very different approach of capturing the full "verbose"
> > output the executed tests in addition to whatever is actually output
> > to the terminal? If a test fails, then (and only then) you can insert
> > the captured verbose output into the JUnit XML file. This way (if we
> > always have the full verbose output at hand), you don't need to re-run
> > the test at all.
> > 
> > I've cc:'d Peff and Jonathan since I believe they are more familiar
> > with how all the capturing / output-redirection works in the test
> > suite.
> 
> I don't think there's much to know beyond what you wrote. The
> "--verbose" case does not really cost any more than the non-verbose one,
> because the only difference is whether output goes to a file versus
> /dev/null. But the commands all call write() regardless.

This really only holds true on systems where redirected output is
essentially a no-op.

For the MSYS2-emulated case, this is incorrect. And as that case is
already suffering, time-wise, I would be loathe to pile more onto it.

> For --verbose-log, it does of course cost a little extra to run one
> `tee` per script, and to write a few kb of logs. I doubt those are
> measurable versus the rest of a script run, but I'm happy to be
> disproven by numbers.

I tried, and failed, to quantify this properly. Essentially because a
single test run takes over 1h15m, so I tried to do it in the cloud, but
those timings are too variable for anything approaching an accurate
measurement.

> There are some gymnastics done to re-exec the test script with the same
> shell, but AFAIK those are robust and don't cost a lot (again, one extra
> process per script run).

It *is* actually a bit worse here (but only in the case of failures, which
should be the minority of the cases): imagine an expensive test like t0027
that takes something like 14 minutes to run, and then a test failure near
the end: re-running with verbose output will cost another 14 minutes.

However, the benefit of allowing to pass flakey tests outweighs the costs
here, if you ask me.

> I'm not overly concerned about the cost of re-running a test, since the
> idea is that failed tests should be rare. I would be a little worried
> about flaky tests mysteriously righting themselves on the second run (so
> you know a failure happened, but you have no good output to describe
> it).

This is actually a benefit.

Pretty much all the times I can remember a test being flakey (with the one
notable exception of the O_APPEND issue with GIT_TRACE), the *tests* were
buggy.

Plus, it is less concerning if a test fails occasionally vs a test that
fails all the time.

My plan is to indicate the outcome of "Passed upon rerun" in the test
output eventually, as soon as there is server-side support for it.

(Sidenote: there is technically already server-side support for it, but we
would have to generate Visual Studio-style test output, and I had the
hunch that some die-hard Linuxers among the core Git developers would take
objection to that.)

> I do agree that a test_atexit() cleanup would make a lot more sense than
> what's in the original patch. And that's nicer than the exit trap we're
> using already, because you may note that each caller has to manually
> restore the original 'die' handler that test-lib.sh installs.

Okay, then. I will work on this.

Ciao,
Dscho

> That would also help with bitrot. If this funky cleanup case only causes
> problems with junit output, then other people are likely to forget to do
> it, and the mess falls onto the junit folks (i.e., Dscho). But if the
> tests start _relying_ on test_atexit() being called (i.e., don't call
> stop_git_daemon manually, but assume that the atexit handler does so),
> then the responsible authors are a lot more likely to notice and fix it
> early.
> 
> -Peff
> 
