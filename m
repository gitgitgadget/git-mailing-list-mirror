Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11761F404
	for <e@80x24.org>; Thu,  5 Apr 2018 14:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDEO1N (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 10:27:13 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50889 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEO1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 10:27:11 -0400
Received: by mail-wm0-f51.google.com with SMTP id t67so6333148wmt.0
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YwppCVh/a9gGFvhuJ0GgUAEeALrJgsEDUV4YInBqGhE=;
        b=qS/i3nbLhBAWMRkBHaManhLfab+KS41VI5z6Z9+BpDK2l8wZdzF2c8zBdjW+7NZgQY
         2HqYUg+BvaOsnSzH/tDVx8EHaom9YdnTx2RZIVNfSWZtZ/3IbP7Zlow1F12ojBtA0nL/
         qvGetT9bezr4Go+Xjn14KoKTG3dH2nUktrs4q7xPdLLX7z1ABc6btAB5VOwUmW1/l2Gw
         4zHSeSyQTC5bXH8uVF2xcEr+L3Bi5SaYlNKYIc8aKuaC2gvnyZkx72SMWhOtrwIyv7sM
         leFRG1CgZQkI6Ztcw46FY8QhyXKUtwd17YEylEWyaF2jfNMMsTrqWV5r3MfE+6XK780A
         RYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YwppCVh/a9gGFvhuJ0GgUAEeALrJgsEDUV4YInBqGhE=;
        b=d/UWFnxWuUC9ZWKITSEshoKgC/fe1G19al820u9Ocrh1g2ZjmCdQX+HOaHb8E/k4KW
         H+e3rjrjIff1+w+bLa4nS0WOzYyWwnX+vsgXIpD6IC38pnVZb8GxXSmtu/n8YSOCqpRM
         M4FJn8Q249HSLterXu6e++unh0OgqGwG5U3iLEqnjwvFTKM9trsJnzFdVVvGGxURnQN6
         kC28NdvtqOmusA/tzwnTIc/K4+UlU4aEJ6fGSMwP8Bm4FvoTDa+szAHIlD7eHVdRjVn6
         q8LtKPxiUhKFN1xgEvkCMA5pGDtP71iwkp3PqU8Oieg/d8BSHhzyRf5OD0gA45+003fS
         V3dg==
X-Gm-Message-State: ALQs6tC/jO6oYtn6kpeWAbBwYyESRRS9fSfYfHy1Vfpzi0NnTQ+32667
        sD9vD4EzIeAZZ4hFWfJK8hHDXYBjqaZrysPs1pxRpsPz
X-Google-Smtp-Source: AIpwx4/ZFVLLCNcbCCE+HO1oxUT+BUZ69HKK6B40KXFhYxk0Tzu8tTnf7FgwUNjRYyRaG53F/sp2qyQkF+DO3UTjTEI=
X-Received: by 10.46.145.147 with SMTP id f19mr14350656ljg.134.1522938429869;
 Thu, 05 Apr 2018 07:27:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Thu, 5 Apr 2018 07:26:49 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804051536080.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1522190580.git.wink@saville.com> <nycvar.QRO.7.76.6.1803301231430.5026@qfpub.tvgsbejvaqbjf.bet>
 <CAKk8isqA6Ru05kRJ+xiVHEkzPgH24cKUZbbgw2tEnw4rhafDQw@mail.gmail.com> <nycvar.QRO.7.76.6.1804051536080.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Wink Saville <wink@saville.com>
Date:   Thu, 5 Apr 2018 07:26:49 -0700
Message-ID: <CAKk8isqGe=H7aEtDZtKTpzQMxeshp0oC6tMwhA9rW=PhLt3buA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] bdl-lib.sh: add bash debug logger
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 6:37 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> After thinking about this more, I am a lot less opposed to including this
> in Git's source code. However, as it is not necessary for Git's
> functionality, it should probably go into contrib/, and I would much
> rather have a more descriptive name such as
> contrib/bash-debugging-library/...
>
> Ciao,
> Johannes

I'll move it, thanks for the feed back and considering it for inclusion.

-- Wink
