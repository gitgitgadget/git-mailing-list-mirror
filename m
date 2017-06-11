Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F16D20282
	for <e@80x24.org>; Sun, 11 Jun 2017 18:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbdFKSSl (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Jun 2017 14:18:41 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36731 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdFKSSk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 14:18:40 -0400
Received: by mail-wr0-f180.google.com with SMTP id v111so75485753wrc.3
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUyNFxXxMPyPS2K/UB6C9JqFRnodflaTxIXszQzWVAs=;
        b=jQ7ZPG6Uew9YMkAVkao9gtJOBUlOax/fi7USn2AIFzHhbg8sIoj0wSK+efU5Ty3VQL
         qtnFxjsne6rYGsIIZZ2l+QlECRPy64P0xEx84Nw1jEr23KyEzEziOVambSLptXxZH25G
         fqTQuU8Vwy3E0qlwd+iK3ue//DRg/MJWB1/H7RDMxJ2o91DmRNhx+koe8YXFXN83u34w
         V4Xvj0E5XxW107oVv9nlleV0xSHrSQukZLKX/Vu+U3XQgKiLgl1AyPsH8pq4cJ9hDSyR
         rqbwB7W7UephUg/SKbyO+Zjh87dCXHATr0NnOGpuGgTGE5DSyylIO1OtXITVKOKQEejy
         e0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUyNFxXxMPyPS2K/UB6C9JqFRnodflaTxIXszQzWVAs=;
        b=AX685u9ag9MIfOO8sJ/M65LALb88zM+mV2Ep9djhjomCwP5lgpVpRUiOhyl/GPiupJ
         NYhUW0FQUdOs3XAwWUhRsmAvmhXhiXs6xmaoOciH9sByLPLKiTu6UZrqtQZXFa3OguK5
         BWr20qg9nMntEPqBsrUQUJg7BYYx2JXaul7xdNsiI2sChMh/CcInRzJ4jxdca3IfwF5Y
         1wOAKUwwjVPQSIve8L8ZlRfF2G5Kcgz4KQ1cf+E8aPDbxyCrHlB++IcHyC5TrUv9+kKv
         wBqAuNMafkrJar4YzVzMKOUT3ojgD5XQrKYJvm2n7fSIu/MDzZRKni217RK5kBU8WW6N
         mF9w==
X-Gm-Message-State: AKS2vOy+YBH4dzxwaF1LUInKFCNBbrAfQRz9Rqr+iuh1XWjzP6+hU3tv
        eSRtfYI7+tj9kO1nLMy/iA==
X-Received: by 10.223.133.4 with SMTP id 4mr5128989wrh.30.1497205118783;
        Sun, 11 Jun 2017 11:18:38 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-97-29.dynamic.sbb.rs. [24.135.97.29])
        by smtp.gmail.com with ESMTPSA id k35sm7278908wre.9.2017.06.11.11.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jun 2017 11:18:37 -0700 (PDT)
Subject: Re: Feature Request: Show status of the stash in git status command
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'liam Beguin' <liambeguin@gmail.com>,
        'Jeff King' <peff@peff.net>, 'Samuel Lijin' <sxlijin@gmail.com>
Cc:     'Houston Fortney' <houstonfortney@gmail.com>, git@vger.kernel.org
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
 <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
 <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
 <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
 <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
 <000b01d2e2dc$327c11c0$97743540$@nexbridge.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <11f1877a-6ec3-02c1-5b06-c1a07a389010@gmail.com>
Date:   Sun, 11 Jun 2017 20:18:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <000b01d2e2dc$327c11c0$97743540$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On 11/06/2017 19:57, Randall S. Becker wrote:
> Random thought: what if a stash id could be used in the same way as 
> any other ref, so diff stash[0] stash[1] would be possible - 
> although I can see this being problematic for a merge or rebase.

Not sure if I`m misunderstanding you, but at least `git diff 
stash@{0} stash@{1}` seems to already work as expected - I remember 
using it in the past, and I`ve tried it again now[1], and it still 
works.

[1] git version 2.13.0.windows.1

Regards,
Buga
