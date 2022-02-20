Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CFC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 20:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiBTUaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:30:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiBTUaR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 15:30:17 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601CF522D4
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:29:56 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a19so26846004qvm.4
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5ohwA6Jlbi+oAECmvyzVr+WxOAcwJvv473GjWTyxUR4=;
        b=VvkYqx80iW/mTjXJecIo/FpMcBDgNCmqt7pstKIk9BdgfugT/53VFTuBHOfKvp1V+f
         RetTaWQcOqSBP6SfvIfwDMhSDKZJ7uII8cwYwG80vIISRDA+XhKr3zxs5dw+EHKUul3d
         dnXWJCI7e0RCyRchdYAVhCll0OHeVBEvVrMcTfDG0eJCWqCV1pOONU84xgHy4Df+6cAZ
         LbqrI8h9HPD0wKJbV3fDXNyA3UqHgkF9CS352n9dKENx9TJh6uuqDm96BdT9fDjw88Q3
         QjT8nH770LyHlWPSPXm4JKqHSpi1dx7lMXcq9eeXPUBIBezC8EeHsCKstfInIlCJo1SN
         s1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ohwA6Jlbi+oAECmvyzVr+WxOAcwJvv473GjWTyxUR4=;
        b=7V5igjMHUbyiHtUMhSTGEsxRr7qkomufE9IOepXLozv8RW+mDmyAn7IEM0z85Bc2Ow
         czcBtiYTOps3pmM62j7EA16umYzem2MaSMIYcA5K3+KdU3iAK3tyOx5kfDs/cjb2+267
         3OLx/1FSq+xbD0grZUqSkMEcWMqveTt/vBtRKzRioetqyMDqG/jhSh36ZHPLuPAM9BWR
         pi9fQU12e2fbOBGcMNw57My7yiwLfZ5lgivK5Y5S8ad6P0zUW1lu6RNxLSNF9SDT+jiB
         4hbuAtlY5wmPM8jTSdCqUNlB3aIMwbgjOarJ1+hEyPvIpDPW17liEwrQ+wdFr55PMmQq
         EE9w==
X-Gm-Message-State: AOAM532EviunLeM8Syk5FEUisHujOKItQxdnnqnZPhX4RrM+S5DVSA01
        NxqqwhnzB+RYRXjZqCptoHvL
X-Google-Smtp-Source: ABdhPJzMBcIqEVOPV9pzzog6Svt+1nVvvBFQc21px2XJxb+mq0pmjbyL/7pPUAbd2EqwRwGhccpRaw==
X-Received: by 2002:ad4:4b63:0:b0:42d:a3cf:1b55 with SMTP id m3-20020ad44b63000000b0042da3cf1b55mr13042807qvx.130.1645388995569;
        Sun, 20 Feb 2022 12:29:55 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e12sm3561626qtj.41.2022.02.20.12.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:29:55 -0800 (PST)
Message-ID: <0768287f-6dee-2c9a-dd71-8868fa208028@github.com>
Date:   Sun, 20 Feb 2022 15:29:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/11] worktree: combine two translatable messages
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <avila.jn@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <a113ed9a8449b57e2a88a24244f3e45b24a01862.1645379667.git.gitgitgadget@gmail.com>
 <xmqqley5uw40.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqley5uw40.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2022 3:22 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> [jc: bogus CC addressses stripped and retyped; did something change
> at GGG recently?]

This is actually my fault. I copy/pasted from the previous PR, but
that led to markdown-formatted links of some of the email addresses,
confusing GGG.

I fixed the description so a reroll shouldn't have this problem.

Thanks,
-Stolee
