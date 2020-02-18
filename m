Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7289AC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481D220801
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 14:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bd0DtyVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBROBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:01:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:37295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgBROBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 09:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582034458;
        bh=EPADCcS7vz1FVIXRRP+odY//4qe1GFrfb+E1JP2eoVk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bd0DtyVwDtiEEfdXDjjPnRkibfmmESD2yC2l0+oytz/1sqiWwAwop4AXW+Y0hmoLN
         Ew7xf/p2E7+o2iRRvW7pkwI2lI2rN0FxCQgUbCE5r/LiO4YWuiDtMYeNpOdhHHSvFM
         iVePH9WvU/QMqar8usQcRkYsZgaanUL8h3TTMauw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQv8x-1ir4cH2UWl-00O1bw; Tue, 18
 Feb 2020 15:00:58 +0100
Date:   Tue, 18 Feb 2020 15:00:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/ci-squelch-doc-warning, was Re: What's cooking in git.git
 (Feb 2020, #02; Mon, 10)
In-Reply-To: <xmqqv9o5kup6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002181500210.46@tvgsbejvaqbjf.bet>
References: <xmqqmu9qxej1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2002120036570.3718@tvgsbejvaqbjf.bet> <xmqqv9o5kup6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MhBjNrJ2LGsX48HScbtUD9iR/VrvtathOU4vRJ28qtkyZUkAd2V
 iDejAzsZ6cQ8+PXUtTfEADeowOd8KieSvkcyps41kKEKH4TouM4k3ufAohFr1ug9+HqHgdY
 kv1+NT69Q9SLcEk44NMrepeATzMMZg+9vkjR5ACasGLnWNloiAukOpaDWGo8gKdSYT6vhh0
 xqzLh4lzfA8q35a7eYBVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Wde+mvBnRI=:YqAIZE/lGOkyZQ3ntaSYwC
 +oH9ocSd1iw/CxvZ2VBKvqKRTOBegqxbUtjEWbTOpIlM91vdVPLiwSTINd8+1GSESGvNjpV2O
 YseyMwbcO1Q57lnH2XRzLpnya0g8Om6skcR4uMIO7jbblNDyyE8oV85wOS+naA6Trkp6m41He
 LU0I6YAGAy9PGzkWUDpt/Z5H5SHskpfGG4nv2Li3+HEnXebeHifV5aX+aM0iHn2NV0BXKHrhD
 Ar3032BPhkn2wFd2dGCjhtk5JFVXlTAKe9QZbpJ9/BfwVbiYiujsYl7HHvISw3tpaPWSWppm8
 OOvYZaOOKUnY5obGr6k5GZ9m1Ho2PkB5buf5GdeRtWQNx6yMKq6JUdC6IXu84JNvMqlR57uS9
 a3SQ9aJ2g0HFnxRv4O+CedBavy5ofjl4l8bQS2l65t34ZQsSNijEozp7CLdjkd2ka7Dtm80T0
 3zMBwXLC8rj7sFk3zGNCYc0CZtXSBbFbyLzbqfKjCGiasyvXyqNEAlcmLcX5nzWZcpUYpuCfJ
 QXeJqrBiM6hQq3+rszTSMx2nglsH2fkevQcO3zHJeg6+vmZGRVxYEvY9nLKh+ueA1RBhLXFgS
 zdsmXM5Ik4NyRnM2Wd5PtWeGR6MLMUx6k3v5a5tsLMafB6pAofZ55V7L3kMlLNWtO5tML/Rd6
 lchn8G+7u7TsWYiKql9Zetniye+quipnP742vRld6JI8mXxmwTyOH87x1IIWLgfsIOVRh5Gwx
 w+rad/69DHEO3GSc6YUtqFlUPAIt2zmBddN0PVypGUtjWbGqzOw5b6aSFj61ptsRzR98Tnps1
 W7WNQ/lch7KuHchD+ERk6j8rSURHcAzPoFm3fUT8qBli1wQoIerQXB+JfsHxxkYHurxwVlJQK
 KBCZKDzRlnFWKHohKDUbFxXLU8rMW1VUhhRV30VHaCTQ8z2ZU/3VCjIf8DUqmyZ341FyEnEJb
 04IJYKgAOAUdP0Wls16mVX8C35JcRbN1OyfHnqgBskIDiMigcuESMC1ggCZTCVKTouRK9k5ta
 GpRWHmHPHK7Knerh8Q4AAnBzg+E3p3370iDf4Au1EAjAbmrBvzYxXh5ysuUzCz/SvgHreKaOg
 lUXqSzPv3/RB7OmrDnz7SjHmHTNkzFVZ2PP3Vuwit3BB98HkaIM9px/mELLQ8BmO1j+sTeMIz
 HjmvxADgSdaRIAjtZofgZ29eKoUBRBO6Fu2AdPmngRWH78i83lbOrzwvqFRwunAJONeDt9dhh
 PZ/qMf4mvaWKaC9pd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Feb 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Mon, 10 Feb 2020, Junio C Hamano wrote:
> >
> >> * js/ci-squelch-doc-warning (2020-02-10) 1 commit
> >>  - ci: ignore rubygems warning in the "Documentation" job
> >>
> >>  Squelch unhelpful warning message during documentation build.
> >>
> >>  Will merge to 'next'.
> >
> > To be clear, this _is_ a warning message, but the CI builds are _faili=
ng_
> > because of it (the "Documentation" job expects `stderr` to be clean ex=
cept
> > for some known warnings).
> >
> > As a consequence, all the PR builds at https://github.com/git/git are
> > failing (except for PRs targeting `pu` or `next`, but I don't think th=
at
> > there are currently any).
> >
> > So maybe we could fast-track this change all the way into `maint`?
>
> This has happened on Friday at 4e52c1ae ("Merge branch
> 'js/ci-squelch-doc-warning' into maint", 2020-02-14) and all
> integration branches seem to be happy as of last night (I
> tentatively dropped a topic or two from 'pu' to make it happen ;-)

I noticed ;-) Thanks for merging all of this down to `maint`.

Ciao,
Dscho

> Thanks for keeping an eye on the CI results.
>
>
