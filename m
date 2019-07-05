Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E9C1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 13:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfGENdX (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 09:33:23 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52763 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfGENdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 09:33:23 -0400
Received: by mail-wm1-f46.google.com with SMTP id s3so8887050wms.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=x5WUE19jpqIblEqDxmUYx3KzbmRLQGUQRmlo4bionxU=;
        b=Itx15ld7jNHho858MsX7yFagFuMtKA5fw7crYUghXAl9fAArZ5TX50OVDWv7oMkenW
         ZNOaqSBik0JgtMjJc8Y1hangGXsdAUvqovpz/wJYqtiJudmAmchdfsYTa2P34pMRtbl/
         LYIQnW36csRcN8hYnkyptEOigoBVnDT+EAU4zqiIE7POxzwoyBSRKUmg0IVwv4PzrxvA
         uCm6P01VjFJOSnjWoEenIeOxAyqH0IkOYN+IOyBPyAbsBxkdhKXa6b19F59M984YfEyy
         FfALvTo1UF3J4pmp5VP0xWdT9u+GnWd8xkXwvLwBCWloz92xIq8/aylIEqDzS0D0654U
         ZUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=x5WUE19jpqIblEqDxmUYx3KzbmRLQGUQRmlo4bionxU=;
        b=ktRTl1p0oeozXsWmQrZci4bm057jE5yC+mbxQPrfI1xmEmLtaV13IpeFvOJKktxzP4
         L5YBAl1F/ePtnZkyCTf3nXALP7JHEt84k+z2Wwlkox80rKjzVqUUptUA77fGo77RauvT
         q6qr1cMmHBHOQ9G7dLvq4V4lyN0pEq5J64LubqR0r+6Zy6Vd3U7jmByKcVypZwdEtNwV
         E6anRg0UZ+ACmlihFnSpQlkjWARxsM0uOngNZVE6EDzSSCwB9q670IxJMqfd9R6xjyLu
         FQTPh4aL7YFAjC3f4gLCt79910OWst9coXj+jTY1CyhevaHL51+qG9b2qtvspg/Dv62b
         HCpg==
X-Gm-Message-State: APjAAAU+ZLztBseIwJKjJ/cGVvy8CkYxhSgb8L2KCS1HZ5reThqk/i4Y
        4I4E+b8p3xVJldbGCUPymgI=
X-Google-Smtp-Source: APXvYqz98A6jBdwVfwSH0zGwqkn2PTRIQ1/syLF+pbWlpSVL2JDdu2+Ekjt3Dox9O7gJdni4aCnShg==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr3539209wmf.162.1562333600858;
        Fri, 05 Jul 2019 06:33:20 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekg120.neoplus.adsl.tpnet.pl. [83.21.174.120])
        by smtp.gmail.com with ESMTPSA id q10sm8606377wrf.32.2019.07.05.06.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 06:33:19 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>
Subject: Re: Virtual Git Contributor Summit
References: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet>
Date:   Fri, 05 Jul 2019 15:33:19 +0200
In-Reply-To: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 3 Jul 2019 15:01:44 +0200 (CEST)")
Message-ID: <864l401u8w.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Team,
>
> I kept talking about this idea of a purely online Git Contributor Summit,
> and it is finally time for action.
>
> The idea: just like the Git Contributor Summits we have on the day before
> GitMerge, but instead of traveling to the same place, we'll use an online
> conferencing system.

By the way, would there be GitTogether meeting held in conjunction with
Google Summer of Code 2019 Mentors Meeting?

> From my point of view, the main benefits of doing this online are:
>
> - It should make it easier for all contributors to attend (yes, Junio, we
>   do miss you every single time you're not there).
>
> - We will leave a substantially reduced carbon footprint.
>
> - There won't be any jet-lag involved, including the consequences on
>   health/sleeping.
>
> - It is substantially cheaper and more sustainable.
>
> Of course, there are also some challenges:
>
> - Timezones. My idea here is to have all participants put down their
>   preferred timezone and then compromising on some sort of Median.
>
> - Timing. As it is not attached to a conference, we are less bound to a
>   specific date, and that flexibility might make it harder to agree
>   on one date.

Also, all the challenges of remote-only meeting instead of real-life
contact.  Though it might be good supplement to the meeting before
GitMerge.

[...]
> To coordinate this event, I started a Google Spreadsheet where we can
> decide on timezone, date(s), number of days, and later on try to imitate
> the sticky game with virtual stickies for the discussions.
>
> I will send out an invitation to the top 25 contributors (according to
> `git shortlog -nse --since=3D1.year.ago`) after sending out this mail.
>
> Obviously, there will be more people interested in participating; Please
> do drop me an email if you're interested and I will send you a link to
> that spreadsheet (as I do not read my mails continuously, it might take a
> day, but I will, promise).

I think it would be good idea to have some of us from Git Rev News team
to chronicle this Virtual Git Contributors Summit meeting.

Best,
--
Jakub Nar=EAbski
