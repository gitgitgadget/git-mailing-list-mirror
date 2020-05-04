Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C53C47257
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0761A20707
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bvqIT8iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEDUTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 16:19:49 -0400
Received: from mout.web.de ([212.227.15.4]:46051 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgEDUTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 16:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588623586;
        bh=uXyrTLwgL9LiHKc9zddUdnOtghqd+SL/Qv2eulRy240=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bvqIT8izIA4ssoQwiXO/tSA1b19iULMaC72Ee53U6o9vlwuoOXACGBxspDCFKT/VS
         qd6CxCVnJ27kG32Ffn8Lh5AEsi/VbLhARFIP/soIgmuuCoFr15JBJHS8rrC+4kmcie
         TrCJ7LQlFmHqh65iMg5oMhFvLs+mJz3Yx+Z6T7tQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1iwLcc3dCp-00hwez; Mon, 04
 May 2020 22:19:45 +0200
Date:   Mon, 4 May 2020 22:19:44 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Git 2.26.2 and failed self tests on OS X
Message-ID: <20200504201944.gh3zykhil3txdwnk@tb-raspi4>
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP>
 <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4>
 <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:uOZIuGKYZ8hgFRNEFtF37CsP2hWbULR1v9gkDkokaI8/ynOmfN9
 1+MgtmMLYkUsr/oKiGnGzQg39F4+a+LjL6+U5PrzA4xMrwQci12TPeq7bR475WnnJ5dEyEG
 XUaUs6FN9l1BOtdCQqYkMPZxuUDMruH3V3fFfplx2vyh1BknRYWuGrP660lMHqVKH7l1qL7
 AwetbwS+Dw/NuK9877Zdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4WH5qGv823I=:sNECr4BogvvppnHtyxXvh1
 OmXmhA/fGyfQbnDGB0Cd5H6+0Ca4+tF8uU/PsSuEEKdOi8GYndIeAqKhGv16CIEplX3apbngn
 3AMTiJRMZRqcLdQ58lNrc++hMPicIJ6P7Can6TaVPUJK3hr+i7wMBQ6Dew6BAcd56rQFaQXiz
 HnOXDNIVtbQDnozw5Ax1DT8L4zF3Hgs5j+nXQGeJWWATFWKLpRVRyZVMGxwEAEMhX5dk0UT5B
 npUFBzcPcrtQgV0U196JQ8ElapJcPgWFnS0FoBKVfM2eQU5zjKqJfdB8dkNiEW3Ox4j8r3CaO
 +oIs6MXrbu4ZLqUhVFP1kjWbLgyyH2A4dYAAvCrYKYJh2ZRTvrVAZX57sSTvuLXDQxgZGUQIk
 7o/s1YpNRcUxjnWXCsxVzmDyRVMb0IoN+8CGcD5KKVEFl+U16sPqca72EPfs3rAu3HTQuwlid
 sVN/QpQosS1iJnaeydxiWjhkMGbJoow/pdspF2y306zAuyhzMOvJ97Z6MDcSI9jQgSGZBZe4W
 MYnghKrnaX1Zd2geRZLTlAgaX57lvybxlVFcxrZCxGR8+8L6CAIbeBPa+TU5dQXm8J85G7ciZ
 henDOvgAKdgZZ+5rbPAg2QvFnyLeJgHFCLj87Aq3jUnbSadzZHmFrdsb/N8fZqqis7tqoPY6V
 KAWc3kwmE1c6kdkLsesM5+2AKCcl7yti4QnOFb24MQkH/xEq2VuNClpxUPdvAMxNT6/lkLbwL
 m0xSkO6wQ0dNnalh5ce7biQ1gzcujqrgA/Mvai7T43hxuNGquC/vVsBYvmGKtSOfQekowm/tK
 66tBmP0xqri2/BhGGq820WGIIqv8XYKcbJjLuoKeoDfPVWhO7lM+B4iVcsRI2HuMskdEX4z9c
 eY1mxHTvJqrxzAf4pexoF6Nrg05Fj9DMIwGFR/CvRaE3j2KNPreEd39/bEEC4RKHshli3XHZl
 szF1v/kfQszWjUcaIQnFVZcMPK9MTCJLYYAzBsUUxb+bRUFjWhXpbeP9W3cNd/CW1DIIuRSo3
 hZWbuooSuifXNbMh7fCPOpxxVZ1lmeHEb+4Jn/6WlrtNEMzmraumLIcwzo0aEueoK4QqATNCO
 PoPxa5WrO71jQGdHhoeHO6pe64Y9DRTtY2MlC/HyOxjGB7CxNiJpgRwylIJf7bqW3JfVQ2leh
 Ir/KgcuJPojouD/3uIsDRkIDolPw9xYZo0j1nwtrk18rPVGcDYSi81UOIJ2C1nUogMTe4UZoW
 yfkIK4j4BYQTlvw5M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 03:20:11PM -0400, Jeffrey Walton wrote:
> On Mon, May 4, 2020 at 3:08 PM Torsten B=F6gershausen <tboegi@web.de> wr=
ote:
> >
> > On Mon, May 04, 2020 at 01:18:06PM -0400, Eric Sunshine wrote:
> > > On Mon, May 4, 2020 at 12:52 PM Carlo Marcelo Arenas Bel=F3n
> > > <carenas@gmail.com> wrote:
> > > > On Mon, May 04, 2020 at 03:03:01AM -0400, Jeffrey Walton wrote:
> > > > > I'm building Git 2.26.2 from sources on a Mac-mini with OS X 10.=
12.6
> > > > > and a PowerMac with OS X 10.5. Some of the t3902-quoted.sh tests=
 are
> > > > > failing.
> > > > >
> > > > > The Mac-Mini uses Bash 3.2.57(1)-release. The PowerMac uses 3.2.=
17(1)-release.
> > > >
> > > > if the problem is the bash version but you can build/install a new=
er one that
> > > > doesn't have this problem [...]
> > >
> > > My OS X 10.13.6 has Bash 3.2.57, as well, and I'm unable to reproduc=
e
> > > these failures, so it seems fairly unlikely that the problem Jeffrey
> > > is seeing isn't tied to Bash.
> >
> > Should I read this as
> > ".. seems fairly likely that the problem Jeffrey is seeing is tied to =
bash" ?
> >
> > I can't reproduce it either, so my reasoning would rather be
> > "The problem is probably not caused by the shipped bash version"
> >
> > It could be something in the environemt, that confuses our tests here.
> >
> > Does
> > ./t3902-quoted.sh   -v -d
> > give anything useful ?
>
> Yes, it looks like the command reveals a couple of problems.
>
> I'll have to look into my iconv recipe. It has not changed in a while,
> so something else may be responsible for the failure.
> https://github.com/noloader/Build-Scripts/blob/master/build-iconv.sh.
>
> I'm not sure what to do with the HEAD problems.
>
> $ ./t3902-quoted.sh   -v -d
> Initialized empty Git repository in
> /Users/jwalton/Build-Scripts/git-2.26.2/t/trash
> directory.t3902-quoted/.git/
> expecting success of 3902.1 'setup':
>
>         mkdir "$FN" &&
>         for_each_name "echo initial >\"\$name\"" &&
>         git add . &&
>         git commit -q -m Initial &&
>
>         for_each_name "echo second >\"\$name\"" &&
>         git commit -a -m Second &&
>
>         for_each_name "echo modified >\"\$name\""
>
>
> fatal: iconv_open(UTF-8,UTF-8-MAC) failed, but needed:
>     precomposed unicode is not supported.
>     If you want to use decomposed unicode, run
>     "git config core.precomposeunicode false"
>

I am quite sure, that the trouble starts here.
It seems as if you are building iconv yourself ?
And that iconv does not include "UTF-8-MAC", which is a speciality
for Mac.

Are there any special reasons to build your own iconv ?
You are the first one repprting this kind of issue,
thanks for reporting it.

