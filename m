Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D4920248
	for <e@80x24.org>; Tue, 26 Feb 2019 19:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfBZTwY (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 14:52:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:38709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbfBZTwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 14:52:23 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8ZtH-1hC6zK2qKx-00wGrg; Tue, 26
 Feb 2019 20:52:17 +0100
Date:   Tue, 26 Feb 2019 20:52:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com
Subject: Re: [PATCH 1/1] tests: replace `test -(d|f)` with
 test_path_is_(dir|file)
In-Reply-To: <CAL7ArXoau1ZfBsV9JaUDprwjSijyo6K5d9JyC1mdfc=KEvgJxw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902262051080.41@tvgsbejvaqbjf.bet>
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com> <CAN0heSqSp-a0zUKT5EaGLBYnRtESTnu9GKWtGARz2kaOAhc1HQ@mail.gmail.com>
 <CAL7ArXoau1ZfBsV9JaUDprwjSijyo6K5d9JyC1mdfc=KEvgJxw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-628463197-1551210737=:41"
X-Provags-ID: V03:K1:8aprm0fo0dweCJRLQEddA/cVo8IffZBSbwuZcAQ0NCz3NavW259
 P1XDYIeBtuPvEB9Z6DVvKSvP6NvcWbC0PtwCTGQOru3A43lQ88fHm4/3QBOYNXmzMi4zGpF
 SRhNEkjCZhwXVB4q8DZhIaiG1GCAwRxS2/cNl5yq967dJlhejHMYhkxpdXrRdM3ySsDJPiI
 tPEaAJk5J6PiXrdSO96OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X0We07oBkag=:H2oD+9La07g0Mpj9fe5ZFa
 2HShIJrkCF7SiU3wLR2Uzr9vMTya9YrPKx6e25UQS0JJJ6lpqj1+1VhHYxgUXXtRrrYwjQHzE
 KYgzMvpaYmEh5bceJYSUl4Oxex2Y6rYC+rKfnoIdk1kLL4W4yWa+Mep1lvPQivxNJWsgdZId3
 0utvgw2AZdeoDxgOKUi3shMyEzBhfe1iX/Cjv/eFyGa/w/N6Y/lKNKX+9WEB1Uoor15SONBBu
 G859RW4HCG0mQRS7iuFyGGvZL35PsH5M4WJFJqB41W2s52ZFvrHyv3zg++YsepYJipCte/CRC
 +Mn3bQEQ0EfkdJDfIHH0+940F8ljFSg+JFWUZikLGUUQrgDF6Hmr63G31nu+damP8IVjJvME6
 uyDWdO5e3kanO/oXozJjZOHI0ke3KylqK2I/6C189EgehVD/jTwqfM0vvoSCqnFxjzUmTf7dz
 EKBtW2VupwZHmWcfDONqiK40Y+GfJn2Nq83bgm6285gh0/2X/d44Mu9u5DpKj8QIFp6bsplYX
 OQcIiPzj3zK3l4+jJyoC2FrSqqw7QvBno0d4Eb7Ja6krVZRs1CCy1+ZdXKyLBnN230Uq0+eYb
 73x7Yt2CW1QqzopSB3LElKb8++dfBh4Wv6RL4egSug3wCq85xAJtkMAWUsL1p4vxIQNsotZCG
 ZdBzJmeTroRcxjrmc7xsSMD5kyQ8HEmQLWN2CpzQ+o441EKNq0Ya8uC2nKLbRcaf9OiuQIEzB
 7soGuIy/t3J0UnIErULIXZQGATiPSyyBKpfdf1UyPR1hufrId2FIPns4azbrI+Z3hJvYH9/UU
 99xxngJ2OmrHuudSpeAYoWcPP9MQJkrtPnol2YH4oDRHF+DgybQveqtYOR3a/QLRU0nTvqW80
 PjPWr5nYfKGr+g04WP/Zr/c8U3ld9FKQjM81ozNeWDx0WFMmMCIzeq7KW4xFG4wOo8y74m/tR
 voYjiBn+W2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-628463197-1551210737=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 26 Feb 2019, Rohit Ashiwal wrote:

> Hi Martin
> 
> On Tue, Feb 26, 2019 at 10:01 PM Martin Ågren <martin.agren@gmail.com> wrote:
> >
> > > -       ! test -d submod &&
> > > +       ! test_path_is_dir submod &&
> >
> > Now, here I wonder. This (and other changes like this) means that every
> > time the test passes, we see "Directory submod doesn't exist.", which is
> > perhaps not too irritating. But more importantly, when the test fails,
> > we don't get any hint. So a failure is just as silent and "non-helpful"
> > as before. I can think of a few approaches:
> 
> >
> >  1 Teach `test_path_is_dir` and friends to handle "!" in a clever way, and
> >    write these as `test_path_is_dir ! foo`. (We already have helpers
> >    that do this, see, e.g., `test_i18ngrep`.)
> >
> 
> Yes, I also think that it should be corrected and I think this(1)
> approach is good as it resonates well with the existing code. I'll
> start working on it and submit the patch as soon as possible.

We already have `test_path_is_missing`. Why not use that instead of `!
test -d` or `! test -f`?

Ciao,
Johannes
--8323328-628463197-1551210737=:41--
