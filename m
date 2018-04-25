Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205921F424
	for <e@80x24.org>; Wed, 25 Apr 2018 15:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbeDYPBT (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 11:01:19 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36717 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbeDYPBP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 11:01:15 -0400
Received: by mail-wm0-f54.google.com with SMTP id n10so7377718wmc.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CdbI1Q+/I1lSWh17Ud4H1xxI6c0+O6iQOO6tr1Wpa7o=;
        b=NJ7lvblPi+Z6AQqPWIJor5aYhicfYEpgkCJlhrUBeP6PKdElcXD7M0O0jOYemVhtQb
         jOjf5s/097RrnNd/PmZ2hAuUyjBhaZPo9Tzmt/heh3tBCC7PsMK8ygpyElWYmxvNLxm0
         y0KDu7vdky0bvc9/+YF9MBLCvVhBsiRSux9/NGKeeC6XaClNlKAIBHVMpPXpxYa0VHOf
         7qh77Tud3Ac8DJDXdeQtCj8dvsHt52UmT7q6EMu/yg0ycM/cZEuR3E68eUGvhJeKQknL
         eZoDPGO76s6WfocxPE+24/FY34nsbWlTqTOVeEYWnKEmyMIIPici63LzRkrfiBfF8Aoc
         acUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CdbI1Q+/I1lSWh17Ud4H1xxI6c0+O6iQOO6tr1Wpa7o=;
        b=qJUhiM74TWeN2rVbeWkCwJSL2mExTurUpb6b6FyAQKXMMPi5yJlNMiJFy8L9dH9MOd
         kjHaaWOwmOBNRraK19jitG4dncgnLEkr/qfdeg6/FMiejqz3rI4pU/8+v3c2cYVOEEi6
         QMg0Q+F9AmTPlgjcLPHQQlT8fLaE3OskYdKCy4b6HRG1EUzcFgysUqA/bOUWI1ULgZOe
         +n4GphzvHBVTTigtjnq0IEibXx+aOn/HB+Fiduxi9RxDxUgo2iCKHtTeK9kK9UoXjs7i
         jYeMwJJJqr5XKvCyFwqAMSaIoxC8eNV1t9TxOXiqooBsKUX6XbvHZG2mmtKUfFqvnWQu
         CsZA==
X-Gm-Message-State: ALQs6tB/G4ceG8H2xGUBVPipQQDkd0W/3M4jDqj2Im3ECTPZlCgdi8A1
        ObFgAHBTthLhriDLwsU+doOALXUaj5c=
X-Google-Smtp-Source: AIpwx48lsGMGUM1TeCxbRtsZGIsXNMtSxR+l2LdWur6GrZ/Jf21mzlI17RkYrGt45Wi8r1eGPtZdwg==
X-Received: by 10.28.191.206 with SMTP id o75mr14283580wmi.122.1524668473910;
        Wed, 25 Apr 2018 08:01:13 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-42-160.w86-221.abo.wanadoo.fr. [86.221.49.160])
        by smtp.gmail.com with ESMTPSA id x73sm2624560wmf.21.2018.04.25.08.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 08:01:12 -0700 (PDT)
Subject: Re: GSoC students and mentors in 2018
To:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
References: <CAGZ79kbzFGn2-xcrWFi1+ZUgSGGHdUPEQOexu8Lan796LCsvBg@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1064b009-26a4-8b7e-190c-36af9ea7f2c5@gmail.com>
Date:   Wed, 25 Apr 2018 17:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbzFGn2-xcrWFi1+ZUgSGGHdUPEQOexu8Lan796LCsvBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 23/04/2018 à 23:01, Stefan Beller a écrit :
> Hi Git community,
> 
> This year we'll participate once again in Google Summer or Code!
> We'll have 3 students and 3 mentors, which is more than in recent years.
> 
> Paul-Sebastian Ungureanu mentored by DScho, wants to convert git-stash
> into a builtin.
> 
> Alban Gruin and Pratik Karki want to convert parts of git-rebase into
> a builtin. Both are mentored by Christian and myself.
> 
> The slots were just announced today, please join me in welcoming them
> to the Git mailing list! (Although you may remember them from the
> micro projects[1,2,3])
> 
> [1] https://public-inbox.org/git/20180319155929.7000-1-ungureanupaulsebastian@gmail.com/
> [2] https://public-inbox.org/git/20180301111907.17607-1-alban.gruin@gmail.com/
> [3] https://public-inbox.org/git/20180327173137.5970-1-predatoramigo@gmail.com/
> 
> Thanks,
> Stefan
> 

Hi,

it’s an honor for me too! I am excited to work with the git commity.

Cheers,
Alban
