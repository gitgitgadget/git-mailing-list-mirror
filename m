Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADC51F404
	for <e@80x24.org>; Mon, 26 Mar 2018 23:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeCZXH0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 19:07:26 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:33559 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbeCZXHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 19:07:25 -0400
Received: by mail-ua0-f174.google.com with SMTP id f6so13170794ual.0
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mvDgpp5RAiivmqKPPAWTh7VkUnttHfxizlMTwukbDlk=;
        b=HlsvWxRjUCukSA+hc11IuTrg2VRTIxYUEonX5faM5ePkOKXm6nBjDZydT5TJ/eErfG
         bRwGz9ekY+kCKN7k+pBmXnuSnE6WycHfLpfOykxmgiLsAvjzZBTps3Pf4V16JVeIgSSK
         zjYIUK6p2RxFvKrrhNSofxTtu7CPlJEEQGY6LMsYnqyK9MJgxWlcBXhUWYDoAiaxqSb+
         lCjDqKV4W2nTe/UbrVe1AeENFe2as+IcGZUrf/qawZS0TvvogpgAhn19WvMiZvxLh5rq
         3DC9JESFxPbmlsIbxYO95MwRCcmee9uRQkLsZx8CJkp9nNYffE/U+WYpVMC4NpWR70tW
         U01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mvDgpp5RAiivmqKPPAWTh7VkUnttHfxizlMTwukbDlk=;
        b=awKTHulHNR/O4nmv3H706Kh7IkUaQvycyAwfRsy6PEmeMVWsEXD5IWDF2HWDBQXR9e
         SZi6GvJmeeZ2lNBqE6aoZh0KnSiqRLkrYPICG3BASLBsl8QmCFoQu6A2BH+tgI4T+Krl
         j1JYL800ntYBRaN9M7O54HxRPb7pGBmw4+P9QpEysRoiVOngH6AufzdJhMTjSou2+65d
         EG4Nlec1J67YVoJkutY6T5Lm7aHzbNGhItoc/peeuC0W64FUYk9tlVH6MOD6bBUUXK/V
         YOkFEgo7rpNR1fqTdmRBJgJ8S9FmeA7QdZWCFXZPQljUxkqLkph2sgb3qQsDEspuMy7A
         611g==
X-Gm-Message-State: AElRT7GnWVnAK+2vpUu0PErCMXi1jlq5WIkRtWB4+xOZvGFJPZh6yF2b
        iJ9uoxAj8fq4I2HVsUelPjxecWTMCpq/2LPNlKc=
X-Google-Smtp-Source: AG47ELtDJaBsLonKGB6BwmJ3kZixLOj/mI/K8C7VPNj2E4VPrFe8u5YX9Ed3lg8JCyu3AvmwUA+MRmvxJZ97WLtQslE=
X-Received: by 10.159.33.227 with SMTP id 90mr21013121uac.48.1522105644668;
 Mon, 26 Mar 2018 16:07:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Mon, 26 Mar 2018 16:07:24 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803270007550.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com>
 <20180324074505.19100-2-pclouds@gmail.com> <nycvar.QRO.7.76.6.1803261722350.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CACsJy8Dz87YHiA48m_X7OmJXioKorUDNSyPy250jaqU7xt1JXQ@mail.gmail.com> <nycvar.QRO.7.76.6.1803270007550.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 27 Mar 2018 01:07:24 +0200
Message-ID: <CAM0VKjmCKmQisLZcBw7ZROQmg3bVTXTOK6auo6DjjkOfKdPv1w@mail.gmail.com>
Subject: Re: [PATCH v2 01/36] t/helper: add an empty test-tool program
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 12:14 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> However, it seems that something is off, as
> ba5bec9589e9eefe2446044657963e25b7c8d88e is reported as fine on Windows:
> https://travis-ci.org/git/git/jobs/358260023 (while there is clearly a re=
d
> X next to that commit in
> https://github.com/git/git/commits/ba5bec9589e9eefe2446044657963e25b7c8d8=
8e,
> that X is due to a hiccup on macOS).
>
> It seems that the good-trees feature for Travis does not quite work as
> intended. G=C3=A1bor?

AFAICT it works as expected.

When a build job encounters a commit with a tree that has previously
been built and tested successfully, then first it says so, like this:

  https://travis-ci.org/szeder/git/jobs/347295038#L635

and then skips the rest of the build job (see the 'exit 0' a few lines
later).

In case of this Windows build job we haven't seen this tree yet:

  https://travis-ci.org/git/git/jobs/358260023#L467

so the build job continues as usual (see the 'test -z Windows' two lines
later).

Unfortunately, I have no idea about how the rest of the Windows build
job is supposed to work...
