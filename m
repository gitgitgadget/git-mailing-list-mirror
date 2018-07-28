Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195E21F597
	for <e@80x24.org>; Sat, 28 Jul 2018 04:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeG1GLM (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 02:11:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45849 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeG1GLM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 02:11:12 -0400
Received: by mail-io0-f193.google.com with SMTP id k16-v6so5778517iom.12
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 21:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3j35fUk8ye770Lm/lf0InFY4A13Xmgi66uw9q3oCrkA=;
        b=fCAOXBz2mjsAB5ajKriM8CsY7nmM2pmhV/tV1zSOHJcQTPhBIRx0u8PdiMqeqHFsPS
         I7+RL3V/XJPlTzAqZ+mmeZduIrhdmNh6/hZ217ygE34NX2aj7Ktf3Q3D+nZeWWf7z+pW
         557STjNPtWVQcqCEdxv0A3Mx+jygjI+1b+vY5/7FypX9+4e9wxzCIhPLYD1vL+WbIjv/
         UseAmb4r+Upk4udA1lNcxnR3wsbM7bmjeKsk+W23nkyQpR4rBPrnnnViRTg6WNyKYs2s
         3u6YfguNxcTgEL/RW+zfjpAuVWWLGxubcxhnxSn9e51GkQ4wN9bi+ENJ1y/smdiTbh+u
         nOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3j35fUk8ye770Lm/lf0InFY4A13Xmgi66uw9q3oCrkA=;
        b=RoSewBy5QFNuf271KkA8a8sa0/mjOlvlhlmCCXZn24s82BMDhkibXLjKCf/2eFfoE8
         PXc//wn7/j3OB60xE5oWxwTO/ZY3OPLbHTy01TT/7OhXBaaYXXXbWS+bPV48nTTmd0Vv
         hby2WufpjTXsLBx3p3vnFtdj3tCxkI+GsQkteG63QouAPovgN/KvhH7oaJ8nX+yhnEpg
         dgXIFSndytpr3/KIOVin+V9KtV8lzvk3DLsCTiUgvA3tk2xesl/n6oBgV3wuMRgJL5u3
         tsaG/wag8crfcMNWbymUzmKSPEgjN1RT8nXcDdcV3DcYK3ZtTCo3+odVeOpYrrq3m2PM
         1OdQ==
X-Gm-Message-State: AOUpUlE/8750IQGn4qi+dLbGa1sJMr351kufDRvvlpvPyYhpsonb0Pna
        yHOqVg8XxnGfcEVq+aDPXwhuwXNWTecHYNtSlXk=
X-Google-Smtp-Source: AAOMgpfudycAEhuvhd99qcssdS3O4XcKmDHzJytabkz8jJ8Yshsx4g1SdGkJPp375Kgg6G63FrvJZrsvv3FLgcyha5g=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr7235004iod.118.1532753169940;
 Fri, 27 Jul 2018 21:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net> <20180728043559.GA29185@duynguyen.home>
In-Reply-To: <20180728043559.GA29185@duynguyen.home>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 28 Jul 2018 06:45:43 +0200
Message-ID: <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
Subject: Re: Git clone and case sensitivity
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 6:36 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Jul 27, 2018 at 08:59:09PM +0000, brian m. carlson wrote:
> > On Fri, Jul 27, 2018 at 11:59:33AM +0200, Pawe=C5=82 Paruzel wrote:
> > > Hi,
> > >
> > > Lately, I have been wondering why my test files in repo are modified
> > > after I clone it. It turned out to be two files: boolStyle_t_f and
> > > boolStyle_T_F.
> > > The system that pushed those files was case sensitive while my mac
> > > after High Sierra update had APFS which is by default
> > > case-insensitive. I highly suggest that git clone threw an exception
> > > when files are case sensitive and being cloned to a case insensitive
> > > system. This has caused problems with overriding files for test cases
> > > without any warning.
> >
> > If we did what you proposed, it would be impossible to clone such a
> > repository on a case-insensitive system.
>
> I agree throwing a real exception would be bad. But how about detecting
> the problem and trying our best to keep the repo in somewhat usable
> state like this?
>
> This patch uses sparse checkout to hide all those paths that we fail
> to checkout, so you can still have a clean worktree to do things, as
> long as you don't touch those paths.

Side note. There may still be problems with this patch. Let's use
vim-colorschemes.git as an example, which has darkBlue.vim and
darkblue.vim.

Say we have checked out darkBlue.vim and hidden darkblue.vim. When you
update darkBlue.vim on worktree and then update the index, are we sure
we will update darkBlue.vim entry and not (hidden) darkblue.vim? I am
not sure. I don't think our lookup function is prepared to deal with
this. Maybe it's best to hide both of them.
--=20
Duy
