Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD80DC47256
	for <git@archiver.kernel.org>; Tue,  5 May 2020 04:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A303620721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 04:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Gbrco6Pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEEEKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 00:10:37 -0400
Received: from mout.web.de ([212.227.17.12]:50011 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgEEEKh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 00:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588651834;
        bh=whzFqkO+xyjmy9pfs7F7Kn8BJgdO1PTvZQmsadtC0as=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Gbrco6Pqf3QWzZorf2uZ1KEdXWpFuXvBMAOjL0TXYa6T8CaG3ltSTJ+8j3QKUNcE9
         blocCTT9va6dQ+WCgXjolaOFKz2suzrGbgk6ZYTM/RrWB1p04pFOAuUlp3Ux9Dvpo6
         YUdjksfdSmAcKUQ063vK35WCavamqkHx2wkb9IhE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Va-1ineSQ02hk-00iDgt; Tue, 05
 May 2020 06:10:34 +0200
Date:   Tue, 5 May 2020 06:10:33 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Git 2.26.2 and failed self tests on OS X
Message-ID: <20200505041033.w2q7h5k7otetfrus@tb-raspi4>
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP>
 <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4>
 <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
 <20200504201944.gh3zykhil3txdwnk@tb-raspi4>
 <CAH8yC8mLvG-wqrws6fnXdnuoLAoDfPqgynG9MKoSnJLhPCYu+A@mail.gmail.com>
 <CAH8yC8nyg6pRStrQxkO6DzqRbLhhza0vx1U1cGUV4P4MQ3jZ7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAH8yC8nyg6pRStrQxkO6DzqRbLhhza0vx1U1cGUV4P4MQ3jZ7Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:2X7dscErS796y3aB5RnQcm5qQYQQHQLw/VSLugY0yMyRpPv587p
 /D8oPA6+JKk2IdzCuJqG4W8gMPNLt3+QL5i9+Mzbh35RWggaC9zQtc58CEUw3+2d1VB6Ycf
 oUHQMcu2ksXTak2ZeX2bQZCr5ELb4zUdZUel5u0fM72FHH2/Mmn43BM+Z0FgM7GZ1noCAdD
 3h03zgH6gPn4APLzNm7lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xmo+3lVlEMY=:SKFHIR2jr86vdpaD5+PUdM
 50/EYsJUrq3Ah1yb2Jk97ypeCRNsDq1bNfoyt2HJvDNON/Rzsq9rtKKDiJYwBTnVy7e+8qxZC
 ElS0nwVMdpa3HK5jcAe3ohtk8y65QV4G0Znxdq9zWVEXWeSkwoBRNhUXce6cX+FWsNzK1ob64
 oJd1BJQnPi6+cS/R+fabj4oMnWQwj4N/v+yAtCT516PYLWLJebcsM5+muD/NBc5PS+I3giFE+
 wtyaF/ArUi72cH72Uxmbw/wfypXq5k+5v9crHA8LzmOXb7kF6NVtfkMbSAuVnYGVVCm8/APFq
 oIj1vYERy3aRCcqMMV6rOITOpQfdxwmYmKBAHtzg/a0fI7lxZ8hvjqjDtvmfpSPgxNOnpB9N9
 VMiQE14JwInAjE7ngXu3AYFVgGfWpm9WM8tri6jjzePNGfyil1+mlBcwi78C7BfCUTrsmYlI2
 vJSpT6kTnpR3OrfWWOVh1gMBs5Tf5vz2ysC5zP0TLFFTh59iar8FP4UFjdMGD8Ib2AhZjmKxm
 ACxHH9qAqyYObyw6cIsPM9HtGRvHYZF906SNopaV9CAQDCcru3sobK427n/DPpu1fM9ie3Dtt
 XoONlqJsLEpmBrsupskR/s9HBMMvyrU44PVj4J5zTUyRrkgbuVRHylUxGMaZR9gnjvQEH/sqH
 TYOXjSZcrd1kIaKGZJOKMibxIVvjrNK9xseAsMU4FHsP6dg5eVcJ3QSdZKqHQG0qPPA+l46vO
 G0wBI25FDPdsq6n9Q/QkuPVUUzBB/I74dRwlz+fqlc3bjpFQHeBnBrozwp45qFjDRrzDAZOWb
 qCM3aPBClUNDoa1KxB/aFMoetl4EJro62Sp5D4qNuZBTolwkKhnnlO5Gk1zgd6vWiy7cFfqYq
 qLQnAf9+eXLHZI6DQYQFnDf4MdW3I0FxHExVd84nilFzATlTwqavLnlDlrGF4q+1yrBG/gqVh
 7zrtC/4+uUqBBdVFxF1TsrqoMWqFyzkOrJx2ATb0zONYx6LPusUoJCTZtLKuSexR8kx0g2c4O
 FLP2eI3l63aAXL7qbd6dDjGiX7zZZZQJL7kA3H07EGrtYeGYXPxCxiii+AGSSlXeoqGr/YMHs
 6ZrliM2LZKvLUzsFzT0XcI2QKqW+eCnbzY0bch/83VAdMJeYB2X1jTWRkca99iXWPjwieRAHF
 wkoqNDAQKKu4GrchPP95z3Y8mOgT2BQw/roxwTYba9Gh3v3Ye8rajTYBMaB7TLmVt9oOUz5yn
 f5XlCHX0SJ67mvsJx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 05:39:50PM -0400, Jeffrey Walton wrote:
> On Mon, May 4, 2020 at 4:30 PM Jeffrey Walton <noloader@gmail.com> wrote=
:
> >
> > On Mon, May 4, 2020 at 4:19 PM Torsten B=F6gershausen <tboegi@web.de> =
wrote:
> > > On Mon, May 04, 2020 at 03:20:11PM -0400, Jeffrey Walton wrote:
> > > > ...
> > > > > Does
> > > > > ./t3902-quoted.sh   -v -d
> > > > > give anything useful ?
> > > >
> > > > Yes, it looks like the command reveals a couple of problems.
> > > >
> > > > I'll have to look into my iconv recipe. It has not changed in a wh=
ile,
> > > > so something else may be responsible for the failure.
> > > > https://github.com/noloader/Build-Scripts/blob/master/build-iconv.=
sh.
> > > >
> > > > I'm not sure what to do with the HEAD problems.
> > > >
> > > > $ ./t3902-quoted.sh   -v -d
> > > > Initialized empty Git repository in
> > > > /Users/jwalton/Build-Scripts/git-2.26.2/t/trash
> > > > directory.t3902-quoted/.git/
> > > > expecting success of 3902.1 'setup':
> > > >
> > > >         mkdir "$FN" &&
> > > >         for_each_name "echo initial >\"\$name\"" &&
> > > >         git add . &&
> > > >         git commit -q -m Initial &&
> > > >
> > > >         for_each_name "echo second >\"\$name\"" &&
> > > >         git commit -a -m Second &&
> > > >
> > > >         for_each_name "echo modified >\"\$name\""
> > > >
> > > >
> > > > fatal: iconv_open(UTF-8,UTF-8-MAC) failed, but needed:
> > > >     precomposed unicode is not supported.
> > > >     If you want to use decomposed unicode, run
> > > >     "git config core.precomposeunicode false"
> > > >
> > >
> > > I am quite sure, that the trouble starts here.
> > > It seems as if you are building iconv yourself ?
> > > And that iconv does not include "UTF-8-MAC", which is a specialty
> > > for Mac.
> >
> > Oh, thanks. I was not aware.
> >
> > I'll open a bug report with the iconv folks letting them know
> > configure has some gaps on OS X.
>
> Thanks again Torsten.
>
> I am not seeing an option to enable the encoding in iConv. Would you
> happen to know what is needed?
>
> Thanks again.
>
> $ cd libiconv-1.16
> $ ./configure --help
> `configure' configures libiconv 1.16 to adapt to many kinds of systems.

Hej Jeffrey,
I am not an iconv expert - and don't intend to become one.
The UTF-8-MAC conversion does probably only exist in the
code for iconv shipped on Mac OS - so it could happen that this
code is not open source.
There may be ways to "extract it" :
Either that information is part of the unicode specification,
and there may be tables that can be converted into c-code that
fits into the iconv code base. I don't know.
Or you can use the iconv on MacOs itself to generate such a table.
That is all somewhat behind my horizon.

For Git (under MacOS) we need UTF-8-MAC to compensate for HPS,
(or HPF+) so that all filenames with non-ASCII codepoints are
stored in the repo in precomposed unicode.
This is what Linux and Windoes and Unix is using, this commit
may give more information about the what and why:

  commit 76759c7dff53e8c84e975b88cb8245587c14c7ba
  Author: Torsten B=F6gershausen <tboegi@web.de>
  Date:   Sun Jul 8 15:50:25 2012 +0200
    git on Mac OS and precomposed unicode

By the way, does
./t3910-mac-os-precompose.sh
work on your system ?

So far I am not aware about any problems with iconv from MacOs
being reported here on the list.
Which problems/bugs did you found in the iconv shipped with MacOs,
especially together with Git ?

[snip]
