Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC531FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeA2WzD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:55:03 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:37868 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeA2WzB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:55:01 -0500
Received: by mail-io0-f172.google.com with SMTP id f89so9396157ioj.4
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZvsyhfHglzVhXfqsaRuEWpoPpYEiPrVFvDh3tdQ89oY=;
        b=RD+9yjRecODtWuRVXTqKp6cEQvhvGI7B/Dz0oGR3dGJmi0ApBakz0q4CxkMmCqbPFY
         ZxV0CGDWBP+orn+j9PXKJWh6xs7GOg9REyXiCdTwGQIOuVaEYKMDI4Qfdn0VyK9FMGZl
         A/T3IKsBsTED/ibN1tGg1BK6CvI/tC2kFkYLNYhCncBEs739WN9HkP1MS1woZ37C7Jr4
         uM7nU9HqC0SEdL0md9Fz7u7RHjRMxvYLUt2j5+BJ/J7M8G5v0LXiXR8dF6dAWwLaXcGr
         KxLxFGzXiFR42uUygHWWtQyRVaMqjX+On12JpyF18GyHz9yCFPPVuplEpr4+jyczuoCd
         FRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZvsyhfHglzVhXfqsaRuEWpoPpYEiPrVFvDh3tdQ89oY=;
        b=jgQEMsZPW4VldW64MaYnRAB6BMFzcdmWxMxei6cN+dpe2jfVHmwLLuBPfYmkec3WVG
         +bkqM/vstReNWLfjHVOwm3DJGZeXmBsGfZdj0UQuJnZRAbzyQhI7n0YycUDpO9NdtWFm
         gnc+AHhOMq7mbpU+0c+mAgN7JnVDO2N+V7PT/oLSEu8wvZKSmC0lFBr9MSYtMUy80aSR
         gfF8sgiFeVm4venB8InrLRT57HgT+MzuxLjkfZWqPIyPPrxpPnOF0z4eHp3x17W/R7Zv
         jEdZBZlhJpfrm42oocwlnrYkd3gOTfi7jmd3yJZubksgue6QTOG1dGYAlD6kp6mtbMN+
         gQBA==
X-Gm-Message-State: AKwxytfJpLXmpM4n1/k12yQWZwA0RWft6Ft68M3JyOsdjhjUrpHDKbQd
        PBUxVpyIQrh3Do9WYuS2ARqYTI7HwGON+uvh/+7jZelM
X-Google-Smtp-Source: AH8x225DNJw+gOj6oSizDGylBE0u/I4InvJjyEbpp6D+vUIozjZV34o8wH8PKZIOTEY++kUE6MdIjEd1ybezH5uj9Y8=
X-Received: by 10.107.59.77 with SMTP id i74mr26209975ioa.180.1517266500526;
 Mon, 29 Jan 2018 14:55:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.149.87 with HTTP; Mon, 29 Jan 2018 14:55:00 -0800 (PST)
In-Reply-To: <20180129172107.GA4185@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180129172107.GA4185@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 29 Jan 2018 23:55:00 +0100
Message-ID: <CAP8UFD0aKqT5YXJx9-MqeKCKhOVGxninRf8tv30=hKgVmHgmQQ@mail.gmail.com>
Subject: Re: Shawn Pearce has died
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 6:21 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 29, 2018 at 10:33:08AM +0100, Johannes Schindelin wrote:
>
>> I found these sad news in my timeline today:
>>
>> https://twitter.com/cdibona/status/957822400518696960
>
> Thanks for posting this.

Yeah, thanks.

> I know Shawn has not been all that active on this list in the past few
> years, so many may not know how active he has been behind the scenes:
>
>  - serving on the Git project leadership committee
>
>  - managing many of the contributors whose names you see here daily
>
>  - working on other Git ecosystem projects that aren't on this list
>    (like JGit!)

also:

-  organizing most of the first in real life meetings of Git
developers (https://git.wiki.kernel.org/index.php/GitTogether)
