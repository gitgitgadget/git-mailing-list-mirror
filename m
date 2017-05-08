Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469051FC44
	for <e@80x24.org>; Mon,  8 May 2017 17:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbdEHRBl (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 13:01:41 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36339 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdEHRBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 13:01:39 -0400
Received: by mail-pg0-f51.google.com with SMTP id 64so14110239pgb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KF0o+MHeRoP/ckWSM2KeUUm75e4KoX27mYx1deRWU3Q=;
        b=RarxU70k4oBdu/FHHPGl8+Xz3oZ2QzE2zABqM6efLqgX9g3hIg9CrkE4IC+jUOIvmD
         pAXG216rgKAUMPnhgzm7v1PXcxLvpg/E8leRLEheQNunuONItGqgtrCQWqYP1xPa5R4P
         73jyS3Y0asVZyPsAXfAvMMa7CBehXtQZD2k9t5oAwkd+U4JuGQmc6kBIY9b/i2ohosWa
         /WXibqfpeDGB1/YHvt2+sQiLPf5BnqnWoCtKT7aTzyXVFtd4JdASdIEgSmUOjJcb0NX3
         Tlj0RXK2ZrpbKy3TBYvaUxd3MkvBzEXvS7bpfeukvebCqFe9JWJ4k3/qRhtD3QbzBDaC
         q/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KF0o+MHeRoP/ckWSM2KeUUm75e4KoX27mYx1deRWU3Q=;
        b=Bo848BES0lz/BXGQlxDaUFY9RBphj0Zt0nSD1BSWvs7QDA8IXh9RLGFO8RVrC/vUMe
         Dub+CVaZIlByScMEByCS2EbmRokdUi4eMd3q5X2y7MIa4PwauIp+aDcnU/2P0T/TrYFh
         BEFXtiExWDYGPCZOjzwpcybrIN9x4I+tQg5gpgfbU7oM5ZiSV3N4iIbLBGc/AKnUs2TN
         0Kqv2IOgK0zGJ+XpCAWT13t2Z/8dLxT0oKq821745BHFF282eALpwpZzJvIflu1DVeA5
         WZ3Y82dUl1TQT9Flou/mK1pAKabmYRBq4TCJ3t0WBJB0bcetOAYlGrnhVcamrEHDEAjJ
         ndpg==
X-Gm-Message-State: AN3rC/6PHiOYTZBmK8McCsnpIrnGTMIqR4sVvx+tr1D7XHEiYbEdsrVx
        vkYnHB8SHZMqo8g8
X-Received: by 10.99.116.2 with SMTP id p2mr19830995pgc.74.1494262898875;
        Mon, 08 May 2017 10:01:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:998e:2b7a:726f:b074])
        by smtp.gmail.com with ESMTPSA id o124sm23728936pfb.92.2017.05.08.10.01.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 10:01:37 -0700 (PDT)
Date:   Mon, 8 May 2017 10:01:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Samuel Lijin <sxlijin@gmail.com>,
        Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <20170508170136.GB179149@google.com>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
 <20170506205041.GA26189@starla>
 <CACBZZX42rhmrq8z0u1aRXw87oT22YywwnaFHUMjDYgtE_i56nw@mail.gmail.com>
 <alpine.DEB.2.21.1.1705081239360.146734@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1.1705081239360.146734@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/08, Johannes Schindelin wrote:
> Hi Ævar,
> 
> On Sat, 6 May 2017, Ævar Arnfjörð Bjarmason wrote:
> 
> > I have one [script] to git am a patch from a msgid, thought I should
> > write something to handle a series in some DWIM fashion (e.g. apply the
> > latest continuous sequence of patches matching --author) but figured
> > that someone's probably wrote this already & I don't need to hack it up
> > myself...
> 
> You probably missed my previous mails mentioning
> 
> https://github.com/git-for-windows/build-extra/blob/master/apply-from-public-inbox.sh
> 
> You can use this script to apply single patches (identified by their
> Message-ID), and patch series (identified by their cover letter's
> Message-ID).
> 
> As I mentioned at the Contributors' Summit at GitMerge 2017: I would
> *love* to collaborate on tools that make any part of the
> contribution/review process less cumbersome than it is right now.

Yeah its not the most streamlined process.  I'm sure everyone writes
their own scripts (like I did) tailored to their workflow.  For example
I just tag a bunch of mails in mutt and then have a scripts which 'git
am's them on a branch/base of my choosing.  But its specific to
my workflow so idk how useful it would be to others :(


-- 
Brandon Williams
