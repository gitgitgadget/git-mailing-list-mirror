Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C7F1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 11:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeIDP3P (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 11:29:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:49769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbeIDP3O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 11:29:14 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LanoO-1fUewy25hw-00kNpu; Tue, 04
 Sep 2018 13:04:32 +0200
Date:   Tue, 4 Sep 2018 13:04:31 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] ci/lib.sh: encapsulate Travis-specific things
In-Reply-To: <CAPig+cTYwnEt3_EoMZq7U265nEDRJc5uCtJbuVeBNTxqvWSPww@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809041259480.71@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <18e6beec5f48ad5a17c7c7309e0507b01a53c2ec.1536009027.git.gitgitgadget@gmail.com> <CAPig+cTYwnEt3_EoMZq7U265nEDRJc5uCtJbuVeBNTxqvWSPww@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QsXfw2tLnh1q4EKtwoGUTfTSNFK+i68Gq2CAaqhVKT6pIyuewc8
 4rM6MCHD9GJPra7hG3oxbs3ipzA37U+mBlaXtOUiXG74+O5nH+aZtZgvD11Mge+mYdPPRhj
 yAl1GoLCvW1aQUBFPu7eH5qP7k6InUOo6kqhcPpA2/htq+KgLi+am2zfV+96z/E9vOMCBvq
 +9YMnFmUaaAez34GuBQUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WxdzrBb5/7o=:NcF8Pd4cedEaaHNDt7hI1T
 xk3Rc9eZEwV7Q2SjP2c0AYWLAgFnPzHHUQOthRLEeXafhQVQB0TzPxKN7scbqzvmr6aSWqMWF
 K99vkEQNk8AJDqdAWtXgw0z1EWwTv8nkc2V92AJkF3Lc5yV8F08kdd/JaGAhZdVdasdyRuqME
 qazV/SXQGzWKzcKhCQAaZikex22dPvvA2bru+0VPpTE28wNd0/ADVr+R4HQ2DNpNXnkv56bEq
 DWEsg/y8HKsKlK7ZKMDSp+YNMDM2Jz9kVHHSO3aZKKGMbnB0w+TauzD3Hn6SzRIGFHJVpFag+
 VgTov0mf5mxmsvhWzvv51X6tmOT0+fvp2Ey90lKoAwT2cwyw+N8TmHRDzLpm8gitq1JKUYCuJ
 TeSxk4sZJLJWDTkX3sMnjaifJq1n2qWdhi0ymiMfTyRuZWhBAV4I0wTmWuOEHZP7uOoW6nrz+
 7slAz4gttt26WGJJ6TExb3ik0VwdL2ai6DWGgmOckHZp00RFpnaqD7yimaF707KnurNL6/XXF
 HrEVbauT1m8wKEVcKujJHy6x3e9PpwXWqfFSRFjOaDNjo8vXJ8krKXvJs60xd4pZDZl3oTbX2
 WsMmyN1L5U6h2repgXJEl/2hToN3crg0hJd4qvGGcFdu7JnvLPL/K4JRv5Jjxc8Vied8E1lX0
 7Sb8n0BIYJaZsW5aW/9n29KfKNBA2k4xCHOKbwtjNqKc9oeqaroaMXgBEqqG2bL+KR259frVb
 pSZ49n4HjaqPRzgmsgTFG+Dt8KDhuAwqGl/dFNGOfqIrnWglE9s/MZ0mKT1VShzWRP6s4c66d
 6/+c44Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 3 Sep 2018, Eric Sunshine wrote:

> On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The upcoming patches will allow building git.git via VSTS CI, where
> > variable names and URLs look a bit different than in Travis CI.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > @@ -28,7 +28,8 @@ osx-clang|osx-gcc)
> >         # Uncomment this if you want to run perf tests:
> >         # brew install gnu-time
> > -       brew install git-lfs gettext
> > +       test -z "$BREW_INSTALL_PACKAGES" ||
> > +       eval brew install $BREW_INSTALL_PACKAGES
> 
> This 'eval' is unnecessary, isn't it?
> 
>     brew install $BREW_INSTALL_PACKAGES
> 
> should give the same result.

Oh right! Fixed in https://github.com/gitgitgadget/git/pull/31 (and I also
opened https://github.com/git/git/pull/531 to verify that Travis CI still
works).

Thanks,
Dscho

> >         brew link --force gettext
> >         brew install caskroom/cask/perforce
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > @@ -1,5 +1,26 @@
> > +       BREW_INSTALL_PACKAGES="git-lfs gettext"
> 
