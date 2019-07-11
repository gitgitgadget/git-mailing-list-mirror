Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719401F4B7
	for <e@80x24.org>; Thu, 11 Jul 2019 17:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfGKRJo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:09:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41534 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKRJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:09:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id q4so3241055pgj.8
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rP3h7HUOOHPeJxVCjHoyk/NTGXpv2xyOvI6BIbDONkY=;
        b=qc6BcPi2s+YnZUiYY6uQIcd4d+7jd2J8lvRK8sA0oVRic9Ho/3MAYokf1pHptWIMMM
         W45cHY/GBJiZ67oXaFAvySEMrfs6k7zdkyIqUKwOcd+s6k5Dh8EBInDXg8qaxYEX1mUj
         RJnsFNNNPRhuQN5LD9WxXi1zf+hyiN61VAdplcahb0ix72rADCoA7851LZrHw52d++t9
         /N5YkJYKCuJNz5Cafm5mdry26jq/My3cXOz++Q3z31QbpvpawYd5cKjhBy9+vPDynuyf
         4nh0aj7sqxFTD6FG3hYrANgmKpX+KjLs3wwGsC1UtCnueIOlOMV+P6ZzKzcB4SIzDHer
         HjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rP3h7HUOOHPeJxVCjHoyk/NTGXpv2xyOvI6BIbDONkY=;
        b=IIuexCSNTsS+mFHIu8401rDIeCjfJZjOvBIOpZJYqR2yReAqBdU2TzUhhZZjl1HSo8
         fR4wOPorz481BFDCWhodZzXbsQcw02ecii5yWlQTy6qMWM80cZVuyFEQZ/Qz35oS6hRi
         Jwy+iMs2TFScu/rNj/vIluAV2yIY95X523rDN37PehVEdaxTmCy3Z0iHFS8bFgVmFbWZ
         yoRrmk2+yOqb9f7IMcig1H/RYjR/p/lRNMDib6zIhmWEDDWi8BNXiQGBX4Dy5Ktm69xb
         KPRCpfy84Gz4pbcpezqNeNXmo/oGOMRNGIX47F8qT5GvmIIR4Oq2+s0PzmBtjoSediOF
         uuPA==
X-Gm-Message-State: APjAAAW5vfrAG2tFTdVfyHfw0+Te7YrvHQsWoX893ZTBXW6sc19NTAOS
        g+6J7o4ivk1aXqqlqddMDHDnl2Xx7m1QWyYg82jeFA==
X-Google-Smtp-Source: APXvYqwgsvqdBDc3LE3JkShl6QeOPZFq7wbQuvpBDhbNIkIzwhtlXmyhYuVE7iY1ujrepu0H/AkUYzXTKb0nK1D+CeY=
X-Received: by 2002:a17:90a:ab0b:: with SMTP id m11mr6231393pjq.73.1562864983371;
 Thu, 11 Jul 2019 10:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190711081958.2201-1-ariadne@dereferenced.org>
 <20190711151900.GI9224@genre.crustytoothpaste.net> <CAAOiGNzXreYk9xoVOFkcivrXK4QkH495T7Lq76j3oz593rSzDQ@mail.gmail.com>
In-Reply-To: <CAAOiGNzXreYk9xoVOFkcivrXK4QkH495T7Lq76j3oz593rSzDQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 11 Jul 2019 19:09:30 +0200
Message-ID: <CAN0heSqZcTBE4qtCNQNUVB=4y8OUh03U5_a+PDJU7vfZ9Nwu9w@mail.gmail.com>
Subject: Re: [PATCH] log: use mailmap by default
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ariadne,

Welcome to the list!

On Thu, 11 Jul 2019 at 18:39, Ariadne Conill <ariadne@dereferenced.org> wrote:
>
> Hello,
>
> On Thu, Jul 11, 2019 at 10:19 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2019-07-11 at 08:19:58, Ariadne Conill wrote:
> > > The `git log` command shows the author and committer name recorded in
> > > the git repository itself, while other commands respect `.mailmap`
> > > by default.  I believe this is a bad design: it causes log entries to
> > > reflect inaccurate information: anyone who changes their name or
> > > e-mail address will not have that change (recorded in mailmap file)
> > > reflected when using `git log` by default.
> > >
> > > Anyone who explicitly wants the current behaviour can clearly request
> > > it by setting the `log.mailmap` setting to `false` in their
> > > `.gitconfig` file.

It would be useful with some tests for this. That would be a nice way to
showcase how this is meant to work, and to protect this from being
broken in the future. From looking around in t/, it looks like
t4203-mailmap.sh could be a good spot.

> > While I'm in favor of using the mailmap by default, typically we want a
> > way people can override a default setting from the command line.
> >
> > So in this case, we have "--use-mailmap", but we don't have a
> > "--no-use-mailmap" (at least, it's not documented in the manpage). I
> > think we'd want to add such an option so that people can set it if they
> > need non-default behavior.
>
> I agree that there is probably some useful reasons to have this
> option, so I can add an option that forces mailmap usage off to
> supplement the --use-mailmap option.  It's no problem.  I will
> generate a new patch series in a few minutes.

There are some tests already in t4203 which test that for example `git
log --use-mailmap ...` does the right thing. If your implementation is
correct, it should be possible to drop `--use-mailmap` from there and
everything should work. It would then be very useful to have tests that
`--no-use-mailmap` does the right thing. There's also some testing
around the `log.mailmap` config, which you should probably adapt and
possibly extend.

The documentation for `log.mailmap` will need to be updated, since
right now it says (or at least implies) that the default is "false".

This looks like one of those very small and simple changes that turn
into quite some work to ensure that the tests are all there and that
the documentation is up to date. :-)

Cheers

Martin
