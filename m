Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEBBC20248
	for <e@80x24.org>; Mon, 25 Feb 2019 19:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfBYTVU (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 14:21:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46282 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfBYTVU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 14:21:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id 196so4909568pgf.13
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xFciuKTe99UO2TRLj+HAgGuUn9ZcXt6aFBY4n8PAwrk=;
        b=NPKHxMEPRl4OnZXtHyJJU1Ie0dv2TZ5VVp7DTli2S1lHRpIMnNxk5MdJzpAUFA/Tw8
         tKtRCKggLO8HzQer+Rb4eD6PZ9hdxGWGszYVwTH7L+2TTNLfj1sqwnqVxVhGhP2PpQK2
         4zZknfPVl27VtEVb12g9QQinrVmHrKBKVM9QcKCeMO3Bh9aG7IndZ5oukIKsYwH3perl
         Xr1XZXQUNlrNhxccTGjSaN47V1h1pu/ttmHMXmgj5ljvZthZ6/j4oLFi5U/+fCiJflHF
         VL2lGlvGE3cwDTKD44mzAUmIk5jzDQeoKMVLEt7C+fQOOEGUpVFVBD34H36lYqPdMUBz
         pXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xFciuKTe99UO2TRLj+HAgGuUn9ZcXt6aFBY4n8PAwrk=;
        b=O1+u0PHLeWCuXenYfP5lHHgfEXJSBrjNYE+z0zOzneutkmtpJvFZ3IkPPfv8zv8GxQ
         dgBQJFownc1+Qadg/kJdBaTcAlOm8Y9Me6/wPKso0nD/CvvNtvKTwLJWvMcvyU0bPcXB
         AQz/YDaBuGTRcjAPaU93JxjbN6WMpcJZOcxMPfUpn1iaDK+RmYGSVLnudohIgv0FWMAa
         s9kynZBVlkBhYCofSYSVy++8uO/HVD2ONYG2aphKV+mGgD/PfBSuG2eqG1jN1pIMpLQx
         T/oBXCNDg9nHq9aUErUO3XnIc8fCtkgHK7F1R9+NMiexoJNCvMHjt9TqDKmrY11lgBhg
         O0lw==
X-Gm-Message-State: AHQUAuYX0d9S5N88BfI21I02J1USbw+8QSQCQwW/jFi/eRRaoPVccLUt
        Yw26IaQPWjNXY+W0n6L3u9vrq+RX5WiBm82kseMl/4gq
X-Google-Smtp-Source: AHgI3IZUQ4z4IXPOqbUWjacLBuq7+S+DAXd2PJpAyjFPHDsvXOhy+4GfTcBumrCfhpL2yv8c+pU/zjsRrnq0s5ZXX9k=
X-Received: by 2002:aa7:9152:: with SMTP id 18mr21415387pfi.215.1551122479546;
 Mon, 25 Feb 2019 11:21:19 -0800 (PST)
MIME-Version: 1.0
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
 <cover.1548186510.git.martin.agren@gmail.com> <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
 <20190123055704.GA19601@sigill.intra.peff.net> <CAN0heSoNvTVfC6A8fFK83u4TBX3sLaTJ_NqKwkCZORiCKdVwcA@mail.gmail.com>
 <20190125195107.GA6520@sigill.intra.peff.net>
In-Reply-To: <20190125195107.GA6520@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 25 Feb 2019 20:21:07 +0100
Message-ID: <CAN0heSq=0=B-FoPWcuRxp0oJ6capo3Pu4txZZOP2uDeNn5N1Og@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] setup: fix memory leaks with `struct repository_format`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 25 Jan 2019 at 20:51, Jeff King <peff@peff.net> wrote:
>
> > On Wed, 23 Jan 2019 at 06:57, Jeff King <peff@peff.net> wrote:
> > >
> > > On Tue, Jan 22, 2019 at 10:45:48PM +0100, Martin =C3=85gren wrote:
> > >
> > > > Call `clear_...()` at the start of `read_...()` instead of just zer=
oing
> > > > the struct, since we sometimes enter the function multiple times. T=
his
> > > > means that it is important to initialize the struct before calling
> > > > `read_...()`, so document that.
> > >
> > > This part is a little counter-intuitive to me. Is anybody ever going =
to
> > > pass in anything except a struct initialized to REPOSITORY_FORMAT_INI=
T?

> > > If so, might it be kinder for read_...() to not assume anything about
> > > the incoming struct, and initialize it from scratch? I.e., not to use
> > > clear() but just do the initialization step?
>
> I'm less worried about out-of-tree users, and more concerned with just
> having a calling convention that matches usual conventions (and is
> harder to get wrong).
>
> It's a pretty minor point, though, so I can live with it either way.

It's time to resurrect this thread. I've reworked this patch to avoid
the compound literal when re-initing a struct, and I've been going back
and forth on this point about having to initialize to `..._INIT` or risk
crashing. And I keep coming back to thinking that it's not *that*
different from how `STRBUF_INIT` works.

There's the obvious difference that there aren't as many functions to
call, so there's certainly a difference in scale. And you'd think that
you'll always start with `read_...()`, but another potential first
function to call is `clear_...()` (see builtin/init-db.c), in which case
you better have used `..._INIT` first.

I'm tempted to address this point by documenting as good as I can in the
.h-file that one has to use this initializer macro. I'll obviously
convert all users, so copy-paste programming should work fine...

How does that sound to you?

Martin
