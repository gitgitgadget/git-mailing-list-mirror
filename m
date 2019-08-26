Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CB21F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfHZO5h (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:57:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:35511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732718AbfHZO5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566831444;
        bh=f3oOUAZe4piI1y0smXQ9sbiy74x2g9fSHZWRkPVfBdI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HC2S2LGNw0oL0MsyqfWBxRc6pyOj3uCVN+uxQziN6hMzyu+/v4gc8O3mjGk6IH0sP
         MyaYZNvEBrRqv17oq6PTVe1MNKqeQCOSR1GhS1kcrsLZ1MDPb0jmPcyj+nRppxXbUr
         LIPeKPp+mkXpDifBf43zeYwa4QU4riZ/vj1KJw1E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTjMy-1hblKu2aem-00QQem; Mon, 26
 Aug 2019 16:57:24 +0200
Date:   Mon, 26 Aug 2019 16:57:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: [PATCH v2 20/23] .gitignore: touch up the entries regarding
 Visual Studio
In-Reply-To: <e221aaf8-7d0b-6feb-3f58-1e9e4382939b@iee.email>
Message-ID: <nycvar.QRO.7.76.6.1908261638450.46@tvgsbejvaqbjf.bet>
References: <pull.287.git.gitgitgadget@gmail.com> <pull.287.v2.git.gitgitgadget@gmail.com> <dc4a9cc6205afac03d1154ca935e4334536fa693.1564430879.git.gitgitgadget@gmail.com> <20190825120741.GM20404@szeder.dev> <9eed02e7-7e2d-4ae3-6c08-ab17b3c92fb6@iee.email>
 <20190825190957.GN20404@szeder.dev> <e221aaf8-7d0b-6feb-3f58-1e9e4382939b@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-146101035-1566831445=:46"
X-Provags-ID: V03:K1:lFFid/TwytglOYwzzmoF9fCyyVqkWKaDqujCPdSCs92sZnvWqlr
 e6nIqN94Zu7h1Qo6vd+6/YWkhjwiw+PrhrKUQPdlZvbdvRtoKrCEP+EcOhpVeqg5HykAvJz
 pFyS251qnDzhwNwiiP9+onQCo5KwOJJW7MB9Di8FzvJ0f17gL3BYD9zC6hF3OYeQylrCt+m
 dNa37msMmHPqy1dsExSJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UILFR/kmFhA=:QNbjHdGMZzqvqmmDgmMDV+
 r6nFK/+xCdgalRuKkgTeCr1iSmUl6hFvVzgsZM26w7ammRzC7QV4eyhrvuvmWxP1vfLH94pyE
 KzUvtEsJyvwBOlubZ6zxp5Bhuc7AoZ97LoXNJXuBaD+Srg9gIJGFbXAtR4xH1WOgfijRoMaVD
 tJJ3Yy2BKQD6MfHqTpnMwi+gzk1ntRoYvyM2vDb8OYwXDMQ7Y12OOqPDyN9v9TUVPWuAeU0nK
 V32KVjVzTO6uYqYX9frcPra5OCjUmiKA11S7TVPP6ccMyiNhrie4S/IkAB/BnFqwRkUp0QDVQ
 iL5scDQe04TaIhFpcnSSfx0KGPVw+1eLQmt3zYlsDtZk4rK8IzrKX120QwFYvRMaMfR891TbM
 Hi20tv0khYabLzzV0K8sqJV9ATyrR9XkoxjLNYT4P3nqYVicxyYlnV1hoXS206adzgJ9Loh0Z
 zlcJXaLZuN5pMGKYSmzMbgbm6AxjwsXr+iCfjLVtK7tntu58XVJBRQ955LW5O8ulULsaDmTSO
 I9hiuEm+g9pfsP+qLNmT+v6s5YahaOepLVleXKX/yWSs6maonxOkIkHv8qMGDu3s3WKa5D/3Y
 v6d5cU6X7NlqBPSNIfkcsSxZ+jE1hZWMeZR1q8vy3KPBmZqsqBE6xBa6fpKpqyBmi/EL65JXf
 fmRfyDGUh3x8plnTik+51gz6VPJCr8RR4wb1XLBvS6WxJlsReS+wYXTE29jtPzQpiovsu6w/B
 VZzap+2AvkIRtifxc8ymbtW/dlZx5d29+7kTK7URwAwNdeG5g67vwudYQa1tgBgvw9oNCD8Cb
 GFFg3hnY1xmyNGqFRY+YqleMLT0cPYG5IT+jOBxQFCazpBBwS7KJAq+8ssjff/DB5muE5glQh
 Ra0HLk8dSJBdLw8sNzUMRqKKPBWZZK0XKcdtBFWVYy+f/2JGFBMI93i8+xg0F0vJaiLbgPRCU
 cdVGJfsaWUdvme149+/3LfVaodvOUiB7hMJQEBdUuUdEVE+3EHBf8fHxXLRU6mXXDohmCzpED
 1lqwDBuU5VRyrHmYPkAdGuyFQuotMFLIKatT89xQN9hucTU28KIgKAaso2Bp9WfyJzzkvE6ta
 urWwdOw8VtRP7GHvWiRiIz74woelp6Qj+Gv+V6BxvKWYtx3/lIMZcYUl0JKRFKjPeLwwHrhTC
 mcRnY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-146101035-1566831445=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 25 Aug 2019, Philip Oakley wrote:

> On 25/08/2019 20:09, SZEDER G=C3=A1bor wrote:
> > On Sun, Aug 25, 2019 at 02:20:32PM +0100, Philip Oakley wrote:
> > >
> > > On 25/08/2019 13:07, SZEDER G=C3=A1bor wrote:
> > > > On Mon, Jul 29, 2019 at 01:08:14PM -0700, Philip Oakley via GitGit=
Gadget
> > > > wrote:
> > > > > Add the Microsoft .manifest pattern, and do not anchor the 'Debu=
g'
> > > > > and 'Release' entries at the top-level directory, to allow for
> > > > > multiple projects (one per target).
> > > > >
> > > > > Signed-off-by: Philip Oakley <philipoakley@iee.org>
> > > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > > ---
> > > > >   .gitignore | 5 +++--
> > > > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/.gitignore b/.gitignore
> > > > > index e096e0a51c..e7bb15d301 100644
> > > > > --- a/.gitignore
> > > > > +++ b/.gitignore
> > > > > @@ -230,6 +230,7 @@
> > > > >   *.ipdb
> > > > >   *.dll
> > > > >   .vs/
> > > > > -/Debug/
> > > > > -/Release/
> > > > > +*.manifest
> > > > This new line ignores the tracked file 'compat/win32/git.manifest'
> > > > that was added fairly recently in fe90397604 (mingw: embed a manif=
est
> > > > to trick UAC into Doing The Right Thing, 2019-06-27).
> > > >
> > > > I wonder whether that's intentional or accidental.

This was an oversight of mine, my apologies. That line should go.

> > > > I'm inclined to think that it's merely accidental, because, as far=
 as
> > > > I understand, this is an old-ish patch from times when there wasn'=
t
> > > > any 'git.manifest' file in tree, and simply noone noticed that in =
the
> > > > meantime we got one.  But I have no idea about how a Git build wit=
h
> > > > Visual Studio is supposed to work, so it doesn't really matter wha=
t
> > > > I'm inclined to think :)
> > > >
> > > At the time, it was just one of the many non-source files that were
> > > generated by Visual Studio that cluttered the status list and also c=
ould
> > > accidentally added to the tracked files.
> > >
> > > The newly added .manifest file does appear to be there to 'trick' th=
e
> > > Windows User Access Control (UAC) which otherwise can be an annoyanc=
e to
> > > 'regular' users.
> > Sorry, I'm not sure how to interpret your reply, and can't decide
> > whether it tries to justify why that tracked file should be ignored,
> > or explains that ignoring it was accidental.
> >
> > Anyway, ignoring that tracked file apparently triggered a nested
> > worktree-related bug in 'git clean', which can lead to data loss:
> >
> > https://public-inbox.org/git/20190825185918.3909-1-szeder.dev@gmail.co=
m/

Whoa. At least we found a bug via my oversight ;-)

> Basically manifests are a build artefact from Visual Studio [1], so it w=
as
> just another file to be ignored, from a _source_ control control viewpoi=
nt.

More precisely, manifest files are something specific to Windows, where
you can embed metadata in an executable. Visual Studio auto-generated it
under certain circumstances, but recent versions seem not to do that
anymore.

Ciao,
Dscho

> I hadn't fully appreciated the reason for your question, but I can now s=
ee how
> the general 'ignore most, but keep an occasional' file type can be a pro=
blem
> for the `git clean` filter, along with sub-module repos in sub-directori=
es. It
> probably extends beyond this special case .manifest file.
>
> I doubt that dscho wants to also do file renaming to achieve the trick t=
hat
> added that file to avoid this. the clean command should never be ignorin=
g (and
> possibly deleting) tracked files.
>
> When clean hits a nested repo (maybe with .git directory - not sure of s=
ome of
> the sub-module changes) then it should stop referring to that top level
> gitignore, at least that's my expectation. The commit description in the
> referenced patch appears to get the two parts inter-twined.
>
> Philip
> [1]
> https://docs.microsoft.com/en-us/cpp/build/manifest-generation-in-visual=
-studio?view=3Dvs-2019
>

--8323328-146101035-1566831445=:46--
