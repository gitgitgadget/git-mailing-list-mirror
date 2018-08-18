Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1461F954
	for <e@80x24.org>; Sat, 18 Aug 2018 22:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeHSB2y (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 21:28:54 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33031 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeHSB2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 21:28:53 -0400
Received: by mail-ed1-f43.google.com with SMTP id x5-v6so6400585edr.0
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ULdbzsqOIYXMNIU0DEKFL4uoY48rU1xzpkyvYGFo2sA=;
        b=ZDXuLHTAJum/lnmcNud1grA7uKoXMVVJj6fDaZjiI9MM+RyJrPV8mYXZ1k+/3obNFd
         +osPNtMlhYqssz8eIsIb1vcPoFfw7OnaznB15n9/4+j2sTouCluN4QoUI1y1n4aw4YPN
         6503sUiux4AtvHpDwOkMCrRSc3Odo4/m+WNXgiLdkiGnI6lKyISkXUYgvsxiGvX0AJO1
         alQmb0BCrv15QPwRZzvo1w+i2FAeurIYk8xGHRKf20AFY9OMRnrdFK4fZcmrRHCth230
         sT7kWBzQoDrq3Hz4pcgRwj26vcFPnpZa1QVC3MI6GXuxa8aAv3Ggp4IBDbo8b5U4WefA
         U6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ULdbzsqOIYXMNIU0DEKFL4uoY48rU1xzpkyvYGFo2sA=;
        b=fGv4PhlLAKIoKzVEUKPGVaPpALGIdWbnTqXB+gNKM0tADTjkS2KrMb3Lq9NX49WBcF
         1rp5GoqjPTBvsj80ehUAAiPnP/qbaiVHR1vYAaxnnct0uVHPqoV61lMybRH0kUUroWlj
         eNo9i519NvqKLO+3X4yRcej7GejhZg65WzWe3IYQBOblKisldyFqtvaM2yKN5P3l+YCO
         QyE/wlcPEaIx/damtyCd0fjMs3w25vBA/LH1Frea6u1tWzFNvezbm1c2xw5O6CNNDx7g
         tk9HVBP/aEpGAC/gi2iH3KC90G0A7UpsmLnf00wLeFjoPuJeSrTMDr8VeZPH1LxDUd9o
         o5OQ==
X-Gm-Message-State: AOUpUlEN68cXeL0jo5e6aE3KDN67Q2TWnD5k4scIYAuZhvIdVryWZ4QD
        HamzDE++3TZpTryRRCyDDyXzhhd3LJs=
X-Google-Smtp-Source: AA+uWPwneAhtRVwNIPZhpXP7u1oBfC578jklhRxWt5h+Th5RSCgsALRqIgF8REg666EJE3fC1ieM/A==
X-Received: by 2002:a50:8a9b:: with SMTP id j27-v6mr48742523edj.36.1534630781021;
        Sat, 18 Aug 2018 15:19:41 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id p5-v6sm3783014edc.33.2018.08.18.15.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 15:19:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Michael =?utf-8?Q?Mur=C3=A9?= <batolettre@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bug: Distributed bug tracker embedded in git
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
        <20180818054300.GB241538@aiede.svl.corp.google.com>
        <874lfrrhfp.fsf@evledraar.gmail.com>
        <20180818204243.GA136983@aiede.svl.corp.google.com>
        <8736vbqr2p.fsf@evledraar.gmail.com>
        <20180818220821.GC144170@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180818220821.GC144170@aiede.svl.corp.google.com>
Date:   Sun, 19 Aug 2018 00:19:39 +0200
Message-ID: <871savqpvo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 18 2018, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>
>> The reason I can drop a "git-whatever" in my $PATH and invoke it as "git
>> whatever" is just a historical accident of how git was implemented.
>
> No.  This is a very deliberate design decision, to allow people to
> prototype new Git commands (and to create the kind of ecosystem that
> allows commands to be implemented outside Git.
>
> [...]
>> So we don't get to say "you never asked us about git-annex, we're using
>> that name now" without considering how widely used it is. It's us who
>> decided to expose the API of seamlessly integrating 3rd party tools.
>
> I think we're talking past each other.  I haven't proposed any blanket
> policy.  I'm saying that "git bug" is a bad name for this tool:
>
>  - it's hard to find with search engines
>  - it conflicts with some likely good future changes to Git
>  - it assumes that no one else will have some other refinement of the
>    Git bugtracker concept, that it is the only "git bug" tool
>
> It's a namespace grab.  There's nothing stopping someone from naming a
> command "bug", either, but that doesn't make it a good idea.  (I'm not
> saying that was the intent --- that's just the effect.)
>
> Meanwhile it looks like a neat tool, and I'm very supportive of the
> idea.  But you certainly still have not convinced me that the name is
> a good idea, or that I shouldn't be bringing this up.
>
> I'm not sure *what* you're trying to convince me of, actually.

I'm not saying the git-bug name is a good idea, or that it isn't. I
don't care about this particular case when it comes to naming.

I'm just pointing out in the more general case that if someone comes up
with a badly named git-xyz it doesn't scale to try to point this out to
them before git-xyz is widely deployed.

So we must either let it go (solution #1), or come up with some
API-level solution that makes it a non-issue (my #3).
