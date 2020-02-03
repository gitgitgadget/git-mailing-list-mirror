Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C476CC33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 12:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EB120721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 12:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X/eR2uK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBCMhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:37:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:37891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbgBCMhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 07:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580733469;
        bh=petMNHZ+mNcMFi4uv+Cc0yJE3Kw5Z08VwxfBreZwcGs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X/eR2uK1TqJeojxrHECMv488vEKJNuDy6Gy9mvGmpn6GNM/Wzxqin5mCxg/12Y6bG
         /vt2+jyFnuaqK6+HwbUvA7tTS8STCC2SLwlL2sYA/UaGUvAFn4lS91ANYRRPTI//bs
         yfPDkC3RHn1UWhrL/kphs3ui+c20ulBtWmav7f+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1ikatE0XmP-00Gpsd; Mon, 03
 Feb 2020 13:37:49 +0100
Date:   Mon, 3 Feb 2020 13:37:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Mike McGranahan <mike@mcgwiz.com>, git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
In-Reply-To: <20200203085456.GD2164@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2002031320180.46@tvgsbejvaqbjf.bet>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com> <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet> <20200201110203.GA1864964@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2002012205520.46@tvgsbejvaqbjf.bet>
 <20200203085456.GD2164@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+Qp6+D7dA2JuHeS+XoTW4NDaE/sOMgEo2emRf8jzN8gxf/uSH3I
 cnIOoNf6PlIKeXgJ7a9ALGJpWaX1YKSxyxFjvNz8PoqlhOQVpnqb/3MTWtJV9xiJAF9kH3t
 OZrwBvakV8Ndf8hYoIuTcps2cjE9ehHs3ka0z4bUyslk/gVMxLsS9lhW2Gu9b0ItY4L99c+
 VixGJ0rA8gNgW+hjvJebw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cPMJt/g+4iw=:jRAeEWEdtfcmuI5LAUElof
 Z72fOSxSHmVGUaj3kjuOl0e9nG6DddN9Xwf9k/rvEg8UUTd7zrO5LSFf/jnKMevrzDVmbrGdB
 JJ0PdVncp9eTuqAunBr09MnCZPboga6l6wNl6/VGYxd5aFPtPSWYnwACqfU+akyZjTw20p2ol
 rxxlH0pmUgNoEc09zWMWCluH+7DuQtDaHD2Gs0neVABDKjtPo69Kro8gN2Nu4yWAiPZxh68JZ
 ha/F/iUo2VmfEtVNcixAwnHVSu5hCIgnTWQjwGHekBAcGqctAiwJzUWQOqntDTRr6MaER3mni
 8IYxJho+sIl+frdkLY2FAkNNc9AtRe723kI+m0KF4uA28xLpm2gn/O+sfH52Mk3ndOe5rp5jR
 cFnxqdgjwiaPbebJ/Ga5U/oahW4RVNIvpSCRaLETP4iOVg5nCSSPMY0fPRq4QOkClW9Oo/Fin
 tmw2gAnOIMopXLxDPN/f9tMBm3tCpUVJ37PtEa/lk6kLZl+VR3fvMIBlFD8x1lt72kwR5uJ0O
 K3ZqYtz+mqcHoRCHXLMsrKWFX23EfaAhA4fit0/i9c1xGGj5Q5cEb9r2RycKhCZJwebGtKBB7
 8VCOv/widMGR1VW0Het70pLSU5S5nMNfIwgAm7ufQ5Pv9oc99Jrzsbu/ygmFoWKMCQw5j8QUB
 SvDj2SEzIRxRLZhYftQKQTe3DxJ953Hx+H19degc0Y93P2VuEXApMBPkg9Nf91e1TA7WRYvbi
 foaYEsjPf5SRzXDEOWMAXn9LoIPDHgZVIWCnF7KkSca7PmE/migEa2RDstNXukDXO1rfOKD2s
 IOQhOD0ZweE4pMKSi3VcTRBe7XqQI6oP2We8DnWDxCVIOi510UGzm24SscotwD4erPzi74t7a
 hkKPpHydEpd0K3/J6X2BIWjm+yZBfntCUGEh2lrQjxTW3L64cXSDmCPsbJ+/Y4YU3nH06s5Gq
 9Nz9NkiwycjZefYpibugsqblO+5v5wWlfQ7YSlyLVyIp8jR3uNUP+lo4FfiABrvziziKPJ7n3
 xroe3/4yRQZ9SXZxkyPrqQxht5tIne8v3acYiaRjaAc6YixTAW6uMXq7kEp2XdZCykCD+AxbR
 unzs2/TvwSGw/GlpxWHBlbB+fuodwSWpgfC5yE8XEJ0/U+ynJ3azKnQUDN9U732xmJ/ByqG8z
 r8k3SeCSejeLNtnPKvJfpu8iFQJGnJR5mwCKaFb/gss4fjs1aOF/HP6Q9vQoVWEMaDjBxEKv7
 3se4nFUmacK0ZNXzh
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 3 Feb 2020, Jeff King wrote:

> On Sat, Feb 01, 2020 at 10:06:43PM +0100, Johannes Schindelin wrote:
>
> > > > If my reading is correct, and we want `git diff-files --color` to =
respect
> > > > the `diff.wsErrorHighlight` setting, then this patch fixes that:
> > > > [...]
> > > > The bigger question is whether other core developers agree with th=
is? And
> > > > what other `diff.*` settings should be respected by `git diff-file=
s` (and
> > > > of course, `git diff-index`)?
> > >
> > > I think you can take my posting of an identical patch elsewhere in t=
he
> > > thread as a "yes". :)
> >
> > Thank you ;-)
> >
> > That answer only applies to the first question, though. The second
> > question, whether other `diff.*` settings would like to enjoy the same
> > treatment, is still open for debate...
>
> I hoped you would read the other part of the thread where I mused on
> that same question. :)

Sorry, I totally missed that. Will re-read.

> The short of my answer is that I think the color-moved stuff might be a
> candidate, but it's sufficiently different that I think it should be
> decided on as a separate patch.

I actually wonder whether we should do something completely different. The
problem with `git diff-files --color`, after all, is that `diff-files` was
never intended to produce user-facing output, so the `--color` is somewhat
of a contradiction here. The fact that `diff-files` is a low-level (or
"plumbing") command means that by nature, it wants to control a lot more
what the user-provided config can change (typically, scripts calling
`diff-files` expect a certain format, and it would not do at all to heed
`diff.noPrefix`, for example.

In that respect, `git add -p` using `diff-files` is kind of wrong: we
_want_ to show the result to the user, with no processing at all (execpt
the user-provided `diffFilter`).

So why not introduce a new option to `diff-files` and `diff-index` to ask
it _specifically_ to heed diff UI config settings? I.e. a command-line
option that makes it call

        git_config(git_diff_ui_config, NULL);

instead of

        git_config(git_diff_basic_config, NULL); /* no "diff" UI options *=
/

?

Ciao,
Dscho
