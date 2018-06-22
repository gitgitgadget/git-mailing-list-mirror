Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5F01F516
	for <e@80x24.org>; Fri, 22 Jun 2018 07:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbeFVHaO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 22 Jun 2018 03:30:14 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39940 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFVHaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 03:30:13 -0400
Received: by mail-yb0-f194.google.com with SMTP id v17-v6so2196873ybe.7
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 00:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NKz5tgDkk0ea+PRxUqtaz6GImR6HVfa/Zkhsd+kvZJM=;
        b=owTRFxIpBTH2K3RipMF8OddtnWp0zboRRIfOUblYhnZEKVeec/gfh0vS4ShTUSXB6D
         8OVE8tw6w6xJdDk4Goe/4wRcjAT4DGF0bNyO0HJwsI/VWHXoqOumR3aoDbnmTcCakH9C
         SFlpoFE9GvldoyEc7D6XeCZFk+yB+SU6RU9Eq4tpTuai7KCktWIr4wMoWCZnreiW0duO
         Fu3Hg+GB2EB8rwk8Q2kU5HE3yrNwBOCzlkb9lihWiyh+j8IA1jkMl5Ng9qAOSNi7azcX
         xs1MocZDeDSvdOLeqzAeTsaDzlymuqqtKT0pnU2Oa9K/puqOWyYOveRVdd70Igw0oVek
         nj0g==
X-Gm-Message-State: APt69E2GdwwufpOSJoj0C1h0XdSCBGGSikNShJvOhYqrvZWsY8GTMWOb
        DjkREmplY2WI4QYuuYqXH5BL1Vsdxs78Bd6jh6U=
X-Google-Smtp-Source: ADUXVKId2jU78wbT7AVHDZTTwYAocfOUeEtyG+DxhBQfqyMDL4B/8kVkK4+3/g+qZ4pBWtD6I+UEsvA51MYdAufKdjI=
X-Received: by 2002:a25:a224:: with SMTP id b33-v6mr212429ybi.295.1529652612704;
 Fri, 22 Jun 2018 00:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180622065037.27155-1-ville.skytta@iki.fi>
In-Reply-To: <20180622065037.27155-1-ville.skytta@iki.fi>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Jun 2018 03:30:01 -0400
Message-ID: <CAPig+cRgLyjNW+7EwXZB-=xNej=FR_1dqneR8VaaHzFaYHiOBA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Spelling and grammar fixes
To:     ville.skytta@iki.fi
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 22, 2018 at 2:50 AM Ville Skyttä <ville.skytta@iki.fi> wrote:
> Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -354,7 +354,7 @@ advice.*::
>         ignoredHook::
> -               Advice shown if an hook is ignored because the hook is not
> +               Advice shown if a hook is ignored because the hook is not

British vs. American English, I believe. Since the project leans
toward[1] American English, this change is probably reasonable in the
larger scope of this patch.

[1]: https://public-inbox.org/git/xmqq4m9gpebm.fsf@gitster.mtv.corp.google.com/

> diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
> @@ -146,7 +146,7 @@ To get the values of all attributes associated with a file:
>  * Iterate over the `attr_check.items[]` array to examine
>    the attribute names and values.  The name of the attribute
> -  described by a  `attr_check.items[]` object can be retrieved via
> +  described by an `attr_check.items[]` object can be retrieved via

This also collapses the space-space to a single space, which is good.

All the other changes look fine, as well. Thanks.
