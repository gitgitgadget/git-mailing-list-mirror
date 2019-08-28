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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9251F461
	for <e@80x24.org>; Wed, 28 Aug 2019 12:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfH1Mn7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 08:43:59 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39488 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1Mn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 08:43:59 -0400
Received: by mail-ed1-f49.google.com with SMTP id g8so2863058edm.6
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h01vY+utySymiuI2f+lfmjTc0IN4B3/BeLTWuk6/Na0=;
        b=abBxUZMMLX3QRjkJZGbR8xpGnumDHL8acHyPk2TMOs6YAvqvMWbEYMfrinMh++ctbE
         oZrNkhCgwr9HjcYA3xADkWrSzTVUbsoiDOYlfIk9R3EKwi4jkwXnvgyAIt3xsTLz0lz6
         oJF+vYxxUyHo7S2T70s+IDWSVpeAamSdfFzyh1Qo1MPYxeJWIWAyEPOT9SF7F34xBlsy
         j9jMQKqPt5/wn6iZhm7YkefD0YwsIlmM2rcJTHmsaSOVVDMdwffytEeSsJhXVpNRcaoI
         +MpMXt5OAMKzFGmOpheBxUJe1Ru59KnwF2C9sxZ88w3pKLENlSUqNArZ/fAwubrxP/Eo
         /EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h01vY+utySymiuI2f+lfmjTc0IN4B3/BeLTWuk6/Na0=;
        b=rnh6+U3EOYe/kYjBKOOLWelloGM+CnAb81Y2gDlCBaTQcYL67+sKKn4iernsLicDmm
         F8ILGa/x2BsMoWMOp4dwuY7Ziep6Iq8LgSsluCxBmVv4cJ9KGMiApu8qMJw1Zay7dbho
         4VLd6GlOV9ueNUi31n1Pcvj73ywzZDhJqlmbDSm2Ftkk8QLD5df1Nt5yLVTQZHIWlhIw
         LISUSmBgzC8qwZeGdAVDtjuziFlhHUTMI9uduEmYnO2IFjDl1PRS4RPFXJ+Knl6mccQZ
         NODekajo7vhX4mg04CfIZJeOcDfueXalWm3iBq7deZfN2eeMTDP5psAuBvZTL4iGxfnZ
         miyw==
X-Gm-Message-State: APjAAAW4Ff1zYCG7oHwvgB2p0zJysC328906lK6kirTFMQdVa7VJr0LO
        3HiDsN4EamAmCgAOLS2V5DE=
X-Google-Smtp-Source: APXvYqwksJG5fTaDhhhCCa8X0l2WmtfOclWmtasUmSEXq6yIcK7EewkIkUl8adzHazDXAOUgQP34Sw==
X-Received: by 2002:aa7:cf0d:: with SMTP id a13mr3807621edy.286.1566996237401;
        Wed, 28 Aug 2019 05:43:57 -0700 (PDT)
Received: from instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal (1.133.65.34.bc.googleusercontent.com. [34.65.133.1])
        by smtp.gmail.com with ESMTPSA id e4sm438175edy.74.2019.08.28.05.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 05:43:56 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:43:54 +0000
From:   Giuseppe Crino' <giuscri@gmail.com>
To:     Giuseppe Crino' <giuscri@gmail.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: How to build to debug with gdb?
Message-ID: <20190828124354.GA7585@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
References: <1d44d8d6-6c6f-591e-dd2c-5102c9fd7d11@kdbg.org>
 <20190827183640.GC8571@szeder.dev>
 <20190828081557.GA18785@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
 <20190828103217.GA6400@szeder.dev>
 <20190828110046.GB4450@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828110046.GB4450@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 11:00:46AM +0000, Giuseppe Crino' wrote:
> Maybe I'm biased by my incompetence with Makefile's but since rebuilding
> the project with `install` but different flags from the first make is
> unusual this is worth mentioning to developers.

Definitely *not* sarcastic
