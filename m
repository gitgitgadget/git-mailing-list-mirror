Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA5420958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755548AbdCTRdi (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:33:38 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35251 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdCTRdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:33:37 -0400
Received: by mail-pg0-f51.google.com with SMTP id t143so14809153pgb.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7r/Sne+GDqoFDimjg8UIJHujxM/B0V3CF/RT8B+HAwU=;
        b=uCz18NKk96XEs45sK6Gq/p8FuUQVSGG12S/Jo8aK+uI32nvzNK4MUKlMZJXVRQ4uvA
         nep8+oD/dQecMMMarz+dKI073pU/QwwPEmBGJZaAoCDCfnELd8cha+0S6/TluPXKnysM
         3oDCM7U/qvvUR3tFNHl6GFlLTQtPWjfD1kdeKDm6ezE32POuZrpho+JMPwtTYdex0ItR
         AaKSA1b0ZIs4l/BvNEE2cfSHn9N/Z9UtxwbpgslLaC1TvREDGwgZqctlCZuYY+6wrtZr
         ePYnIjrcq/SBDexaRP+OthVLRmZCzKUuZO6Dse7KViUQ88EJDePIfsJ6HAbgcjx4JpLq
         9Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7r/Sne+GDqoFDimjg8UIJHujxM/B0V3CF/RT8B+HAwU=;
        b=XytTTFTtdV0ERBgTf4Ucuf8I9u2X/+Kjm6OPTHvzzewdrVySRd18ueUxfp66ns/CLP
         GgqWWSLk5ObcoRCxkPUn3LuJ92wHxc7aaUZvbS3o8Ba/xcKkuZJEvUUT95ElhUwjINtk
         j1p5X8qChH2/o+F4/F4UFHwfPyoVi0fYDl2us0KtykrlIbYjka1vesLc2zu+L16pI2Fs
         7qpOhGRa2Jy1V6n9zSclS3Utg+sceQ1neNqLW4fnuciUY/Fel5quiRXqAuNawExhsMqm
         j7csd2Hu/lo4nSiYPcCYtCa5jvtNUntNYkfeyhjHutsWfpnWtUcT8oC0B+awSQ3K7IPK
         IBWg==
X-Gm-Message-State: AFeK/H0gbDIgwprc9e/YbmhsHwFWPQ45I8XG7FTA/cwzqQRvQuvifPe7HDxmcOfqzVasb47A
X-Received: by 10.98.152.91 with SMTP id q88mr34178474pfd.69.1490031159364;
        Mon, 20 Mar 2017 10:32:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:5dcb:9513:dc80:9079])
        by smtp.gmail.com with ESMTPSA id s65sm34612117pgb.64.2017.03.20.10.32.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 10:32:38 -0700 (PDT)
Date:   Mon, 20 Mar 2017 10:32:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Add configuration options for some commonly used command-line
 options
Message-ID: <20170320173237.GA188475@google.com>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr>
 <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
 <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <CACsJy8CQzo9K8N3xH_HJq=NjJVOUG9wawC4Mg+UuyFRZCPBpFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8CQzo9K8N3xH_HJq=NjJVOUG9wawC4Mg+UuyFRZCPBpFw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Duy Nguyen wrote:
> On Sun, Mar 19, 2017 at 8:43 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > On Sun, Mar 19, 2017 at 2:18 PM, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >> On Sun, Mar 19, 2017 at 11:15:33AM +0100, Matthieu Moy wrote:
> >>> I think the main problem is indeed "stop the users from shooting
> >>> themselves in the foot". Many command-line options change the behavior
> >>> completely so allowing users to enable them by default means allowing
> >>> the users to change Git in such a way that scripts calling it are
> >>> broken.
> >>>
> >>> This also doesn't help when troublshouting an issue as these options are
> >>> typically something set once and for all and which you forget about.
> >>> This typically leads to discussion in Q&A forums like:
> >>>
> >>> A: Can you run "git foo"?
> >>> B: Here's the result: ...
> >>> A: I don't understand, I can't reproduce here.
> >>>
> >>> just because B has a CLI option enabled by default.
> >>>
> >>> This is the same reasoning that leads Git to forbid aliasing an existing
> >>> command to something else.
> >>>
> >>> OTOH, we already have almost "enable such or such option by default"
> >>> with aliases. People who always run "git am" with "-3" can write
> >>>
> >>> [alias]
> >>>         a3 = am -3
> >>>
> >>> and just run "git a3".
> >
> > I can't find the E-Mail chain now but this has been discussed on-list
> > a while ago. I.e. having some getopt support to say for the push
> > command, that the --rebase option can also come from the config, i.e.
> > in this case the pull.rebase option.
> >
> > IIRC the consensus was that such a facility would allow commands or
> > individual options to say "this command/option is configurable", thus
> > of course all plumbing utilities would be unconfigurable, but
> > porcelain scripts would be configurable by default, with some
> > exceptions.
> 
> This is exactly it! It's much better than adding individual config
> variables (less work for sure, but messier). Maybe we should promote
> the microproject "Add configuration options for commonly used cmdline
> options" to project. If it's too short (I'm guessing the core code
> could be done in a month), the gsoc student can always convert more
> config to the new way.

If in the future we did want better support for making user defaults
(apart from aliases) for commands we could entertain creating a command
like bash's 'command' which ignores any user defaults and executes a
particular command in a vanilla mode.

So if the user configured 'git am' to always use the -3 option then
running `git command am` (or something akin to that) would just run the
vanilla 'am' command with no options.  Probably not the best idea since
tooling would need to become aware of such a paradigm change, but its
just a thought.

-- 
Brandon Williams
