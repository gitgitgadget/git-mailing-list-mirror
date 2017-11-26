Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6869F20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 12:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdKZMP0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 07:15:26 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:41653 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdKZMPT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 07:15:19 -0500
Received: by mail-wm0-f41.google.com with SMTP id b189so29188184wmd.0
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 04:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AoYGhMnbdgEau6OrS3LlZyfa3XtNZePovBoBTgyb2O4=;
        b=jLPXm4UEjf51CO262nYBfCnlGrnnwNTlN0e8A8g+cg30IPPVfA/zehXx4Dj5HWLpTV
         PfDZV0Dg9yO+YFVFYx2ycbE7A7uEZEo9pZ5kEL4DiZ91XYHDbUuPkItszUXi+bw4Enxc
         rFwOaXyopso8N50f3m7ECnFMOSI/vp2mHea8d4YSxvb2YARHN4yWx36k9r3Hds9r/Nmq
         F0EU4BWsy3trqc/6nRUACM+uovMc510OjPYfOweT2sTtRre6e9g47Z0Kmr2DyGYChwXA
         DhlsLJpedtNqO5rdkkZpq82uM74i0lltZqUbATdQoVHak60dH25tJOg2SYW/iMJcrhwH
         qHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AoYGhMnbdgEau6OrS3LlZyfa3XtNZePovBoBTgyb2O4=;
        b=BuVgE/PFG6ibGF0hovXppBmt6kZX5VXFM6d/GTEL6fMtD1tpn0MWZvtbMxNvAkyIFN
         HObC/9jzF/7exejovwUul+iNtx+nUXHVeES2RhGHBu+RaZtOAgIDFhB0iivg+zxYN47S
         oQpZQLYqCA03kizPO/NTTd/KX23ZKG7fD41ZtyXwvvaaB6ti8tlTgCrzQYx5EBudgV8E
         IFvjdqmnrXOPUlbm057cBj69+Mc/Bs+QD2C4/h5PxoWrTygkPO2/iZg+hOxL1YCIcFjg
         G4YE5zBjK1qXTRKZxg0fwx0eapjwn/FKU/iu6PWugFQt/r14w4+q2u72sUZV+2lbSLMv
         PANQ==
X-Gm-Message-State: AJaThX7dBJQr180DXbJqU6KxnFIprlOSxR1jtIyT2Lz6T0sd3SFHNiTO
        t+h+H1TLA8cbw6EuR/HcnLI=
X-Google-Smtp-Source: AGs4zMZQnWIOs27ePiYg521PvFn/yKHlnKUneBy9jZ9vgIWiQKcGyNagoIakCHfeGVAa7FQf8+fh8Q==
X-Received: by 10.28.54.204 with SMTP id y73mr2991316wmh.15.1511698518186;
        Sun, 26 Nov 2017 04:15:18 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id h194sm30811414wma.3.2017.11.26.04.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 04:15:17 -0800 (PST)
Subject: Re: Problem installing Git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phil Martel <pomartel@comcast.net>, git@vger.kernel.org,
        git-for-windows@googlegroups.com
References: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
 <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
 <alpine.DEB.2.21.1.1711252312270.6482@virtualbox>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <7beb6393-5b64-2f61-48be-a3f5041ea4c3@gmail.com>
Date:   Sun, 26 Nov 2017 13:15:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711252312270.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 25/11/2017 23:16, Johannes Schindelin wrote:
> 
> > [ +Cc:  Git for Windows mailing list ]
> 
> I have no idea why it claimed that that group does not exist, the
> email address looks correct to me.

I suspected the culprit was me not being a member of the group, where 
the group requires it for (initial?) posting (but you already noticed 
that other e-mail about it there[2], this is more a follow-up for 
anyone here, still wondering).

> > p.s. Note the existence of "Git for Windows"[1] specific mailing
> > list as well, where this issue might belong better.
> >
> > [1] git-for-windows@googlegroups.com
> 
> I think a much better place is the Git for Windows bug tracker (if
> you ever wonder where the bug tracker is, or the home page, or the
> repository or the FAQ, there are links in the upper left of the
> release notes -- which probably nobody reads, even if I really try to
> make them worth the while -- and which you can find in C:\Program
> Files\Git\ReleaseNotes.html if you closed the tab after installing
> Git for Windows).
> 
> And indeed, there is already a ticket for this issue:
> https://github.com/git-for-windows/git/issues/1074

I myself am aware of the tracker, just that I didn`t really 
anticipate this as a Git for Windows bug, seeing various mentions 
around the net pointing to Inno Setup (being in use here as well).

That said, I see the logic in thinking the other way around, too, and 
possibly addressing it somehow inside Git for Windows, in spite of 
what happens on Inno Setup side. At least working around it a bit 
better, if possible.

I can remember to keep an eye on the tracker more often, just in 
case, as that would have clearly helped here. Thanks for the heads-up.

Regards, Buga

[2] https://groups.google.com/d/msg/git-for-windows/0hn7Th4uGZk/oJTdmXa5AgAJ
