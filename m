Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAC11F403
	for <e@80x24.org>; Sat,  9 Jun 2018 20:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbeFIUOb (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 16:14:31 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37444 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeFIUOa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 16:14:30 -0400
Received: by mail-ua0-f194.google.com with SMTP id i3-v6so11101980uad.4
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jyuF8D1usrSLgtqXBTvyCQEZQFRISIFhwZU32wozW+w=;
        b=d7VxhOpaE6oBOgOdF3mn2V+GhpU/U0RggzbYAjfd3WiEDqwzWmVLK7F8SRwRnYsXDy
         vCIcELeWcbVkY9dIlAmUViohMheUft8sFNTC6toNSL79EIUEkhNPTMKAR6SetTZeosR+
         jhFp1v9R0Kf9Vo/KkF1MWJyfbfecyl9T00jQ+t8X7k1wi+jhnT8KeCupj17jJe3EWxGu
         x/yqEvyEhL0wm6yVY3YfeUc4946IGo8ghtK2YP+aJjt3iEZbEs0YnMnX0f0fmQ7Ut679
         Zi/ZdAFIt1vLYSaLwGUQ2R1KrtLx08LX6Km4a70JOns0CxgqV0EL0v9VuYWSMJPPjGtg
         auIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jyuF8D1usrSLgtqXBTvyCQEZQFRISIFhwZU32wozW+w=;
        b=WX96YTsGGqf4AUwi3b2ZRS96/2P1FLL6vTuDyWhXnhI0TUYsDddFdKeBY+pFL4pDk7
         PJYH/5ecs71jKfBp/0XqSwutXl+5ahO3EBFMFZM6lt7AYGRUFWTBiS0JRJnpu8s9iIVI
         PIN6rsiNrs8jGBVLV0Th5YLtLayePmWxW0+D+XMIVsnjCGYlBglsRKzAsYrm+VNwmxT/
         sAmqeh/2NQ6H1BR1IW2Cs3HKnOYUpFySnRQs+mMQG4vXQWUIS81aHIFzejqdOx/q98oJ
         sRiThyzyFJtgtkE0sNq38KlT8pMc0m3CGuHsl0+Iei/uqUxWbRygT3NciiKLizbp0GEZ
         k8lQ==
X-Gm-Message-State: APt69E29CRZ7MKvSgzAdJ4/Aw+GLobrcaPmRr8r+aT+Smrbd1+sw8DUx
        AyIiFakiyd97Xp6dtR+yU4BfWErLdDHf2DtC1Ao=
X-Google-Smtp-Source: ADUXVKJvQDNrq8o5IMbl5Wk+RIWgonhzhLSGDZ/xiNwdUCCyG1kka9SDamoBRkDSqA+BGcqrJHEQgBBrpW+uue4867g=
X-Received: by 2002:ab0:4c82:: with SMTP id y2-v6mr8020032uaf.94.1528575270134;
 Sat, 09 Jun 2018 13:14:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 13:14:29 -0700 (PDT)
In-Reply-To: <20180609151943.7387-1-kyle@kyleam.com>
References: <20180609151943.7387-1-kyle@kyleam.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 13:14:29 -0700
Message-ID: <CABPp-BG_4WRP=-m7RfqAdYvOrM5CnByHZ=yghPqTdOcL2NGjhQ@mail.gmail.com>
Subject: Re: [PATCH] gitworkflows: fix grammar in 'Merge upwards' rule
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyle,

On Sat, Jun 9, 2018 at 8:19 AM, Kyle Meyer <kyle@kyleam.com> wrote:
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---
>  Documentation/gitworkflows.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
> index 926e044d0..ca11c7bda 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -107,7 +107,7 @@ the unstable branch into the stable one.  Hence the following:
>  .Merge upwards
>  [caption="Rule: "]
>  =====================================
> -Always commit your fixes to the oldest supported branch that require
> +Always commit your fixes to the oldest supported branch that requires
>  them.  Then (periodically) merge the integration branches upwards into each
>  other.
>  =====================================

Thanks for sending in the fix.

Reviewed-by: Elijah Newren <newren@gmail.com>
