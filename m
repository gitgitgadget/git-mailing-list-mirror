Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6BA1F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 13:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbdAXNcL (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 08:32:11 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33091 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdAXNcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 08:32:10 -0500
Received: by mail-lf0-f50.google.com with SMTP id x1so24054763lff.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8t4u17xZiNmUc7GMy3j5BwfP6jqoTZ143fIJW8u8xNk=;
        b=MP9TSv34QbZx8kt/dQ8zciNrEZS1+xmR2H6J+F0VbnQ7oCsdvergRx5U/oQjkthIJM
         2ggDWWG+bdjPE+8PNf9taKzLixmJzJDC92E0VqVXY0koUe7dA2avu6eYDW5ZFH4YJBFg
         6BiRTiph+4pobpjAjc9Vc6XtB+Bu5V54pt03Zx0InvKhi0YUZ/H4LLCn/NdmMqn9kIb0
         KryFFl8Q0dg8B6Ue8avThi7qGbW057a5bRSf3rmqEnLYEPk+giWdAK9VUcqsaw7FZR0R
         vBMLqtiebWqCuu/yZwsVgM0XJ7JQk9ei/96XkmJxwHMxYFmRgBxfrPeKgqDRcepapZLB
         YL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8t4u17xZiNmUc7GMy3j5BwfP6jqoTZ143fIJW8u8xNk=;
        b=qlqLQ+yd7/TsEAI1KlQltbZRnA8FRrP+2eMYdPnU4qpZZMb5vl42ZyXMWrDNuoIo7s
         fOhmKJhI6zRyc43fHl1Egd6hszXGbgav3CZXul8X7Q2H07+sfsk01aF8/W5UtMCklfzI
         P4GtEa3gmFDIoLBN5E80U+NFeA+8DeSuxD/+IZbrd/pYqt8oEhpFzM2gqOnKRm2HF2w3
         jH+y/q24c5w80kLJhqlv//HIn7NQZP65T3BM0sqeobJvhBaQvH3i7U/o9ya/jFtYpKOU
         ngWqocaHkCfKn3PvZuaHRusG/aERFTwX61t/R9u75DmNP9IEhtrLnHnGOyqzOI4bRskP
         Ue9w==
X-Gm-Message-State: AIkVDXI0f9RdpYqVW0M9lywOlfzxl5OLiIipSawxyLmQcoP4pRIXzLzrogXWs/7nOTaDQ1gbvGAfu9KJ8a00HQ==
X-Received: by 10.25.203.3 with SMTP id b3mr6305607lfg.130.1485264729086; Tue,
 24 Jan 2017 05:32:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Tue, 24 Jan 2017 05:32:08 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701241228020.3469@virtualbox>
References: <vpq1svtstud.fsf@anie.imag.fr> <alpine.DEB.2.20.1701241228020.3469@virtualbox>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Jan 2017 14:32:08 +0100
Message-ID: <CAP8UFD1qsd13Eh45rXVDL+c=eWjNhoBMC4r1gG=zNw5OLDRigQ@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 12:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Matthieu,
>
> On Mon, 23 Jan 2017, Matthieu Moy wrote:
>
>> * Who's willing to mentor?
>
> As in the years before, I am willing to mentor.

I am also willing to mentor.

Thanks!
