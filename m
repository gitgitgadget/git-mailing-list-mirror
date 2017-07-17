Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4D72027C
	for <e@80x24.org>; Mon, 17 Jul 2017 00:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdGQA4z (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 20:56:55 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34509 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdGQA4y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 20:56:54 -0400
Received: by mail-qk0-f176.google.com with SMTP id d78so109569979qkb.1
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 17:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=giTJlOXsLursuVXMJ3A2e2AT90crSqIUQ8EGEGH44xo=;
        b=rI7kiXKkPv4t4n9B/hFJxZhmGj2ZTzBPJkedpCqUXyd1Yjlh2QuDCkHqzzUfIKIJ/L
         dNqEGbZcfw3dTiYP0FldwMBD8BhUE1FIerfnf644QrWGJorUaBhivJ0y6jnBFc+lB46W
         cqe6VCuj8rBIYwmjDwE4KhwTdh9uvQlrV6Qjdt+aLkEtY5VtZ/m4HcdtfifRa83QfsKF
         BREkJNoltY//UUpzNFutQmd7RDvNTHwGx9GvP8hOhBWouebBerC6YZFM0moHUtXDl1mK
         9BcsSenw5cuhD4sBLUXe55OeJBLp0+WyIFRyJ3q14RQRi7ZXab1Xj2uWds7YmHhMEq2H
         0Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=giTJlOXsLursuVXMJ3A2e2AT90crSqIUQ8EGEGH44xo=;
        b=bQ2Xamh2ujOxr1SaEONnmysn2GNjFhE2PS4G3R+F8OYkIeLayEdqOESESrpL6FkJw2
         oUGLBqmLRPjLGjPpUJWICVhrHz2ItJoDtbI8sCLyzkDRfA/1usc5mEy8umpgn5PmtAKp
         DTSBxzkIzacweM7/DQWRXT0GprdinNjOVmvWVJQ13OqkntF/LUSCnZeXtvQkJewTsy2C
         Zv1Hxr7zYdAIAvlsR4oAmcRxUsLKeU/HRKvYVgCsExoNqr8SMJGUMPconYUnCUPy7+97
         AgjJORy33FTmzsZtywwXlpT2iCV1P6Zm1tOnzGnZsGmOuR5gmBjnmURLD2166fj0iH2U
         TESA==
X-Gm-Message-State: AIVw113o+Z9awD/9JRMrDYYX9aoVKR3/C9VjIocb+m97Ejs8EGifAmvl
        G98xekyteBw2oaXvSf0hs+eWyDhqbg==
X-Received: by 10.55.73.202 with SMTP id w193mr4254201qka.264.1500253013947;
 Sun, 16 Jul 2017 17:56:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Sun, 16 Jul 2017 17:56:53 -0700 (PDT)
In-Reply-To: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
References: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
 <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 17 Jul 2017 08:56:53 +0800
Message-ID: <CANYiYbGyCbzxPuiUUD5XBo2zAfKiZ9XQcEu_=s8XxsMGP1J4Og@mail.gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>, m4sk1n <m4sk1n@o2.pl>,
        Vitaly <vitaly.gorodetsky@gmail.com>,
        "Ying Ruei Liang (KK)" <thumbd03803@gmail.com>,
        babycaseny <babycaseny@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-16 3:30 GMT+08:00 Jean-No=C3=ABl Avila <jn.avila@free.fr>:
>
>
> A few remarks on i18n:
>
>  * commit cb71f8bdb5 ("PRItime: introduce a new "printf format" for
> timestamps") does not play well with i18n framework. The static string
> concatenation cannot be correctly interpreted by msgmerge. I don't know
> how we can combine variable format indicators with translatable strings.
>

We can add a new wrapper for raw timestamp like:

    +const char *format_raw_time(timestamp_t time)
    +{
    +       static struct strbuf time_buf =3D STRBUF_INIT;
    +
    +       strbuf_reset(&time_buf);
    +       strbuf_addf(&time_buf, "%"PRItime, time);
    +       return time_buf.buf;
    +}


, and replace macro PRItime in i18n messages with format_raw_time
wrapper, like this:

    -                       strbuf_addf(&sb, Q_("%"PRItime" year",
"%"PRItime" years", years), years);
    +                       strbuf_addf(&sb, Q_("%s year", "%s years",
years), format_raw_time(years));




--=20
Jiang Xin
