Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99549C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD472082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ddkm+4s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBDTEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:04:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:44109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgBDTEo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 14:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580843074;
        bh=KUfVsmSGdtA8odY3qYjXkJMtrPRoJ6O2VBPP1iAdxWI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ddkm+4s4JF+6M0IstP//Tp3QtXuQiC0on6IM8xffv+cqvXclfh4M/0hfOADoy100i
         mI+eIKsuHJc9luNnVRXxS5Iw3olpSzdtChwKdw1BS+qHQhB/2vzm7VY2k13DnZUndl
         JOE/fiwdZyniVHFb3ey8Ge6/xPbsZ4pp9Ra1Rnyw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1jjLnV2eDb-00yRkA; Tue, 04
 Feb 2020 20:04:34 +0100
Date:   Tue, 4 Feb 2020 20:04:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Mike McGranahan <mike@mcgwiz.com>, git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
In-Reply-To: <20200203145155.GA272077@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2002042003320.1058@tvgsbejvaqbjf.bet>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com> <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet> <20200201110203.GA1864964@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2002012205520.46@tvgsbejvaqbjf.bet>
 <20200203085456.GD2164@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2002031320180.46@tvgsbejvaqbjf.bet> <20200203145155.GA272077@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kvD2kJOOAraS8MIRi8CArbsBX/55H8ZuVWse4VWwbPebRH0SHvo
 DFb+RHFTiUdJPBf5FoNj3YbS45GCrGMZuTG6QoWKi9ygUn0+SWXCcxKUkjQaRjqAfDAjO+o
 AGJKthI1jq6GIS7/8VL0ymoFhZgeoHd60o+XvYYQMZrPB+9lhEqvksd91lkeCZpzQ9uRB32
 3tAc6Mywqwb1ZRNiqBB5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5P7xvbPS3OE=:a7tjUJofyQo6DyQUJziDSo
 3l1v7YUGiX7iZDiBDm0iyEhA8i7yAm6fa3HUAqlgHEdaxsGKD6jiBOBZ1QeM6lMHk6qqGMY7t
 AR3lUyLQvIoiXDSOYB3ZZpi5240Vj5B8X/XQ+vbhgi/8R9+yLnToGXo4/Lfbn4l+Obawa85Gm
 OnsJMNgobf4LmB4/u6Ogof+V7Mfni+6cMFuUpIS5UtPmlX+CPBmAN4FutQORkes4D0+38MF+x
 Hgnyk1KBt+hVfiqjzmbf7HV5j9fj9zsR8LBUQTFheBu6WsKAH0YYHYvAzw9bxA2XyXFXLuTty
 qRsqrOcRHLBIVQMj4v3g66h4eQy3pPxLSU+i6VLiJhHNonc4Smaxnq3UpCncNOw8DIn7h3tTL
 M/vIZoVgPrMmLNwZHaXkrWW/hUJbkf11R3RvGVkX4Ec27Czxl2K/dXOCuB/4P5WybWYrvrvnM
 bUiRnyovyDcpB4E9Edl14+Ke09JJRMSQJt8pEYLo+xe6SwsqxnTJIzQGMghZ0OgdunC6j2AuM
 pBWa2Vm6hJrwOmjZx6rkKuqFCaBAG2R/556CgP9HnERe+eM3ueO4jLGJViIetVwZulJCv2cUj
 Y6/T+7dZtgEhSM+GRGdI9jQ+BPZq05qkVroj8QxMIHXRPaoFw23a2HeXcgSVH0aMEqEFGeXH3
 qu3VFyBtCT8aHbUU8rbe6EQgRSUNii4fhjAy6ZBuhXV3znD0POJxiVoUWOE8vV6PJ9c1M/Iib
 va0OpgPRAXkpPI1Gg7qeKH/bi3aJl0My7wNNTX+d6hFZUK4reDbbB25XlHMrIgM2nrkGJlC8o
 Dreq+qV7iqR7Phbu6jwhoHpNVP6DSzpM30tjW7dIDkA2Oz4iWfVaWQokXAGf+KEKw2AMElXE0
 d5LSxAmc3UEwr5VG9QkDdWdiGVeitpICl2yb89qYsIgHVrdkciDcPVS0sZnvZpStirVrWyAIA
 zgtfZCpp6/roolFq/Cv5fbE1koSDQEXVp/CjO7cwe749w/9IhfH+njd8/fheusljILUGEUfqp
 0MNfEBG3zpOyHrJcypTRCw7eHMoTmS3iyhkvOkaAw1V+ixP7qvXNfgwpptZ89hy0KBdhR4LIp
 kdrVSaayBpDk43GvBNDFoyBrDytP4P4OHLCFPH6d/3Eryvq/Ew4ahpw9eKS5Kpy3TRXbRRWrp
 g9ljhNzNqffMkK/4fSEzDNkCg1FuoESrOFcFoxlAS9xdqfdqvOuw0lje1CMwwuTIMLbhQ1ATp
 umOM5XhnYuDvhp8u9
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 3 Feb 2020, Jeff King wrote:

> On Mon, Feb 03, 2020 at 01:37:48PM +0100, Johannes Schindelin wrote:
>
> > > The short of my answer is that I think the color-moved stuff might b=
e a
> > > candidate, but it's sufficiently different that I think it should be
> > > decided on as a separate patch.
> >
> > I actually wonder whether we should do something completely different.=
 The
> > problem with `git diff-files --color`, after all, is that `diff-files`=
 was
> > never intended to produce user-facing output, so the `--color` is some=
what
> > of a contradiction here. The fact that `diff-files` is a low-level (or
> > "plumbing") command means that by nature, it wants to control a lot mo=
re
> > what the user-provided config can change (typically, scripts calling
> > `diff-files` expect a certain format, and it would not do at all to he=
ed
> > `diff.noPrefix`, for example.
> >
> > In that respect, `git add -p` using `diff-files` is kind of wrong: we
> > _want_ to show the result to the user, with no processing at all (exec=
pt
> > the user-provided `diffFilter`).
>
> Sort of. The problem is that we need two matching copies of the diff:
> one to apply, and one to show the user. They don't need to be
> byte-for-byte identical, but they should correlate at the level of
> individual lines. And the "one to apply" can take on some user-selected
> options, as long as the result can still be applied.
>
> > So why not introduce a new option to `diff-files` and `diff-index` to =
ask
> > it _specifically_ to heed diff UI config settings? I.e. a command-line
> > option that makes it call
> >
> >         git_config(git_diff_ui_config, NULL);
> >
> > instead of
> >
> >         git_config(git_diff_basic_config, NULL); /* no "diff" UI optio=
ns */
>
> Would you pass that option to both of the diff calls, or just the one
> generating the human-readable input?
>
> If just the human-readable one, then many options that change the line
> count would be problems: diff.context, diff.interhunkcontext,
> diff.orderfile, etc.

Darn, you have a very valid point :-(

> If both, then some options would be problematic for applying. Just
> looking over the list, these jump out at me:
>
>   - color.diff=3Dalways would obviously be an issue (though TBH I think
>     anybody doing that is inviting a lot of breakages anyway)
>
>   - diff.external would be a problem if it kicked in, though I think it
>     would require --ext-diff to actually do anything
>
>   - diff.submodule would generate diffs that can't be applied

So I guess it is back to your patch, maybe amended by a move of the
color-moved setting.

Ciao,
Dscho
