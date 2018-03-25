Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB211F404
	for <e@80x24.org>; Sun, 25 Mar 2018 14:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeCYOcl (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 10:32:41 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38542 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeCYOck (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 10:32:40 -0400
Received: by mail-wm0-f52.google.com with SMTP id l16so11018275wmh.3
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U+m0IW3/PeestNhFY+zFeFx6QkeIKLNvYEimu/H+vNQ=;
        b=EqRGyUtcSSfIHh0nUglI8K9FgNKTTwUA2/lmHckguPt+kUlZdtX35oLRYbRUhsNoDD
         2UMjxWAb5r/KgjCYHeTqfVBy/Bfp+Blk/iK1LyR924+70cUrlG1L+0iV1rzVCoaGmr0S
         eMTBd+Psyko8gqOw1376lPuz2M0wx5sy217+lm6SblEVxeV1JypCfG9+7fXW32mSezNp
         wEMt0sqozpga3Ztgd9a9p6MPeNrztBzxK5GhdJEaQZhZWWnPO97xfAXrFBe5KcAjGWCW
         Zphb+Rrj0GKfENtzPvMFec4zNlWt4042tG3MS6XjIk322b1YpNCrLbd1WREbJ4qXWot3
         v/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+m0IW3/PeestNhFY+zFeFx6QkeIKLNvYEimu/H+vNQ=;
        b=O/Yl3p9NVodBx3X6SxZ1RMQ/faSpFn7/UzTysiLgiFhufmjQ0tCRe1mmdwFz8RzUS2
         H7p5ssb16uCSohQ/8E0kjrWC1MtY8QkBwRqY9+tx3NyIb2/HP9LoBE/3fYEX/AGxp9bZ
         1JBFDGjnDSBw4q+srJNMWRDtmXYTCBpU89S8tLIbmj4cSn16GJUYKzNjdzhs91O9CbSy
         n3bGsKUA5zRWAi5B0nTvzYfujj0qC/R2i3NSKkWzH0QssGK+rN/Fnq/9tWobH0V47hTR
         5E6Kjpu/LuSWX17DXxVa/OrZnlqc2e/+/lKbuRHLBES+lD50B/KN+GU89GqpycNDGMp+
         Cm9w==
X-Gm-Message-State: AElRT7Fpowod9ITHWqIeITx2sEqfCkygprQ4zVzSUuon5vPbGScfjKVa
        W0XP+xjUh7muBBuGeTuSg5439toGx00=
X-Google-Smtp-Source: AG47ELtVMFHgeZ0j1ta1LPdPNmlgrKWA0c9hx9/Vzu4XnQ4m+iDz78LFPtOopDENqglZhJAsYThpuQ==
X-Received: by 10.28.71.77 with SMTP id u74mr13152419wma.149.1521988359427;
        Sun, 25 Mar 2018 07:32:39 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.10])
        by smtp.gmail.com with ESMTPSA id q21sm16573870wmd.40.2018.03.25.07.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 07:32:38 -0700 (PDT)
Subject: =?UTF-8?Q?Re:_[GSoC]_Convert_=e2=80=9cgit_stash=e2=80=9d_to_builtin?=
 =?UTF-8?Q?_proposal?=
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <1521576562.2188.10.camel@gmail.com>
 <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com>
 <1521760546.11809.20.camel@gmail.com>
 <nycvar.QRO.7.76.6.1803231754390.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <30151c63-9437-e1e7-dd89-585e35232455@gmail.com>
Date:   Sun, 25 Mar 2018 17:32:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803231754390.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.03.2018 19:06, Johannes Schindelin wrote:
>> [... proposal ...]
> 
> This is a pretty good proposal. The initial draft at converting `stash
> list` is a good start (it will need to be converted to avoid spawning an
> extra process, but that is something we can do incrementally, together).

Thank you for your kind words. It feels good to see other people 
appreciate my work. It is a strong incentive to keep going on. I made a 
few adjustments and I hope that the final version will be better.

Best regards,
Paul Ungureanu
