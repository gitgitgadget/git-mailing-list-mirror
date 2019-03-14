Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A900320248
	for <e@80x24.org>; Thu, 14 Mar 2019 16:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCNQXs (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 12:23:48 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:41523 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfCNQXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 12:23:48 -0400
Received: by mail-ua1-f43.google.com with SMTP id 46so624737uan.8
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0UCJTYHKY36lg/3aQzOjxpf8zJ4UMJy2zI1sn38Kqk=;
        b=drrA90ib9+e9MGIV43idXoP2lA05KiuVFj7vSdKdY4IWWlJNUQreUxfUfz1/shyC7C
         MyRT3YBTw2vIep/0ucU4bDy/zPYK3vvafgXkO7pUANL3fCy4N5wyxk/JKnPMP5bXKI6M
         KLbk0hyyQyc7DWIDVOLB836d2Zx9uA9AYoJ85mBAcsW0gB5wKOUMgC0MKHgq6VZg3efv
         knEqHhyZl56YP+UXnTIP4mZ4xsA4fpEu5XgjZGPe+zgg0ybo1PXd2+zNYLtZFOu+tIpx
         GOHJAgrfnGdajdk7vY66/XmSXNVtoI4uR9uZLhU2yNAZcdOsNdsCx5/zoG70t4OKtyBd
         EbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0UCJTYHKY36lg/3aQzOjxpf8zJ4UMJy2zI1sn38Kqk=;
        b=P0pNvaUfF8iY5iGrkcIKt1f4WHoH4VJXEKCp9PdajrXdEvlCf3vVa9s/BvudV/j931
         sbayldHNQs008IkcQw3PbG70lo4uz45JyEmba87XLTypeMdN5w0/ubZHzYw8QzA2derE
         Vt4K0loc1bAt52e/52ONrASByWHIElOuG2wrxx1WFOA3Z9wSpz+uWhYnDpQN0QJURN5V
         AUXSncQu0Y+AXWN533SVekiNPUKas6HNe2s4rNjL+DwkNMJ17c5vfgcE5zOILHjE9voG
         M/1Tz7PEy8Cc/B+25lzBG9hzGbVcZz/+Eo2dDsDHoaw0rRpfd1SOS/SRABUEXlM2/V8R
         Auzg==
X-Gm-Message-State: APjAAAXxf2IFa23mN4x3PKM1NnA/34nuCkgPCfSV/9W6JuX3BWFFkZQ5
        zg3cBQROPN6fRhXD4uDscVI6vvwIV3e64Us/nmBzwg==
X-Google-Smtp-Source: APXvYqxtArm6W//B+pbiY+BgFbfyQRXo5tokEGmhyCO5G4PkMuw/wBzXXP3mt+egz/7FWRFWBZ9wZZqYvT5ieQ9AbWw=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr26078381uao.20.1552580627153;
 Thu, 14 Mar 2019 09:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190313205539.GA30425@sigill.intra.peff.net>
In-Reply-To: <20190313205539.GA30425@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 Mar 2019 09:23:35 -0700
Message-ID: <CABPp-BEj3oxdhcFf-jQJbkCTOhjT2E-yMJhCpdTAbeb4xVTVAQ@mail.gmail.com>
Subject: Re: straw poll: git merge conference location
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 1:58 PM Jeff King <peff@peff.net> wrote:
>
> I took an informal poll at the last contributor summit in Brussels, but
> that obviously has some bias. So I'll ask here: do you have a location
> preference for a Git Merge conference (and associated contributor
> summit) next March?
>
> We're looking at doing it in North America, but there are two specific
> questions:
>
>   - is there preference between East Coast vs West Coast?
>
>   - preferences between Canada and US?
>
> There's no commitment, but please only share your opinion if it might
> actually impact your decision (i.e., if you might actually attend the
> contribu summit). Feel free to email me off-list if you don't want to
> start a flamewar about countries or coasts. :)

You are probably not surprised to hear me vote in favor of North
America, but I'd like to point out that unless some responses didn't
reach my inbox, it looks like 100% of respondents so far are in favor
of doing it on this side of the pond.  ;-)

I'm fine with East or West coast, US or Canada.  Very minor preference
for west coast, but whatever works for the most people is best.  I'll
even try to go to Europe again if that's what works for most people,
but I might not make it if it's there.
