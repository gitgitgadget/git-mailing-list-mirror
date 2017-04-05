Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ACF11FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 08:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932134AbdDEIve (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 04:51:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:51858 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753845AbdDEIuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 04:50:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lyj4F-1c07b93zTL-016ANY; Wed, 05
 Apr 2017 10:49:49 +0200
Date:   Wed, 5 Apr 2017 10:49:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, frank@gevaerts.be
Subject: Re: [RFC] dropping support for ancient versions of curl
In-Reply-To: <CAGZ79kb5VeKCzzafw+nEcRda2apuit-K=qZxxZ3Li96MiMdOXA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704051031200.4268@virtualbox>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net> <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com> <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net> <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
 <alpine.DEB.2.20.1704041351350.4268@virtualbox> <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com> <20170404165321.GC189807@google.com> <alpine.DEB.2.20.1704050043370.4268@virtualbox>
 <CAGZ79kb5VeKCzzafw+nEcRda2apuit-K=qZxxZ3Li96MiMdOXA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jmMqWAHkUtcBGBViGetwqZeT6PO1OHdxKEL6OA9BwpRODeX5wbQ
 +Z5XuNCK+PQBZPvmjL4wUFbKvfYhaJW9RhdPpoAN73fOBFSKeMS5FWHT4wqdo+AypqsBhVm
 QydGiD6QcKN51I+oETSb12/gct3K7k8jdDITuVSvSpvSYeUmSoR9jt0lBOUJfLqiihKo6K+
 MaVryrYW8HEal7L34g8wQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1WxnWljuYUo=:b7U3NrXzIqk+jitzWIVNvh
 X2fOKZFFxGivXd1P7YU6iP8noxmC4G/c/QyiICwtXJOQEGJ+mxlBlMfv8/pYVGT0J/8HiLisJ
 NYlHaanNfz456dcCJKZXuLbB4R/LngB+ul5kNsSVkVIOvZ2W4KD9K1//nYur4q89fTdTUSI+e
 wj/WFsFseAXo1WzzSiNHnqWB91ypQd5mt24BOmzRNXsH3I8oKEl8I4QelkfSMBNPqF9j0PLyi
 IIIhbbl1xqDk/ZR3UES9JRCUR+i4Cx1A3fv949YbWbZXSDO+yeQRejmliM0RZhQswpPeEuJiu
 kQGJQzJCXglvVZyrozOPj4mmOaETLwIau2jYPVRMJUe+rJbtP7ZCc6Xb7YSGdh/MJcnad7vZn
 czwYt6BQDa+b3fYnRG4F3R/ifHI5mrmaxm69AJF77QjcIvNYhOXnRYf8qE2xr6ylAEsYXPMwp
 hK58n3AGIYxWjm9jIS4OmxJQmPCrrsTjjXO7lZnReo/Yz9maqVtLm14QPJWnFSGUNi0jPvNKE
 8xw7D5PJafpsDZA5soD4Iuogmn9JSRtRjgn5Xtg3Ic81dcs2AMlH01mOdzKwMYN1COmHqcb5U
 8+bA+vGY8gojBAS4K3tXFJjhSldPGOFg/xM44hsBmL2ZIXCEGyOuw1pj95FaoYzlAXcYw4orJ
 EH/rhOPqq2mrJsJHmbpp/B5UljiaFk//v7sjTRkGhNN6+gfA0/YXRDlp+PCDa39nVGcHtpIvz
 8v/qOpGIRpp2qOTABNkxMpV0TEP9bxiokUZwv1+Te7vtyL3hOwXLmsaYPk5TCYJyEMq6kah+P
 PcdLZg9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 4 Apr 2017, Stefan Beller wrote:

> On Tue, Apr 4, 2017 at 3:46 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 4 Apr 2017, Brandon Williams wrote:
> >
> >> I'm all for seeing a patch like this applied.  I agree that we can't
> >> expect the world to be running the most up-to-date version of curl
> >> but we should be able to select some "oldest" version we will support
> >> which can be bumped up every couple of years.
> >>
> >> I mean, ensuring that you are running with an up-to-date version of
> >> curl is really important when it comes to all of the security fixes
> >> that have been made in each revision.
> >
> > I am not in the business of dictating to others what software they
> > have to run. I am in the business of maintaining Git for Windows. And
> > part of that job is to drag along code that is maybe not the most
> > elegant, but works.
> >
> > The patch in question resolves such a wart. Sure, it would be a
> > cleanup.  Is it a huge maintenance burden to keep those few #ifdef's,
> > though?  Absolutely not.
> 
> Keeping them around is the easy part, the hard part is promising to
> users that the software you maintain is as good as your reputation, when
> e.g.  we find out that certain #ifdefs don't even compile.  (See Frank
> Gevaerts answer)

From that point of view, we should drop support for platforms as soon as
we have a bug in our code that lets the build fail: there is little
difference between the #ifdef's that let Git build with older dependencies
and #ifdef's that let Git build on platforms other than Linux.

By that reasoning, we would have dropped FreeBSD support a gazillion
times. Or for that matter, Windows support.

I obviously disagree with this stance.

> Initially I thought I had a similar stance as you ("A well written line
> of code is cheap") but I kept quiet, as I do not have a lot of
> experience with dealing "old" Software.

I am speaking from my point of view, of course, maintaining Git for
Windows. Of course I would love to drop support for old MSys. But that's
not going to happen because at least one active contributor has a vested
interest in keeping it going.

But even then, it sometimes takes a while until any breakages get fixed.
Prematurely removing a build option "because it has been broken for a
couple of major versions" would make it infinitely harder for (often
overworked) contributors to fix the breakage.

Anyway, this whole discussion took way more effort from my side than to
maintain a couple of slightly stale #ifdef's. From
https://xkcd.com/1205/'s point of view, I should have ignored the
"let's rip out stuff just because we can" patch.

I just thought that we care a bit more about contributors' experience.

> Maybe the git community would want to take a look at the kernel
> community (or other similar communities), how they solve the "long term
> stable" problem of computer science.

If we want to follow the example of a inclusive community that values
contributors' time and effort, maybe we should look elsewhere?

I vividly remember hearing Greg KH's statement at Git Merge 2016 "we
deliberately waste contributors' time". Very vividly. Very, very vividly.

> So I would propose to take this patch, but be prepared to revert it in case
> some user yells.

It would be much nicer to contributors (who are likely not subscribed to
the Git mailing list, or at least do not read all the mails coming in on
that channel) if they could simply imitate the surrounding #ifdef's and
make that tiny patch that adds a guard around an unused static function.

If you require them to revert a patch first that reinstates an almost
working state with an old dependency, you expect them to know that there
was such a patch in the first place, and to dig it up.

Let's reiterate that we are talking about some #ifdef's here that are a
tiny maintenance burden. That may have a bug here and there, easily fixed.

Again, I am sure that we can provide a much better contributors'
experience.

Also, maybe, just maybe, there are more pressing issues than removing a
couple lines here and there? This discussion vaguely reminds me of the
opening statement of https://en.wikipedia.org/wiki/Law_of_triviality...
Just saying'...

Ciao,
Dscho
