Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F10C433FE
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 09:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiAQJAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 04:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiAQJAh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 04:00:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A41C061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 01:00:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o14-20020a17090ac08e00b001b4b55792aeso344274pjs.3
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 01:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yuoMGJj1zVSytSnwsuTHy1R9R2f7O2KrHf/77dhRvDI=;
        b=m0XNtdaiYGm9JfElyTCPNteYUuWh6bGJPdnszSHjWeSMfDf/EeOjak3OLeq7p6CHOA
         IBEVGuBnRAMN7yp658uIUmiTqdNnSVy9yuFe/1k1veXs2pNfvnyIJLoTY5Sa5LcOV0sY
         gRSxT7Xq051K/I6k0HRPNcaNCI6CzvBRDxFd2FWywu9Q4Zz4sPLG2pUjmIiLfB2pFYpw
         xW0SUowCT91H/gUqA5kNQDPPluUVZeGHva2MIdgDrNzflIa99Txoxtfz2UFnANZbBAfQ
         SjMumhviGa3xEG0cbh2YLRL8YQlmFebrg0+7tNOLrf3gxeDMl24A1Xi9y8Iy02Jz8X+D
         gzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yuoMGJj1zVSytSnwsuTHy1R9R2f7O2KrHf/77dhRvDI=;
        b=ZO6AGuYnvyC5QMxSzsTAuSYRap9jIwBdlqfO2Aa8VxAtkA6dKotdPQhdbNnDuNfp+/
         lcTfeCyh6cqHZXZXMf33tmAOZ78EbhaZWqycayDuEqZg1lGaJDUyxxKm3syqDeXS4KiD
         cMRn6t44H8+KCz7cyEWOA/JYv/RvBIpSySWPKF1zEW64N/5tqtpPIyVjdoFOPqMuUxoH
         8Dac+tfVF6ia7PQ3MaaTFLurq8V2aS5/EJSh2C6BxmPUiOnb6PriXW8cbMCL0q4TXNc3
         oy2nAROYxgD1Sjv7WyDCX2XE1g4Z4NXq/cWqTA9Abti4YaoDRJEaQTTHTEV8abM/EZHD
         0pbQ==
X-Gm-Message-State: AOAM530UFuU9r7VWIL8/amCeCu4EXemVOp6wraIResRo3+8yonBkR14Q
        Xx+KW9+Kv97WKhAKkGRmCe0=
X-Google-Smtp-Source: ABdhPJy1DYBk5vAeYFHy+jrnTNSVRXn5UqvBZGs0NIHwZDOOaAfatyi+l0pFCt6FCBGNmlS8me4Azg==
X-Received: by 2002:a17:90b:3884:: with SMTP id mu4mr16771282pjb.82.1642410036463;
        Mon, 17 Jan 2022 01:00:36 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-32.three.co.id. [116.206.28.32])
        by smtp.gmail.com with ESMTPSA id c82sm13100013pfc.1.2022.01.17.01.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 01:00:36 -0800 (PST)
Message-ID: <6271ff4b-1821-0086-167c-b273ab252eb9@gmail.com>
Date:   Mon, 17 Jan 2022 16:00:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] README.md: add CodingGuidelines and a link for
 Translators
Content-Language: en-US
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
 <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/01/22 23.11, Philip Oakley via GitGitGadget wrote:
> +Those wishing to help with error message translation (localization L10)
> +should see [po/README.md][] (a `po` file is a Portable Object file that
> +holds the translations).
> +

I mean not just error messages are in po/*.po, but also usage and informational
strings. We can say "Those wishing to help translating message strings
(localization or l10n)...".

-- 
An old man doll... just what I always wanted! - Clara
