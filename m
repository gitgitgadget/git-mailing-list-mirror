Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30A4202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 12:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbdKAMhk (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 08:37:40 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:49819 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754336AbdKAMhj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 08:37:39 -0400
Received: by mail-vk0-f49.google.com with SMTP id t184so1300812vka.6
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7NiiZ/5fpqcekfxk29AbxcwHxrPGgSl9RpKncMJN3ag=;
        b=hueK6Je8pNTI+GiyF91LhmUXffp9nlG8X2Gtb3t60uCLJL8/am5ZaGzBX3a0sPwygP
         jSWCXLKXnhzej5P8aVKzuEhYymgCgBw0Y09snxVPsg33sZ27irSPHSd93LUNS0d0dGg7
         lzTtEURqckfnHW/xO6l6Z2gABWOnpeesnT7A9nRuE3QtV1jDGlePz2PWqJb3XcUhPaMX
         ug+PU6lasDOk41NLdPLlCmaKRZ5Q0g34QcSzBihl+wLbJUT02IyV6rpUHdwwrLSzOKTG
         FmPiq/AvTBr2RURJgAbJZTphCBxBsaB7FWet/vLI80LYJGxUpxpXV9UgaFFKet77IlHc
         JIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7NiiZ/5fpqcekfxk29AbxcwHxrPGgSl9RpKncMJN3ag=;
        b=OZgbWQdZu+WS41diTMDiAdeyGnPuGf6PtmE0X77LOjWWrSeLsKnXpDnIry4jzUXE0r
         +R/UWiSXDcG0fOv4hE0b08yGj01WNU0tiR1PkFYLgxahGRzNh4FFCnaSyI5EA5mYuVo+
         bAZQS3V4lkK0LM1GwMA8O0hospbuYUu9rLPcSZL879Ydxw+chi+428Td6uZablEamZIi
         6Y3QzAZcDDcfmyH6a6muJMzCH5Hvdvwgnf5SlBu4mNsro5L9Bqat5o15E9XVR7Jf1+c+
         p9s0vQaWSnEL1AHzifjv827Va1r2Aai6DvYhhYNP8NRjETCNI8OhJYuNdbE7fZfVx/ic
         zAuA==
X-Gm-Message-State: AJaThX6IWV8x+SKPuhBBZu8vseupJvPExvpxcmwHhDlFmk9VvzT4GdL/
        220BmGRFZBhrg1bJtQ32rWe61JKlXmLQVlRq6Ks=
X-Google-Smtp-Source: ABhQp+SR1ODqw7dfOv918cjUN1a0Tw0tl7ARKRlnUI/OQYs5Ry0W1SWRAMANJ5mIkNbPLQhIKw+3KJDTbNX41v1AUpI=
X-Received: by 10.31.151.81 with SMTP id z78mr3992499vkd.98.1509539858543;
 Wed, 01 Nov 2017 05:37:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.124.141 with HTTP; Wed, 1 Nov 2017 05:37:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 1 Nov 2017 21:37:18 +0900
X-Google-Sender-Auth: zIHfkh7L6jGzem7LDR5aHsCpoYs
Message-ID: <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order of
 the commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 9:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>         ...
>         (
>                 for x in four three
>                 do
>                         git rm $x &&
>                         git commit -m "remote $x" ||
>                         exit
>                 done
>         ) &&
>         test 0 -eq $? &&
>         ...
>
> Ugly? Yes. Correct? Also yes.

I think returning non-zero with "return" is how other tests avoid an
extra level of subshell.
Ugly? Yes. Correct? Questionable but it seems to work for those who
wrote them ;-)
