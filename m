Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1371F453
	for <e@80x24.org>; Wed, 19 Sep 2018 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbeISXed (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 19:34:33 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44361 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeISXed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 19:34:33 -0400
Received: by mail-pg1-f172.google.com with SMTP id r1-v6so3090827pgp.11
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EhPfmLdHomCqeDvyDkRopnOti+GtOi3SXCA/NPB6/pY=;
        b=FUz1pNDc73+dNS2Q83b6lvYieM0giN2vqdhthXEAYEM8SUFJwshbwIZkD9Zz+pj4yy
         9hrfOTAU4iOC4ERTxiLFHnO8zkWXaFmMYCu/RMSPU1/YzCtBH7+5OnzQM5f5gnmOcfj1
         mgteg8ga5HggdQDP8hFCoMIBBOmqM1n7t8q7TBFaY4WCop2Wuu4j4yuykn5YM5NWdnqG
         BF1dQtqPmC+5kytJI2/haUt4waKimWsuG9VVKzJchVOXw5zknJqYMb3PZGkyJniP6gRH
         0SH4hcKjceDkrtfP9wfOyClSlpsW2VKkcX2tKUdeUV/C6RIfUzxC3SXHjzM5FLk3sAjl
         TxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhPfmLdHomCqeDvyDkRopnOti+GtOi3SXCA/NPB6/pY=;
        b=cabYTFR7tkVe0yF/Ru+/vrbNBw3JwiQ+EXn3O03U2uPX2GNq81XUCXwF5wnfbMFSJE
         zbzapg4pslu0+Z5geJIxtrhnPJ9F9HOeIYoiTCf+AfyxUgckkPN2OXY191l0hlfQI6J/
         2/udEbkPeq1VgYsG03dRB9ZnenC8n5Y3svF8BOMSmSUgt8ivd0FGp5+aPGUPuBtrQhjY
         dTKPZqOEzdwSrbvP7XYw1g9+0UD2m0ogGSJ5W7LxHg618b3omkbK6r9rwp+8GDfx1s1N
         7+KmKbTgh9EQFZ8YD6f9vE9b9YOh7aQygkbgJFc6GGEJM3caBQVpT7gZa2+xJ6pWGQPP
         K96Q==
X-Gm-Message-State: APzg51Bsuwh6Bb/3Nz/IO/BziYWqoWJA7e4TwnNvLKIwUKP6/R4reIlc
        h7pzG1F6Ze6WAyApPcetOtWy8552U9HhGZFpD4nxVsbe
X-Google-Smtp-Source: ANB0VdYNngcIsDPpZWHqfyzeNu9PLFK0lHtF2QJrviISUcIxRXVVNreiYzcepd9pHe1neDBJSbJcRm5oK2Q65sk9uwk=
X-Received: by 2002:a63:6507:: with SMTP id z7-v6mr1862574pgb.200.1537379731213;
 Wed, 19 Sep 2018 10:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <e81bbd0e714221aac47b387e7d1e1572af32aa8f.1537375024.git.martin.agren@gmail.com>
 <377b7cfa36c3b23150005f7faec02bbc4a325bd7.1537375024.git.martin.agren@gmail.com>
 <20180919172143.GA60492@syl>
In-Reply-To: <20180919172143.GA60492@syl>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Sep 2018 19:55:19 +0200
Message-ID: <CAN0heSq7T=t7A9_jzTmNvj8SEfS0E6xWs-SFFwZjb2U1Ryqd2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-config.txt: fix 'see: above' note
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Wed, 19 Sep 2018 at 19:21, Taylor Blau <me@ttaylorr.com> wrote:
> I could take or leave 2/2, since I usually write ", (see: above)", but
> I'm not sure if that's grammatically correct or not.

Well, I sure ain't no grammar expert too... This is not a patch I feel
strongly about, so I'll be happy to defer to others.

Thanks for reviewing,
Martin
