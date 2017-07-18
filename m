Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA6A20892
	for <e@80x24.org>; Tue, 18 Jul 2017 01:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdGRB2E (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 21:28:04 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35688 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbdGRB2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 21:28:03 -0400
Received: by mail-qt0-f174.google.com with SMTP id b40so5023030qtb.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 18:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DiKvk7aqGEdj74p0FR5rY/N9CXUpgsPfCn69JD66WWU=;
        b=Ae6CWA8NjufwrkIpGre8ydZUAd1JcUB5YEXUKw97tADDFKMEYYJ0ioR7KnpBT7jsR1
         wioGO32YI3HG2M1bOUPQPmQ2sT/C+22evYoNVdAuN53ZDiuT4bao+peow4rQTmdeSZYo
         GGKTWhLseVZIodqEtQ4RODHRV8SoEu/PW4zbOkTQ5g3Bc0ynraXOL33KmgHUhGlncGmi
         CpUir/fzcypMqk8Os2dLDg/MReVyapHT0VHtdTmR8jxcelPHLJI8qBAuHH+yLzJVIBNo
         gw9OztguABJar4AXpiwGghYbVCGIaPbmGcEDnuAfjFsFGtNDWVG2nwlk8q36ZcctIMw1
         B78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DiKvk7aqGEdj74p0FR5rY/N9CXUpgsPfCn69JD66WWU=;
        b=eqgSWxmgEsko0JWdNNr+AqNHZTV9awzfFs+rQTt2+3zwEaHq7EaC7kaFCZVnydDcuN
         Wdq//VmPRRD1YUMdjtLw1nN5Kzv5x0x8YzSF/OFgRDefzCzCz15aYJTMvr0bRFCxbwBK
         BHYa08JkSZVDPj7DvYJY3EZ7DAb/xSu9tBih7ee7HioC3CmCz22dJVCPiLflxDKGQDhC
         OPrBY6VfHvaNArt/IxORiesXSZE9N7tsQLFI8wJhki/WQ0wsvZZY2pGkgFCwZ9lpHGmF
         uAD3arIbRA/csQtFeoeiMaM/4ofVBCCqUrh/vw2U48BqdzXxJ/psO5HWbIZYbX49Wb9J
         E5pA==
X-Gm-Message-State: AIVw110/gcL21Ml45vG2SDgpTMYSjwO7/cKHuK+yZW9JS4eIrCufmh46
        J6C4w6OKrVHPcbi/z5t6vzRCmriGvQ==
X-Received: by 10.200.58.161 with SMTP id x30mr413753qte.69.1500341282805;
 Mon, 17 Jul 2017 18:28:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Mon, 17 Jul 2017 18:28:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1707171805460.4193@virtualbox>
References: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
 <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <CANYiYbGyCbzxPuiUUD5XBo2zAfKiZ9XQcEu_=s8XxsMGP1J4Og@mail.gmail.com>
 <alpine.DEB.2.21.1.1707171805460.4193@virtualbox>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 18 Jul 2017 09:28:02 +0800
Message-ID: <CANYiYbEE+kmRAuLnDcWfLOJud_9gQuHGo8uZCr3sMFFaWZ987w@mail.gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Alexander Shopov <ash@kambanaria.org>,
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
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-18 0:06 GMT+08:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 17 Jul 2017, Jiang Xin wrote:
>
>> 2017-07-16 3:30 GMT+08:00 Jean-No=C3=ABl Avila <jn.avila@free.fr>:
>> >
>> >
>> > A few remarks on i18n:
>> >
>> >  * commit cb71f8bdb5 ("PRItime: introduce a new "printf format" for
>> > timestamps") does not play well with i18n framework. The static string
>> > concatenation cannot be correctly interpreted by msgmerge. I don't kno=
w
>> > how we can combine variable format indicators with translatable string=
s.
>> >
>>
>> We can add a new wrapper for raw timestamp like:
>>
>>     +const char *format_raw_time(timestamp_t time)
>>     +{
>>     +       static struct strbuf time_buf =3D STRBUF_INIT;
>>     +
>>     +       strbuf_reset(&time_buf);
>>     +       strbuf_addf(&time_buf, "%"PRItime, time);
>>     +       return time_buf.buf;
>>     +}
>>
>>
>> , and replace macro PRItime in i18n messages with format_raw_time
>> wrapper, like this:
>>
>>     -                       strbuf_addf(&sb, Q_("%"PRItime" year",
>> "%"PRItime" years", years), years);
>>     +                       strbuf_addf(&sb, Q_("%s year", "%s years",
>> years), format_raw_time(years));
>
> That would come at the price of complexifying the code just to accommodat=
e
> a translation tool.
>
> How do you gentle people deal with PRIuMAX?

Can we just use PRIuMAX instead of the macro PRItime?  PRIuMAX can be
handled properly by gettext utilities, while PRItime not.

If replace PRItime to PRIuMAX like this:

    -                        Q_("%"PRItime" second ago", "%"PRItime"
seconds ago", diff), diff);
    +                        Q_("%"PRIuMAX" second ago", "%"PRIuMAX"
seconds ago", diff), diff);

The above l10n message can be extracted properly by running `make pot`:

    #: date.c:122
    #, c-format
    msgid "%<PRIuMAX> second ago"
    msgid_plural "%<PRIuMAX> seconds ago"
    msgstr[0] ""
    msgstr[1] ""

> Ciao,
> Dscho



--=20
Jiang Xin
