Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955E01F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeBTW1O (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:27:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:54267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbeBTW1N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:27:13 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKYsh-1enznF3gMZ-001wWs; Tue, 20
 Feb 2018 23:27:10 +0100
Date:   Tue, 20 Feb 2018 23:27:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>
Subject: Re: File locking issues with fetching submodules in parallel
In-Reply-To: <CAGZ79kZXtE84nfO_nx+H61+2B9SU7ASD4r4JozwV=8HZ050SCA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802202314180.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1802201709570.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAGZ79kZXtE84nfO_nx+H61+2B9SU7ASD4r4JozwV=8HZ050SCA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:V+GBZdMsyaj9zlOybtn8y7zfqBcfqDSJJk4xleUcPI7JQkyRj/F
 fPQfxfk3jrGz5AGMCgp3aEk3z5MKnzyMIcWyKcjFXXuydxKaX8g1UVqsHHoQLh4pBL2noyC
 XqOBe1M3h5NiPVodHd6fNLQ5+vVhB5tB9phT7OgxBIBjlgc2Bw3Gp/fI0SbAWtCYbRuxFbD
 4qRqM7Rw9qFriF1GKbRmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zfri85jrb/E=:gJd/K5cN+zMifpl5U9svCj
 tH1Rb8c6dcOIBFDBU68+d/8r4VpGIy4n8EsktqF0Vhw7zjqukiwrCgLLZ5FMh+Hswbj139Kfh
 OD2LZamqxYM4o9eeWdZ0UFnabSo3kOz3rqezkB+m/KFnznjZ/NYEM9KTiwPmbKAJ6vxBRTJBw
 yGGRU5NosypJy8AwJvavx7WINODuZRPCwAcL7CAWFzcmlXF+wK1xCuJjI7SBOze8WOcFNZlnt
 HUhYfDnPjIFcN5jar/vcVFxqS39nZ01+CE/DmxMvrj8ZFmThihjAUMztVUbG+zLcYHSrnzW6v
 cqNvCPqLMs+V9u2fFA+q/KnywUQkFKLdhbqD8i4if5vJlScwW0PzVQQqu0sM56VCQpUZR/ak/
 v6DTCZfgXMaiP1irQTrMir4QlYVqy45SbkPKuwDdi/8S3InyNXC8DffR/LYWV7AY2pIZwqkUg
 b5firSbAMHUr6EoYYP43uehE2GFJOrsybu9sHPGcrRzsk9VYtwYJw4zTSzlyigOks8NZEue9o
 j2pjyUsDvaOeKf6+9AUD2VKa/UWH1xn5ZkgiDHSG+0ElWknSzhDzZCr42LgUujxRNtSFP//zI
 Kmmc+WWWMGdwG5xKRb9GOXxOsOPp/WvuLkWlM2tJPFX9vOpWuQicBLmwd4xi/PMNfavAC0784
 vv6sFFVoZLJVYg+Q1s1+SoUKAP42hs82kdgmCfA8tJ/dlk8LaEmqzY6z5mOlK/Cw5N+Cw0hM9
 COYJF6Ig4fbMrAV6koztpiYrnC7bPnh9kbwMZKE0fh8ZjI4FF28AL5jyyBHlZ28rDomBEKw2O
 8F9t9wWJg2Xb24xStprAbeuQn14T1ksSP2+eM/1bZ707I6A3/8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 20 Feb 2018, Stefan Beller wrote:

> On Tue, Feb 20, 2018 at 8:20 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Stefan (and other submodule wizards),
> >
> > Igor Melnichenko reported a submodule problem in a Git for Windows ticket:
> >
> >         https://github.com/git-for-windows/git/issues/1469
> >
> 
> Thanks for bringing this up. Is it better to discuss it here on at that
> issue?

It's up to you. I have no preference.

> > Part of it is due to Windows' behavior where you cannot read the same
> > file in one process while you write it in another process.
> >
> > The other part is how our submodule code works in parallel. In
> > particular, we seem to write the `.git` file maybe even every time a
> > submodule is fetched, unconditionally, not even testing whether the
> > .git file is already there and contains the correct contents?
> 
> only when they need to be newly cloned (as that is when the
> submodule--helper clone is invoked). When fetching, we'd not touch the
> '.git' file IIRC.

Okay. I saw multiple calls to the same connect_work_tree_and_git_dir()
function in submodule.c, and was not so sure that it was only clone.

But the bug report talks about `git submodule add` with a new URL and a
new submodule location, so I guess it is going down the clone path.

> > For some reason, the bug reporter saw a "Permission denied" on the
> > `.git` file when we try to write it (and I am pretty certain that I
> > tracked it down correctly to the `connect_work_tree_and_git_dir()`
> > function). The intermittent "Permission denied" error seems to suggest
> > that *another* process is accessing this file while we are writing it.
> 
> The reporter also reports this coming out of "git submodule add",
> which is not parallelized, but rather in the messy state of migrating
> as much code into C from shell, trying to not introduce to many bugs. ;)
> 
> So for add there is no parallelism I am aware of, which makes me wonder
> how the race is coming in there.

Hrm. You're right, there is no indication in that bug report that `git
submodule` spawns multiple processes in parallel.

> I recall making the decision to unconditionally write out the '.git' file
> for other operations like "git reset --hard --recurse-submodules" or
> "git checkout --force --recurse-submodules", as there you are really asking
> for a clean slate. I missed the Windows FS semantics for that case,
> so I guess re-reading the file to make sure it is already correct would
> avoid issues on Windows there. (though I do not yet recall how the
> parallel stuff would bite us there, as the file is written as the very
> first thing)

Maybe it is not parallel, but maybe it is simply an unclosed handle to the
.git file? I do not see anything in read_gitfile_gently() (which is the
only location reading the .git file I know of)... Did I miss anything?

> > It also seems that this problem becomes worse if the firewall is turned
> > on, in which case a couple of network operations become a little slower
> > (which I could imagine to be the factor making the problems more likely).
> >
> > A plausible workaround would be to write the `.git` file only when needed
> > (which also would fix a bug on macOS/Linux, although the window is
> > substantially smaller: the reader could potentially read a
> > partially-written file).
> >
> > But maybe we are simply holding onto an open handle to the `.git` file
> > too long?
> 
> That could very well be the case.

But as I said above, I fail to find any smoking gun in the source code.
The only code path I see that reads the .git file releases the resources
correctly AFAICT.

> > I tried to put together a bit more information here:
> >
> > https://github.com/git-for-windows/git/issues/1469#issuecomment-366932746
> 
> Thanks!
> 
> > Do you think there is an easy solution for this? You're much deeper in the
> > submodule code than I ever want to be...
> 
> I'll take a look for open handles, though we're already using our
> wrapper functions
> like 'write_file', which is supposed to close the handle gracefully (and has
> undergone testing on Windows a lot as it is the standard write function)

Right, even some of my code uses this successfully...

Curious problem.

Ciao,
Dscho
