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
	by dcvr.yhbt.net (Postfix) with ESMTP id 716241F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfFYJlN (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:41:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45645 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFYJlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:41:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so8542825plb.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqFH0UQkqUvfBKDw2OCKJ0VYbY0CNTtOwB3F0SinG8E=;
        b=Md2RSUT7Ux4JE9tnuMAQvbhP9txhFsf429uXAK4Bvah9Wn09z4c+l2aHTGXNt5Tu4r
         Bmn/80SIdg2JJA3eCRkrYsYxvIP96DOfHT1fCy29PnpL00Y8sY1plmNYYKPpBYY0kOSW
         w8Z4lYXzmpR/gRjHpsbnljJ3KgydiQp8UHOL+kew5Ek/vsent5i75Tr/5uQ4033rnWDC
         0PVpVH9KQJWbxm8IVbJw5AvFnzZZkgtvfs2cyN3XOVuM/6urVCbGNrgM3rMh9gxkya2l
         p03zT4MqfWt6KVzwVJIqDcVRid9skbUcsT7SO6RDYs3ej3EAaVXkGIsoahy7M/mw/7KY
         +X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqFH0UQkqUvfBKDw2OCKJ0VYbY0CNTtOwB3F0SinG8E=;
        b=lKxkDcW673gRGALZTGi+otyDqHfkS3CFEUpzb8DS5iUsHDwqElAcEwVLiGpqqfyDdr
         yHNzlONl7Q3FcDtHq6h+v4KwtnncJ3tGmrBy3/08lHfxsDVPMSnoSuDyiwBjR2BD4bxR
         PS+YeAIzHLzRXFZroDAAJEN/tLpwGhVt4xPFV/opGmveOaWFHhcTXlwSrCSDu8LsDryH
         KziKQMI5KxFI2gEz1DA6JIGIjcx/c4qyzV+mrI1ACXamzo8bIV6gQ3l4ScuAQfoSEbSH
         qBQ9Bvn5Dk8NimLJu9kl3tv4zCus2KmUa+Wc9txKVH85UuNPXXYRV3nhKdYwfycQOFcB
         OaEQ==
X-Gm-Message-State: APjAAAXY+xER82rYhOAthRWTeiNtwg2KC59RS917tu+JE0OhSqeUbGf8
        tiKAhv5UbqnZCXVv93HwhAjEZ0rUyF7it9NOrP4=
X-Google-Smtp-Source: APXvYqyOH0nbZ0l/cb38Uxw1eolb3+/md6g3YeSOLx/nRHRVU2ETpW3LppdT3zNH3CFeSJc9HzYXz/2c1kUduIrzG+M=
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr38908400plb.79.1561455672461;
 Tue, 25 Jun 2019 02:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 25 Jun 2019 11:41:00 +0200
Message-ID: <CAN0heSraZh+j04qjeaVtS5bsNoE=Hf_FBU-kfcB+69BkZz+zHg@mail.gmail.com>
Subject: Re: [PATCH] doc: fix form -> from typo
To:     Catalin Criste <cris_linu_w@yahoo.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Catalin

Welcome to the list!

On Tue, 25 Jun 2019 at 09:43, Catalin Criste <cris_linu_w@yahoo.com> wrote:

> @@ -88,7 +88,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
>
>         This option is deprecated in favour of 'git stash push'.  It
>         differs from "stash push" in that it cannot take pathspecs,
> -       and any non-option arguments form the message.
> +       and any non-option arguments from the message.

I think this is actually intended as "form". It took me a couple of
readings, but what this paragraph wants to say is that any non-option
arguments will be used to form (construct) the message.

Do you have any suggestions as to how this could be made clearer?
There are at least two of us that have stumbled on this. :-)

Cheers
Martin
