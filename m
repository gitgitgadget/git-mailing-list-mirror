Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8856DC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB0060724
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbhIGMty (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:49:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:36263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhIGMtx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631018923;
        bh=DLPmm9REA05HO12unqFejJObOl5W3FVXCwm1IKmvFAA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LL6ztB0N1geUvgLHUTUeedJndi5vwqhAdHn0745fwspXnufPGdmwUvUHjoPT50rsC
         ES79VGhZyrLMs9dYGlr+fS3bvOivUgW5x5oO02kOrNykOFTd8RwJ+MqxxkGyjff61d
         J3OHEy5fMvug3C8yRcnQZAa12rHWTrfSN+IzxoDY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1mVFVf32d2-00Rcm1; Tue, 07
 Sep 2021 14:48:43 +0200
Date:   Tue, 7 Sep 2021 14:48:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
In-Reply-To: <62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109071444260.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1492049009-1631018939=:55"
X-Provags-ID: V03:K1:MdFoLQAazuO9eIW1rGF20q0wwjsLEdZ7GJeWLCqvGIL1LmyGokL
 Zav6sKX0IPYjT6qsa74SumRJCrRRUJSE6cufgrnafTmfRwCBncC108/iR6aAZ/5keO47k2o
 QuFYuvurLzNxnXoQlGtSwMYHayMgKhUMjwEDm20cxlRBVtI4+uvvXUiDZi5ipwPtxqiEhpo
 KPwpSAg3kMMBBxRXGa+Qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R9Q1w4TF71M=:UQbNWnmNDJ1r8EM6qA19XL
 GWnD3UzpPotq0mqaIk6khUHHpFdERzeQyxVzdNmKLdVpm67bV7L3sJIU4enenPnKvqFOQW1Us
 o0WYAjPuy/K5uYeRcVMMl308h9vl5xrdOuQziXz4OyplyBD4mxDxHD9FxirpGaS8Gvk0HV97f
 NQVOHp8yWVgAelBu/6cFhFciStLlyh1bGIWq0M9NHXJoK/a1wT5X4KnWDlG6JU96GI6nKBOGX
 ZCWBx+HY8jju0KXjg3SEPuKhRJUL1Ybo96yL8Prry2WqE4LkCyn+urVBOJ59Y/hfCSrUQxA7r
 A7jZOuQj1WdimOGtMUwjEacFM55xwFB7TBux29bURGgUoziHOHopOfB23ESXUIX5kB3xn+q8P
 dFQjlpcjbT7SYSUkus7bTHKgnQ6Usv4kJkPd+090uC4e9rjVS14RlDSAR3TNy5xA0mocVfIcN
 3RNNDi7X8CzlH25D6ete1omGAO8PDunclDtSz0kQyoko34sfYGCO06xYUoDwoLlW/t+uTUVAN
 6urd6QCzS6EofhrV6U4OKBpIV7/FAhXpcII/wf90RojXX4p6CDt+NU19B80QmbP6w2H+kytcR
 KzASEFf3byLWDeldYnhwYssuJMMdOAjnmr/cwnaoBHcHp6mx9ghVPar+ao0zia+8xUj4B41rz
 GSwD9BNAahgf9/evkGaQf3mCrjJ2wX4Jvzs48tX3rP3s0uqKd1rvGgeoVxwZj1jqD+K06BcGg
 betc/byMi9ToaWWFhAABKbeFW6wDXiQoVWAVlYXPupwZEyaDeMvJIgdBE/WSNnFhK8qDiDR+N
 fCm69MesNK54WMRg6qVSVgMJpsoimwZ/ha+q2/UsO+FOhobGQVbkDrCEyzPj6v/xCbEF6Ov3s
 umfhwMxGhVcGlOZiWbldFkAoB9oYPuadQtu8lSaRFGN53vUZICsTyOG8Fdy7XlZVxSEUhliKA
 HX/iCoUW9ZqH3gtaz4WxoUWLhzsPbWekCjIaa0mZY1KZWyoYYAWdlH0E2mCPy9nIeLYIWX1ph
 OoixGwf8W79377GHZ3EnpD0cJ750DMocN0f24hF9Ptf/8rYaswjunjdHNUUFdsNSLfiuSEVd2
 hhscadwGDOfFM2fX32ShdYqDA264dk8PNuWcSMc2qrYwsu0ig46gQbn9g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1492049009-1631018939=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alban,

On Sun, 5 Sep 2021, Alban Gruin wrote:

> Le 01/09/2021 =C3=A0 13:57, Johannes Schindelin via GitGitGadget a =C3=
=A9crit=C2=A0:
> > In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (whic=
h was
> > included in v2.22.0), we officially deprecated the --preserve-merges
> > backend. Over two years later, it is time to drop that backend, and he=
re is
> > a patch series that does just that.
> >
> > Changes since v1:
> >
> >  * Rebased onto v2.33.0
> >
> > Johannes Schindelin (7):
> >   t5520: do not use `pull.rebase=3Dpreserve`
> >   remote: warn about unhandled branch.<name>.rebase values
> >   tests: stop testing `git rebase --preserve-merges`
> >   pull: remove support for `--rebase=3Dpreserve`
> >   rebase: drop support for `--preserve-merges`
> >   git-svn: drop support for `--preserve-merges`
> >   rebase: drop the internal `rebase--interactive` command
> >
>
> This is good.

Thanks!

> preserve-merge is the only user of `rebase--interactive'.  In
> builtin/rebase.c, it is the only producer of the following actions:
>
>  - ACTION_SHORTEN_OIDS
>  - ACTION_EXPAND_OIDS
>  - ACTION_CHECK_TODO_LIST
>  - ACTION_REARRANGE_SQUASH
>  - ACTION_ADD_EXEC

Makes sense!

> Which in turn, are the only reason for these functions to exist:
>
>  - transform_todo_file()

My patch series already removed this.

>  - check_todo_list_from_file() (from the sequencer)

Good point!

>  - rearrange_squash_in_todo_file()

This was already removed by my patch series.

>  - add_exec_commands()

Actually, this function is still needed, but its scope can be reduced.

Thank you!
Dscho

--8323328-1492049009-1631018939=:55--
