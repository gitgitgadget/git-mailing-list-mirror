Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70421F42E
	for <e@80x24.org>; Sat,  5 May 2018 11:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeEEL0f (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 07:26:35 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34960 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEEL0d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 07:26:33 -0400
Received: by mail-wm0-f50.google.com with SMTP id o78-v6so8847959wmg.0
        for <git@vger.kernel.org>; Sat, 05 May 2018 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RCi+DkKZNglUiL4fQc2BweUWiibWkDsMzCtxSYeMlhA=;
        b=LdhAJnWqPSfVORGmcCuip+CuOfGl1veZxGlKY87tp3DdWg/+KD4xTz8LwyCdPfD7Y4
         lqfUoQnj6DZSbIIRYC+1sDUL6+O+H7mcklgJkcAZe7MikpbgGF7SBz9vDrmH9mUkDaRQ
         URF8RSFJ9LCuWhLOpiUlmpAHPwwpZS3lSrty5oeQygztfuS1f3WuHLm2ot3ABhUmzsoo
         M4g5gs5tVakPqAaYEiOlOoi2s6aui0J/tRJNy8SgTRnGwDTzi0Z2PMyuIf7oowA8mhrp
         SNxIkmnXc+UgNXzuyh1Ug9tQSuMx9qqfcHYs+VEzl0MSDTG26bg/2qBwh1Vwdd8ZnktJ
         Hnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=RCi+DkKZNglUiL4fQc2BweUWiibWkDsMzCtxSYeMlhA=;
        b=jYlZeEl/J+g+5S/sd2PyKNEdUB9nnR0zoRU1Bz4iDn3QJwdMGZv1Nb4HM1HJwvCyMJ
         clByQ2oJKZitOfJdK/3lICKlMCBlyUT8Q8dxAhkyeuknYr2hq8fhQ9iB3FIVqwXsNxue
         QLhOurWBda7YOouPc16VEIvNQzsN5JML4811JVRQCMRV1xIV5Holk9mLlBOKk3MGINwD
         4URC3N9S9GJOJF9XeALeZ0GEpmNHMQtbeEzE/Pw1tAZTjtOmOxN4VRqWtcTFRetLwfiG
         oRjnFB5MryhJ5P2l5ZBrq9adiJxzhgXnL3tMiWOgYpSqdpmmCcYQexZKouDZStravImd
         P9uA==
X-Gm-Message-State: ALQs6tCKlfD4asb1XVVhhOnxDCfrO8hFh+YPGmosqtNXxaw+nwAnR6k1
        GOsWc8Y0T3vWw/d3TYq66Ac=
X-Google-Smtp-Source: AB8JxZqRoNn4xvEngKLdHmbn917omVkT/9Uz0qN2tcOM/1YUuoF5/rXFQ+/ZzoF/dPtkIPttim2Iiw==
X-Received: by 10.28.92.213 with SMTP id q204mr8290189wmb.158.1525519592376;
        Sat, 05 May 2018 04:26:32 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-8-71.w86-222.abo.wanadoo.fr. [86.222.151.71])
        by smtp.gmail.com with ESMTPSA id s5-v6sm3560360wra.48.2018.05.05.04.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 May 2018 04:26:31 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] Yet another blog series about the GSoC
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <917621a4-b46a-95aa-dccc-905c0cd32b1d@gmail.com>
Date:   Sat, 5 May 2018 13:26:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

as my fellow students, I started a blog series about my GSoC project[1].
First, I wanted to post them directly on the mailing list, but a blog
allows me to edit the content easily if needed.

Any feedback is welcome!

[1] https://blog.pa1ch.fr/posts/2018/05/05/en/gsoc2018-week-1.html

Cheers,
Alban Gruin
