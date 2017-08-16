Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FAB20899
	for <e@80x24.org>; Wed, 16 Aug 2017 06:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbdHPGsV (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 02:48:21 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33424 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdHPGsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 02:48:20 -0400
Received: by mail-ua0-f180.google.com with SMTP id r9so1182925uad.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kimbirkelund-dk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I4sj7yuUZziZGK5TwExajgXjiShpjoxen2YL7WoZiSU=;
        b=c6EugWToTrPsm13jb1JEHPFHPsTJggq556Czu1awfzD6TEX1SRiKFRhkY8gAMFT1s0
         GdxSLMnrC3fWegv7ooiHHM5E3Un5H1YlE4IpoizMBScqrYaxsl/2rKkZs35mngn4dhZC
         DnR1YwI4+EAbcX3uIfPBiNCl3lziO+SnK0+r7Lgi2H5H4PmCe8raQbe54DbO8chDGLvo
         z8Cee4PD8LrcznH8H78y8WkXESaMLnhONCLQhWNoPsWsFYmN6He9+gf6MGOoxTPkwIHb
         znr997vpS5FTxrlokDR9k5TRnwHjx/4fl/R12h4CZKcbhEmLYE9rSgr3IvsYXKG/Vws1
         Q74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I4sj7yuUZziZGK5TwExajgXjiShpjoxen2YL7WoZiSU=;
        b=GMCePXAVKhA3T+5LRz6vDOobm6z+QPkDlbji1uwNyWMIOetLLVVpK0zr1N8TIxL7sL
         j+4RRs7r00ych+6Cs9zRIQwY+BzdgVh6UZV5SMBGi7qV3Fa3QLhDbtHikLAwbLiRMD/V
         vq6I1wp+Ia5ToDMQh4Ru5hUxpdNhZE495dTLMhVDEBY0nZN36GCetGf3o5o6PhliZgth
         Icz4SvIfVDKFJr+GZJX1sLHzIRJMIZ6EYDfheVV/pIl3mFNRfsNRe/IqqdBfTnoVEvZY
         JfWKokmuX0FP3PNUnBjc8E5TGkaPZNZ5YgFK5LsLTdPcz35B0QVN0bSYV6Uj1x70+FLF
         hVhw==
X-Gm-Message-State: AHYfb5jch9AjklspVVfa9M7e6jt96d8qophUa6qGhIG/huC2+ek7sa4m
        MXUuTJr3NUIn72yQgpLNyV+LbVbFcfZO21s=
X-Received: by 10.176.78.37 with SMTP id g37mr447248uah.104.1502866099102;
 Tue, 15 Aug 2017 23:48:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.39.68 with HTTP; Tue, 15 Aug 2017 23:47:58 -0700 (PDT)
X-Originating-IP: [78.143.96.9]
In-Reply-To: <20170815192543.GB3839@alpha.vpn.ikke.info>
References: <CAOCG=_p--J5PKGrQTdquMvcBNQs67MNaN3vM8Tbwn2nZNwVR+Q@mail.gmail.com>
 <20170815192543.GB3839@alpha.vpn.ikke.info>
From:   Kim Birkelund <kim@birkelund.me>
Date:   Wed, 16 Aug 2017 08:47:58 +0200
X-Google-Sender-Auth: xDGFndzKuJk688o9BI_MBJccqO4
Message-ID: <CAOCG=_pKCXbsRtxNN3+qn+28i_1ZXZJ4Nyf2LLSF78irbyoqFA@mail.gmail.com>
Subject: Re: git clean -fdx deletes tracked files
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies. I should obviously have mentioned which OSes the machines I
tested on ran.

One Windows 10 (fully updated) and one Windows Server 2016 (also
updated). I've also seen it in a real repository on our build server
which is Windows Server 2012 R2.

After my first mail I updated git to latest and could still reproduce.



On Aug 15, 2017 21:25, "Kevin Daudt" <me@ikke.info> wrote:

On Tue, Aug 15, 2017 at 08:45:20PM +0200, Kim Birkelund wrote:
> Hi
>
> I hope this is gonna sound as weird to you as it does to me.
>
> The link below is a zip of a small git repository that I can reproduce
> the bug in on 2 machines.
>
> Repo: https://www.dropbox.com/s/fz4d0i5ko7s7ktr/test.zip?dl=0
>
> It contains 2 folders: helpers and b, each of which is an empty npm
> module. b\package.json refers to the helpers module.
>
> The following reproduces the bug:
>
> 1) in terminal cd to the b folder
> 2) run npm install
> 3) run git reset HEAD --hard
> 4) run git clean -fdx
>
> At this point both files in the helpers folder has been deleted and
> running git status confirms this.
>
> Tool version:
>
> git --version => git version 2.10.2.windows.1
> node -v => v6.11.2
> npm -v => 5.3.0
>
>
> I have no idea what is going. Very much hope you can explain :-)

I cannot reproduce it on linux.

git clean -fdx output:

  Removing node_modules/
  Removing package-lock.json

These are all untracked, and nothing in the helpers dir is being
removed.
