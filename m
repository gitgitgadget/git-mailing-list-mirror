Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA9E20A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 00:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeLXABq (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 19:01:46 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40699 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeLXABq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 19:01:46 -0500
Received: by mail-ed1-f43.google.com with SMTP id g22so9020833edr.7
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 16:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsZ0KcR+iFs7hepKsrwY03aIZXSeCI9hHsfAtQJzJTQ=;
        b=ojxv/e3CtCBRyAZHqHvMvNELMeLJQkAjYEbJ9bqgYxPH8o06drA+SzWdU3MAPHVXSQ
         v0aAaN6d+eCYDkIHYucXodGPOorNOtF889GGhuJOZ8HfPbKo/lPJ82eY9jfdZJ5XIRpw
         xY6yyRJALGND3G2mqxNYW9EJ0IGiBrOrxahrt1KAijr0hTu+lJxN0Y8D4/sePIAIdsbK
         ALG1VyR6jwGiSt1pXPhxRbD6OzhYayPbZK1JAic365L7J9FJ2bmF1m/DYha/Vz7tbEFA
         bV0m4USYUDPTabisPiE3G+fFHc/MVo+j3CJUJokX65Ycit9bkBh18Yo6OxwLY/cfjmzN
         bPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsZ0KcR+iFs7hepKsrwY03aIZXSeCI9hHsfAtQJzJTQ=;
        b=tdjX2LhanNLbscrCqsp6OXyY5LNvv6mmSIDtvIPjgPCDX+bzYW0/cDSS2e15kAWllB
         jtNntJu4UCiVMo2lu7uCVyZ4XsWBRCO680yndUSozTdG03XexzKY9heB5GquHPu6mkjs
         81VyN5R3tKVGbKPhGa+w1DXt2atUAn3zo+YVmcCAE87XHBvRcexxN53Dt9p4nOmlWCvz
         V/LoBIbnt7Yl6LuU/DKoATUlOWgOToFVuufTE1TG/h82ATbQ3MZQb48yZpEZHTMpK2xa
         Te/Nl2TVqp6bAZvkahnVQ5PnezNzrb5tTxbDLKPnoFvBEKl0r/CWh8AbmxZdmPFRFI23
         jx+g==
X-Gm-Message-State: AA+aEWbEWNacSvrpBwniDTsZ7FlEXRHykqqBmOleVhY4oV82LstxQN1G
        qkX/3adgCFEjdcPbpnZ5sNyOTT8hUDT5zgDQi5k=
X-Google-Smtp-Source: AFSGD/V0eezJkyeRY+T1HnkSBm9DLMI8Ho2mE9TZOw/hEkEilNgEH/jBUTLNFU7lXsSV49v7Hg0xwv1L42aThRIEqbM=
X-Received: by 2002:a17:906:2d51:: with SMTP id e17-v6mr7600833eji.143.1545609704083;
 Sun, 23 Dec 2018 16:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20181217165957.GA60293@google.com> <877eg5fwd5.fsf@evledraar.gmail.com>
 <CACsJy8DdgjjQLEn=O7ePBo7ndLuv22RGQA3nM1Lyizz=59Pj9Q@mail.gmail.com> <20181219221401.GC228469@google.com>
In-Reply-To: <20181219221401.GC228469@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 23 Dec 2018 16:01:30 -0800
Message-ID: <CA+P7+xoL2jEV68bkndoLmRBaTY0vNs=gBAWdpw=U4g=XO-Eapg@mail.gmail.com>
Subject: Re: Referring to commits in commit messages
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 2:36 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> In Linux kernel land, Documentation/process/submitting-patches.rst
> contains the following:
>
> -- >8 --
> If your patch fixes a bug in a specific commit, e.g. you found an issue using
> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> the SHA-1 ID, and the one line summary.  For example::
>
>         Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
>
> The following ``git config`` settings can be used to add a pretty format for
> outputting the above style in the ``git log`` or ``git show`` commands::
>
>         [core]
>                 abbrev = 12
>         [pretty]
>                 fixes = Fixes: %h (\"%s\")
> -- 8< --
>
> I like it because (1) the semantics are clear, (2) it's very concrete
> (e.g. "first 12 characters", (3) it goes in a trailer, where other
> bits intended for machine consumption already go.
>

For what it's worth, Linux's checkpatch.pl script also checks for and
enforces that commit references have this format.

I personally like having the date information, and have attempted to
get checkpatch.pl to stop complaining about the date when it's
included. (see https://patchwork.ozlabs.org/patch/821543/ for the
patch that I've had up, we've been trying to get the maintainer of
checkpatch.pl to notice and pull it in, but not very much success as
of yet).

I'd prefer to keep the format as seen on this list fairly often which
is the something like

show --pretty=%h (\"%s\", %ad) --date=short

or

show --pretty=%h (\"%s\", %cd) --date=short

I like the date since it gives a quick approximation of how long ago
the commit was made, and helps in the rare case of disambiguation.
Personally I also like the quotes since it makes it more obvious where
the subject begins and ends. They aren't strictly necessary but aid
readability to me.

Thanks,
Jake
