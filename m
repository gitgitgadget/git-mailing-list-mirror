Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C4441F404
	for <e@80x24.org>; Fri, 31 Aug 2018 03:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeHaHWO (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 03:22:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35106 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaHWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 03:22:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so4825670pfh.2
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PclUqidZO1/CKAdQ64sIPQPflAku+dzr98hVJEYo5m0=;
        b=iVrINY1vnaD0/HWEEeGZL3XCDSPGw8ROeZUdd5hxsak3b0h6Idhv3iIafnOg15jmVE
         7yEEy+toiDoPzSy9ONRCpXAfheLaB3/Oat9oCgweeFnPV9YnknA0yUcjZIimYnUJDV8O
         dIXIkAUrwQMK9GDuNUfkDmVhrThj6KR26Q8EY3ozC0AWPyqakwJdLWnyCiAfBx/NH2y3
         Lh2rv2bzEP3XMjeoGAZbdZCoFlqwYjVe9QTyqygusE+A/317nJpbqFT4+Nq56TXwu1i+
         3tvtGVvPo2vV/NExblhoqnwbZ4KDrLqFYnAfRVrZybDOq2Ql2hX2ETC38VWrPDpnWaEK
         ElxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PclUqidZO1/CKAdQ64sIPQPflAku+dzr98hVJEYo5m0=;
        b=e4TChv7QxaPgBeqNnwqu5xu9aHne8Y4NLlfSwwWM4ltR5vrOQ1cR+KuYD7dM0FLtF8
         f7S9GIjDeV1FL1mRB7SFi2RE7/2ZZTepcz0rRW60nYOLGFZSMcSPfq4OH0V8J2O57jtm
         kHhIbPokV8MhnhzaV9nuTxHFOzJMMFPw+IRRur4EHZ3u7BLQXelNP+nAe3/91qpCSGye
         Nj5DDXPQSCTRrQEoZpHrywmYGuQhYRWCk0grE/EnaC1IggOTWZtkb0ZS4w+NSI/a0v/X
         G++hQ05/QfnyPH2NMi2H1ISPG5Bl2CaP6QSKS3jnsfexle9+lrAQVvbahMg2vwQqXcOy
         sNvg==
X-Gm-Message-State: APzg51AJ50EHJoeVeBC7SyclOtYICC4fIUSUaXXG53fipky78sZji4Ff
        UsUyP4U2Wr0yfD9BHKGZQPmrI2aT
X-Google-Smtp-Source: ANB0VdbqXaCI5aw2OrMj2TFN1KzR0b3/O9ssJp0NLPgv7TJ7CAwgEaeo01nIKuIM+oTf9liIgfLfiQ==
X-Received: by 2002:a62:9c17:: with SMTP id f23-v6mr13584692pfe.209.1535685417086;
        Thu, 30 Aug 2018 20:16:57 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h85-v6sm14350872pfk.71.2018.08.30.20.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 20:16:56 -0700 (PDT)
Date:   Thu, 30 Aug 2018 20:16:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Wesley Schwengle <wesley@mintlab.nl>,
        Git mailinglist <git@vger.kernel.org>
Subject: Re: Feature request: hooks directory
Message-ID: <20180831031654.GB98946@aiede.svl.corp.google.com>
References: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com>
 <87pnxzdib7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnxzdib7.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> There is interest in this. This E-Mail of mine gives a good summary of
> prior discussions about this:
> https://public-inbox.org/git/877eqqnq22.fsf@evledraar.gmail.com/
>
> I.e. it's something I've personally been interested in doing in the
> past, there's various bolt-on solutions to do it (basically local hook
> runners) used by various projects.

A few unrelated thoughts, to expand on this.

Reports of experience from using local hook runners would be very
welcome so we can benefit from their good ideas and avoid their bad
ones.  That was part of the motivation for not building this in for so
long: we want people to experiment so that the result can be something
that works well for a lot of people.

Separately from that, in [1] I mentioned that I want to revamp how
hooks work somewhat, to avoid the attack described there (or the more
common attack also described there that involves a zip file).  Such a
revamp would be likely to also handle this multiple-hook use case.

As a word of caution, today we support having multiple credential
helpers in use and it's a nightmare to support.  The layering model is
complicated and users don't understand it.  So we might want to try to
avoid whatever went wrong there. ;-)

Thanks,
Jonathan

[1] https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
