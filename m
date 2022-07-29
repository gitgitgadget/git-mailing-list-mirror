Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A6C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiG2NZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiG2NZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 09:25:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C31EB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659101093;
        bh=0b/ZRChEx8U+uOscar4XTJnAVU9RlficQUDfu6WYqM0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c1R32i36gaZphSqfOO/8IV4tfG2e07B8+2tcBaSbmbjCUF0LxdHBT/e1VHTW4YLzE
         Faj+WRGvz8vRnWVTvjC57P3OyCGRKXX3sp62nhSYDr/QjhGTxxqRPLRVWc8e3uZMkz
         cm4fK7pBp+PzAXOWw7jKwcB3KCedItyNBG0AfjvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.244.62] ([89.1.214.237]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1o5UqM02Hr-00P9KK; Fri, 29
 Jul 2022 15:24:53 +0200
Date:   Fri, 29 Jul 2022 15:24:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: re-mentioning --preserve-merges in the docs
In-Reply-To: <xmqqwnc6fcik.fsf@gitster.g>
Message-ID: <084n300p-4qp2-qp6n-232o-qs7po3q375n7@tzk.qr>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <pull.195.v3.git.1631048712.gitgitgadget@gmail.com> <2d7a4a2c564aaafbf8da97cf017766163c77b70b.1631048713.git.gitgitgadget@gmail.com> <220721.86wnc6s2uh.gmgdl@evledraar.gmail.com>
 <xmqqwnc6fcik.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-67386799-1659101093=:223"
X-Provags-ID: V03:K1:LF39r+vcJhpwPHnF0CxU4TMAVZCdGFcatEhAc90qIEyLNTMuu5/
 eUUygeDqsTcyQ/86Wypm+rI679oYwYVLAs0+TFZLO3c7eqDn4zMloPQANZgPXYUsvPSaxCK
 pjI+NXQY2EC8LO+NcUvQoafDIcvp0s0MhT6+mVhqH52JjZdFEut05TeVm3Ch3ZepUiB3ud3
 MmaTqMS3Nqywzhh+9VMGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l14I43ukG+w=:PGbL99h7Xs6GIs9iBVkJxT
 1RZw+1+idYK0v0t1dY42FfqqJO8ImunLQCrRoVq5koF3oBDO0ozPegH8393nRWa/IlfHlP1aY
 P1z05knjunKxGp6DknHb8ZKoZBI/GGrGDJYkk7MuanMZc7XcdQt32qGUCXmXwrKfED3G3VL+n
 KwYfT5tmDZqMZKISgiE78CzHkAlfLXcXh8VjpagxiLkFvMN4Ix8yrk/NWBMj4cErZ9f3s0gwg
 dDoKIjDaBa6QW5R07t7XMJSKIanluKMr/nJ0MzPZWIP8H14JeAu+1WRGUa0wQzeFI6oLqRBe/
 dNftC0z1hgyRRd9En5z1t4eqm6Bnccctaq6JK/GTqnS9Yr97Xqk4nSSRiLxBIGi7gfHWlCdlG
 VYeFAXvunTcXB30EvT7GFa59l5AQbdZTgt3pkpV7DwhWl5DW7ZUvRGsrJ/fPpoy2GJgXfVsrR
 B0R8GqHPz3kW7Z3mrQIReywkxf9JEQGcEb7cCVv1dEWcI1wZ31hOvPL/xbGIXZxvLAFgeD9MN
 vLP/HDpbYNzM3mwxUiI+ItQmyGIIQeJ9R0Zz7n3Toa2HYdhkX3J+pBCYOo1mtjc7VzQmuGtbx
 Y1QRildvealfu4d/M2umxtGsXX59EM4C7Oyz2uPgt/BuFSti7Fvi4+KyEHdgIMMyvxi5oHQfm
 pJDS3MoInePFVOeb6KQ6Mr4OGvTf0H0vg2qQHP2tto94KBNgX+XA8OIbOnPsRr5PgqZixxNyd
 2LAVAjCSYHg2L2n+MNwiDnU+AT8aaYw59gJsX/ZxWH21DrkQ2x9stj2/IOb9CC0Q/g72M2anU
 YVpNIMvOvIwKwlsb4bVSxR9MSbYE1bHWEWoCB6HZPn1T5UnrnjKQPmsmWJlrMt62jsTCvyorz
 jrr01zxp9Fs5NNAOsLC7s6ZsTW6V9LplIYlLEUJVbRtzYs3RbNUT0BZ0oNILMS0vgROrfa4pv
 2R+J/Zeae5Vdr1o82aaxD5dyceeT4AA980ayYPvke5c8prgNPGenutsKQpu5K5dxjTNRNNvYS
 1PWZCIyFRiF8lBik4nBPx9e8rl2F9SG7RCvBZ26I9hs++yZTph/yC5oaqimbpkXrLq6BK6iik
 XrZS7WLOb/pZ+uC0V5V4anq1QTaQpWSd09/Z7VTJEgL43gXnVTsNsXdvg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-67386799-1659101093=:223
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 21 Jul 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Tue, Sep 07 2021, Johannes Schindelin via GitGitGadget wrote:
> >
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> [...]
> >> --p::
> >> ---preserve-merges::
> >> -	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
> >> -	instead of flattening the history by replaying commits a merge comm=
it
> >> -	introduces. Merge conflict resolutions or manual amendments to merg=
e
> >> -	commits are not preserved.
> >
> > [In reply to an old commit]
> >
> > I opened "man git-rebase" today due to an on-list discussion and went
> > through pretty much:
> >
> >  1. /preserve-merges # fails
> >  2. skimming the SYNOPSIS, forgetting what the new thing is called
> >  3. Paging down, eventually findinging & remembering the new thing is
> >     "--rebase-merges".
> >
> > I wonder if there's objections to reinstating this in the docs
> > somewhere, just as something like:
> >
> > 	--preserve-merges:
> > 		An old "rebase" backend which is no longer supported,
> > 		and which was removed from git in version v2.35.0.
> >
> > We don't do that with all flags that we've dropped, but perhaps this o=
ne
> > was well known enough to not leave readers hanging...
>
> My impression is that we consider that we have done so already for a
> few releases by keeping "DEPRECATED: use rebase-merges", exactly
> because "this one was well known enough", and now it is time to go
> one step further, i.e. drop it from the document like the quoted
> patch does, while recognising an attempt to use the option and
> giving a custom message than the bog-standard "unknown option".
>
>     $ git rebase --preserve-merges
>     fatal: --preserve-merges was replaced by --rebase-merges
>     Note: Your `pull.rebase` configuration may also be set to 'preserve'=
,
>     which is no longer supported; use 'merges' instead
>
> The next step will be to drop that custom error support, I think.

Fully agree.

I _could_ see us introducing a sentence in the explanation of
`--rebase-merges` that leaves a historical note about superseding the
now-removed `--preserve-merges` option. But such historical notes tend to
go pretty stale pretty quickly, and eventually cause more confusion than
clarification.

So just like you said, I'd rather not re-introduce any text mentioning
`--preserve-merges` into the manual page.

Ciao,
Dscho

--8323328-67386799-1659101093=:223--
