Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF8C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 22:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiD0WFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiD0WFv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 18:05:51 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80B78FDE
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:02:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id q13so2023421qvk.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fe6xpTKggt8gaKOv9dOe+lKL02Xax+fqJ5lhJq7jNsQ=;
        b=ZME9lMZ/wHB4IkahlK2skjXpfh1UQGUnD1tpkdaR40/THGM8nh5IIRurUmMbEYhCxh
         64yCnv/Y4AeaSxMsUMLdRrZEOZCWhgB+Y2VB1XhaPt3pUNvLQ48WOxGwTNau4/eKOSCP
         jVT+FLTxe458EvcCGJTXgd5BXO3Zl7Uf4mWJzwwKs3RlBnbmD6dMhjJ5G37q9FGnJZtd
         Cl7kUrY7emEpgtjpRijPiqit2RmfJrhPxQIiakYYbLgXOTupk1A7nyTJ2lmYWIex5QEm
         DEQw6UKTO+bHhWbwtTmgGbXtpfT+nz8A57Ciej1Q3yejm+OLf0WXQZJOptsNEINXauq5
         2jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fe6xpTKggt8gaKOv9dOe+lKL02Xax+fqJ5lhJq7jNsQ=;
        b=khDHKISlnIXh82cMGJp2MmxOws8CfCYw1rnrcisdPJ4vgs1qMf9kLlAOYCMrwhfymk
         LRqHTLGlpw6XAn++q5o2N3uTZNUw6vhMBTte4CBZd+i9KIdb2wE6cOFNVKL/3tPG0FSm
         NkiMVOF5OW94q5/PHpod4JSiV/MkpBHTfxfgdVywS9QVpWmWQpiKVuwKjTrzsHpDQnfw
         f3ISAGGP/+Hn8SkILbnVp4ydMAMCslVOuk1d6BSswO3Tx0DG2FFk9sb8LbkIIV71YF7g
         xnplxdsQ8FCD7mbjxJnjm7hQcD+TIj0fOpwoZiNdGo0wvGNoCp0RKiBDlDySyXT1TITb
         rKKw==
X-Gm-Message-State: AOAM5307feQHUIOo82S0X81wIuWetMglhEPdvDSKThSvD4iKQHlIkCXr
        9W+w8tUwpLJ/5+9lXjz7Zho=
X-Google-Smtp-Source: ABdhPJyzTaupbJXQHKUel2aj+z628nQ5HflYhXgK92zsjlkjrjk3K4TrVF9XI4T1JwoK9EXDqM0aPQ==
X-Received: by 2002:ad4:5ae8:0:b0:456:4ae4:d990 with SMTP id c8-20020ad45ae8000000b004564ae4d990mr6315818qvh.33.1651096959053;
        Wed, 27 Apr 2022 15:02:39 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id a190-20020a3766c7000000b0069e770524adsm8777144qkc.114.2022.04.27.15.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 15:02:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] MyFirstContribution: move cover letter description to
 a separate file
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <7e84d5b286de9dddf28ef1c8f38c7d7c28e266f0.1651086288.git.gitgitgadget@gmail.com>
 <CAPig+cRgD8LjQxnoJQre+sb2NcO2yHz19fPfAQsdYdSYUgyjLA@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <8c22e4bd-e176-4ff9-a286-05d6ba17a1b1@gmail.com>
Date:   Wed, 27 Apr 2022 18:02:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRgD8LjQxnoJQre+sb2NcO2yHz19fPfAQsdYdSYUgyjLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Le 2022-04-27 à 17:15, Eric Sunshine a écrit :
> On Wed, Apr 27, 2022 at 3:18 PM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> In a subsequent commit we want to reuse the explanation of the purpose of
>> The cover letter form the "Sending Patches with git send-email" section
> 
> s/The/the
> s/form/from/
> 

Indeed, will fix. Thanks,
Philippe.
