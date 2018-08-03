Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1294E1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeHCPDo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:03:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:55067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbeHCPDo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:03:44 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0ML6XF-1flqmd0pDF-000M47; Fri, 03
 Aug 2018 15:07:26 +0200
Date:   Fri, 3 Aug 2018 15:07:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] negotiator/skipping: skip commits during fetch
In-Reply-To: <nycvar.QRO.7.76.6.1807271737470.10478@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1808031506461.71@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1807261233300.71@tvgsbejvaqbjf.bet> <20180726191609.176343-1-jonathantanmy@google.com> <nycvar.QRO.7.76.6.1807271737470.10478@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DwBQQBXrA/iAmlAfZRRd3AeOQPKnkE9QlL9dHt/7RMv5LnW8YBL
 JISfxRnLxFUDe5iaQKKsHSMr0q7E3gbwtVCs9aG+oHL4E1Xbra6HARNbEI1zD8OXiFc0e1S
 AV/2XB+QWFAF2wVM+WRCarFHHwLd9sjb2MKAQku4xKZE2meBu77BEaPVJ8YUmvorXr9mp5z
 d1eQeqp9aMJtBUeRafiTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:trEJelBXrds=:ep+A0abWy1jEdnnXGa38ov
 iGsM8gXGgYXNpotUwQHOrfBZVt2AWzrzsnEsr1XKlABRfi1y1KlzzQFrdZ3mwnKjfh+L6eq+5
 Kv6fGVbwJCIqZonLXTY584+Sx+hLthqRJF0J73g6NtMBr4CQ6nhFJJh2OLIyrX9eYTmKeQAXE
 GGgoAm1YVLnwHetF0YkaRejGgA9CrAYXNJT4aIV6aChFpAw4MPiPL31+WlxMB35kxtWE9IFsj
 P8/WaPpnNB7p4OcLV4ksrd6S1u6PgQI9eejoefQg64idHRo9YrrNMN7okhMGrM8Xog4gpFwOu
 5usielVNFUHG+/YCKub/9jcIMfo/kvelAGrxr8mXdHRaTpyGOy0vBJR9itDSveJrc4Mu2K8Ho
 9CYz+sIYNPsSvpdXapoE/Pb0Z6PunoFGCMAgS6y7ViOxRhLHsnlqQPcs/nTkJ6ekzv0s9Zm3Y
 Y+xBA1N6j/Ct8CLaO7gGngMptl3xyDnhB5IeCSTbY8fz0Qw9Y8lxZL0D09Tp0TuAIZ46kv/m9
 N1z6FdBVMxYe+atUnoIEQ06tesMCyyrLSoMQbE1+QzxgMI2LHpA7/S6ohuMFTI+tZEF/poP0U
 CMq+g1kNN4rL6qxBE1F1wDuyZf84lRnCjF32wMqy2XKrVXR5xQ22T1gqUIv7oCCpJev5CHbfg
 myPEnZpgWV177gy5nWkhydxzVkBVMmvpk2Q7nGzxSEdaKvmWOl3h0pier1j5c+50lNedQTxgX
 /GDE/z/XJxOCU+fyzI4AehT6fM6yl9FUo0tTiolFb5nrJD+BiLrK8Y0eO1i5e7ju2c5NStPpd
 q6HNbh7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 27 Jul 2018, Johannes Schindelin wrote:

> On Thu, 26 Jul 2018, Jonathan Tan wrote:
> 
> > > On Mon, 16 Jul 2018, Jonathan Tan wrote:
> > > 
> > > >  t/t5552-skipping-fetch-negotiator.sh | 179 +++++++++++++++++++
> > > 
> > > This test seems to be failing consistently in the recent `pu` builds:
> > > 
> > > https://git-for-windows.visualstudio.com/git/_build/results?buildId=14337&view=logs
> > > 
> > > Could you have a look, please?
> > 
> > Hmm...on my Linux computer, this test passes on both pu (as of the time
> > of writing) and 838143aa5c ("Merge branch 'ab/newhash-is-sha256' into
> > pu", 2018-07-25) (pu at the time of that build, according to the website
> > you linked above). If you could rerun that test with additional code,
> > could you add a "cat trace" and show me what the client sends?
> 
> I can give you something even better: a playground. Just open a PR at
> https://github.com/gitgitgadget/git (all of the branches on gitster/git ar
> mirrored, including yours, I am sure, so you can target that branch
> specifically).
> 
> Once you open a Pull Request, it will automatically build and run the test
> suite on Windows, macOS and Linux. You will see it in the "checks" section
> on the bottom. Example for my range-diff series:
> 
> https://git-for-windows.visualstudio.com/git/_build/results?buildId=14279
> 
> For a quicker turnaround, you could add a commit that forces the `all`
> target in `t/Makefile` to run only your test.
> 
> > When I do that, the relevant parts are:
> > 
> >   packet:        fetch> have 9ab46928dc282aa09f4dbf96893a252e058e7e8e
> >   packet:        fetch> have dc824fafb05f3229aedf1f320bbe572e35364dfe
> >   packet:        fetch> have caef059de69917b9119176a11b88afcef769331d
> >   packet:        fetch> have 41bd8dc092ee110ba80e350a346ec507ab2e42a0
> >   packet:        fetch> have e9a2c092a8e911567a377c881a7f6031e7f892ea
> >   packet:        fetch> done
> > 
> > which is exactly as I (and the test) expect.
> > 
> > Two possible reasons for the discrepancy that I can think of offhand are
> > that (1) my computer generates different commits from your test system,
> > and (2) the priority queue pops commits in a different order. For (1),
> > that's not possible because the SHA-1s are the same (as can be seen by
> > comparing your link and the "have" lines I quoted above), and for (2),
> > the code seems OK:
> > 
> >   static int compare(const void *a_, const void *b_, void *unused)
> >   {
> >   	const struct entry *a = a_;
> >   	const struct entry *b = b_;
> >   	return compare_commits_by_commit_date(a->commit, b->commit, NULL);
> >   }
> > 
> > Let me know if you can observe the output of "cat trace" or if you have
> > any other ideas.
> 
> Like I said, you can use those "CI" builds, I think that would be more
> effective than if you waited for me to react, I am quite overwhelmed these
> days.

Hopefully you have a chance to do so. I got the impression that it is
actually more of a flakey test than a consistent test failure:

https://git-for-windows.visualstudio.com/git/_build/results?buildId=15015&view=logs

Ciao,
Dscho
