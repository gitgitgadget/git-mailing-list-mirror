Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B77D1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeDVX1H (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:27:07 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:42776 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbeDVX1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:27:06 -0400
Received: by mail-pg0-f44.google.com with SMTP id e12so7064791pgn.9
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1V7e6Yz6VLgUDDfwWGFegWGjE96ChiRGfALRVJN/XZM=;
        b=FdqxuqS+G4itR2OSzs0rS8ng0hoApEPXnXO97H/k1KLoOoOAQJ7R5PZ9k5MT/AOt2c
         hDOK2xjEqO8/eAEefb1GUTJQY5AXU8uZzX8LPxDCj54T+Ao8RnH1R/Puait0pm7Fw6QQ
         gCPcdSS6JysfalcTITqHAvqPPc3kpN7UyVAfr2BlcPxb6K8x85JTerZ7jCM6Fb/hTksX
         ALCjcUZC7bCyKQzJXxi32GLTQQvv86TKzgwywKI9Kydm7I09FagUkeO5zao9UxjCEZaz
         2xsDaLSjTYLGPzt7Nv1YsmuoqGKuhgtuxEXsalX6osLOKaKgsXgRfSub4tlXjToJlXwc
         neoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1V7e6Yz6VLgUDDfwWGFegWGjE96ChiRGfALRVJN/XZM=;
        b=Hm0t0GkIXYOGcWqO421zq6Qss3kBwV1CdhbYeGNvuL0CHRZFVMuGpTT7FXMkc4XhDf
         LE6vdv3ws/ifB3OPnAIpFcIqUvf3QkEr0ZyeJr3HwVi07j7y/CBRyLu3K+gYcFTvClyk
         5hgGXdh2ZPCOXYYfXSiNjeIMaJJpwNnwNp7ihmNEwsht+qWQtj1vJMOVlcnh94x3RoP6
         +U8jV6irtVRdxYBQceww14HobeFT9wQ2XAjRc3/CEqBaxbrJGqMUzdGd6nSFCh7i9OWo
         UMYYFYDleemzZ8CDQPJ3ipX8OGVDwCArfyG3Kyx0f12Ou3zFAjFmlhGq0IClqKr5LXnq
         SmmA==
X-Gm-Message-State: ALQs6tA5pWSlwtunQQej0SWXqJgasWfxD8eRR8qjGxJ1/bJMUXPKxXMr
        2BaF52etuTWTijIV0GAFKIH/SQ==
X-Google-Smtp-Source: AIpwx48bt6m+RPEgOcVb8LDIfuqYuPurb1stj+J4wxRLAZiPuiXSSPmE3E2T61BCc6fAaxuP1RI5XA==
X-Received: by 2002:a17:902:bc06:: with SMTP id n6-v6mr18342771pls.97.1524439625823;
        Sun, 22 Apr 2018 16:27:05 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id r20sm24329476pff.165.2018.04.22.16.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 16:27:04 -0700 (PDT)
Date:   Sun, 22 Apr 2018 16:27:04 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 6/6] contrib/git-jump/git-jump: use column number when
 grep-ing
Message-ID: <20180422232704.GC48072@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <b9d2578d8dc644e68a09445e14156d789bfe395b.1524429778.git.me@ttaylorr.com>
 <877eoyewss.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eoyewss.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 11:49:39PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Sun, Apr 22 2018, Taylor Blau wrote:
>
> > This patch adds the '--column-number' synonym '-m' to the default
> > grep command so that callers are brought to the correct line _and_
> > column of each matched location.
> > [...]
> > diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> > index 80ab0590bc..2706963690 100755
> > --- a/contrib/git-jump/git-jump
> > +++ b/contrib/git-jump/git-jump
> > @@ -52,7 +52,7 @@ mode_merge() {
> >  # editor shows them to us in the status bar.
> >  mode_grep() {
> >  	cmd=$(git config jump.grepCmd)
> > -	test -n "$cmd" || cmd="git grep -n"
> > +	test -n "$cmd" || cmd="git grep -n -m"
> >  	$cmd "$@" |
> >  	perl -pe '
> >  	s/[ \t]+/ /g;
>
> So this re-roll doesn't have the alias -m anymore, but this makes use of
> it. Seems you just forgot to update this from v1, unless I'm missing
> something while skimming this...

Ack; another good catch. I have updated this in my copy and will include
it in v3.

Thanks,
Taylor
