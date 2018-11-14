Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87291F97E
	for <e@80x24.org>; Wed, 14 Nov 2018 15:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbeKOB0x (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 20:26:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:54305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbeKOB0x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 20:26:53 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV30j-1fxvk71OLF-00YPCj; Wed, 14
 Nov 2018 16:23:06 +0100
Date:   Wed, 14 Nov 2018 16:23:05 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gael.lhez@gmail.com, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] bundle: refuse to create empty bundle
In-Reply-To: <CAGZ79ka8tpP7Ph_H8rguomPXoO2J6rDoOKAJTa1b6RSowRwZHQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811141619580.39@tvgsbejvaqbjf.bet>
References: <pull.79.git.gitgitgadget@gmail.com> <6276372ad3dc6fa4b9b352abb2b0192a6d010528.1542121775.git.gitgitgadget@gmail.com> <CAGZ79kYR_mQmtOuW7SEZ92K_o0f_C2enJJ1Yt=V3tyvi-A53+A@mail.gmail.com> <CAK8L4uiMHrsdwJz9+rD1tSCywL2kHosx-hKZdS=UtZDHLy464A@mail.gmail.com>
 <CAGZ79ka8tpP7Ph_H8rguomPXoO2J6rDoOKAJTa1b6RSowRwZHQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-233705844-1542208986=:39"
X-Provags-ID: V03:K1:Hur7qiLJ+1PeOwkiDSuUzegLBHVK7r8zEvGAej6Baz0QyixXX2W
 znrIU4Hm3WG0pLk461kD1W5k6Wfo7eU28ewZhnytoM12TOQU+kDVMopx0nr+PqBNwfS9urc
 LhRysDIutbZ93OCE/wLS3326nYQQPoq3OvQXztujJ6r1f4ji9Zg9ZUYxkYkzv01vT5EQauy
 E1apEbbnRnZwMuIgDAinA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IexAv8tDMlY=:By1IOQ9NBh0cINrQUqDf6f
 f+et7KF7zdkkCkc8IJU4YTjf8Z80SbPs3eCJg6hAqfHjaZuYUshfdy3ju2SWqKHCDcvyHizrS
 Wb+JzNiUCR7ugOVXxNhKM5wxGVWUlimrdZIiOckwBxbLI0mY482puW4wjWLXKYBRUG11PGgXO
 /76i1zXMKN6d1SAvdzCKJdwNnZucJD1CnLQEGzUL3NAee/GVJRi/8Sfiz59xWRo9EreYGkND9
 qp03AsgIGBMT3mAt7zPO0QswfvguP681PQIOkdaAoTCv7XhJbx5/Xduorw1wAqvWyMPZw6G7j
 xyO8a3uDzv6xsfScvc8IG7o6PvBk69b3AXeuUIogsRWv1FHEcaYwyktkUOaDn/RjtdivUtj7u
 dTOUm0MvnkkFq4Q8BVqBkp5wh6Edw1c0ow4HCh2ZxbXy4Z9ddRvMR1vdZ3Eff2lDqvIZlm8qv
 VPcZmVomzdCpdBr3u4zbD8tnMfnNtewsgkiMhpKTN/gnbD/0vnv93Aq716IlerddHoILntywX
 Si3sFIBjUeaV1m/CpUVa14UhG3S+H58KuO/PSvirdYR2L6z7DsMs3fcZrM4YKqwGwCN6G3puR
 pz1YWVk/LFtY46/AMZD0YZk6sgkDXSMZnqUXtyaIjc8HazEiJ7Bjgtk1rxwLnDtPxkxq5Feag
 BzRF1r1J2FfqsxzqPYYHwPIvQfmGQwCceEOMOFPQMJkHlg06r2PtIMG3qFct2RL3s8DNWJTSQ
 nr7unDAVUGtkKKiY7sF0tB62gUVNUn+uAIqwnjDN3l9PEsDH/SXmUm4+D/GePvQfvoLv8xZHN
 RjcO43mzFsXCn2mgnISLS4kJeDmv3LGZu7kuJvxzZ1eGavA35Rhpy7sMblT/KwoPan3o58hWq
 hbH1oEyFIO/M8jLM8j9OUlrCvbmYs5jJ16phgG6+7pNgJFhBF4qQJ5kMFvGapvup8y8mx9tqU
 QLTyqStnIAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-233705844-1542208986=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Stefan,

On Tue, 13 Nov 2018, Stefan Beller wrote:

> On Tue, Nov 13, 2018 at 12:33 PM Gaël Lhez <gael.lhez@gmail.com> wrote:
> >
> > Hello,
> >
> > I don't know why I receive these message (and especially now given the time at which I pushed this) but I suppose someone (Johannes Schindelin ?) probably pushed back my original commit from git for windows github to GIT git repository.
> 
> Yes that is pretty much what is happening. Johannes (GfW maintainer)
> tries to push a lot of patches upstream to git and cc's people who
> originally authored the patch.
> Thanks for taking a look, again, even after this long time!
> 
> >
> > If you think "bundle: cleanup lock files on error" is better, then no problem with me. I'm not a native english speaker and I simply expressed the reason for my problem but - after reading back my commit - neither this mail' subject and my original commit subject (see https://github.com/git-for-windows/git/pull/797/commits/0ef742a1a92ae53188189238adbd16086fabf80a) express the core problem.
> 
> I am not a native speaker either, which makes it extra hard to
> understand some commits. ;-) So I propose a wording which would have
> helped me.
> 
> > As I'm not accustomed to pushing on GIT 'git repository' , please let me know if I have something else to do ?
> 
> I don't know how Johannes handles pushing changes upstream, maybe he
> will take on the work of resending a reworded patch.

He will.

> Let's hear his thoughts on it. I would guess you're more than welcome
> to take your patches from GitForWindows into Git itself.

As I merged the patch into Git for Windows' `master`, I consider it my
responsibility to push this upstream (unless the contributor wants to take
matters into their own hands).

In the future, my hope is that GitGitGadget will make contributing patches
to the Git mailing list a more convenient experience, to the point that it
will hopefully be pretty much as easy as iterating a PR in
https://github.com/git-for-windows/git. At that point, I will ask
contributors to do exactly that in order to shepherd their patches into
git.git.

Ciao,
Dscho

> 
> Cheers,
> Stefan
> 
--8323328-233705844-1542208986=:39--
