Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F4A1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 14:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJCUzR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 16:55:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42838 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 16:55:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so1594070pfn.9
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=RtocE0WvZm6GMoXdYtW2vRC3iB7LgB32QHY3Jl6Fgic=;
        b=WZSXFZLQTMkto/GdcDe422X2UqXvdcyMIt0CIBc0vBXsi2/kDDXOw2YvIxZevjEY5F
         qJcXduO2Cf1WcCHFw8ckht+mY5TgL5YLk61WfiuiOT2qN85Znc6JRCeUUDDzeu3gUiVj
         8Bh0841w0cqt+RwRgHMTcGi7obrYDsJCrWuqjtrjN9miuMPm8AHGryed/k4z8k8YL4t+
         zVgnUUke8kXCLopwH/EaVlXUMewFcBvEfqW5yhyYfQlsek/Ip6i/zvlER9s1RyjlGjZT
         HuOQbO4HvN0XrrDnuUxXsv1OajLpruPfY4HyNs60g9WOyetPLaI2r5a5kDVcR4BSF4kG
         7yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RtocE0WvZm6GMoXdYtW2vRC3iB7LgB32QHY3Jl6Fgic=;
        b=FOvcagVfey/Pg3iYaUToaXYJZ+0DPPOU+NbQGhWykuUXEV0KFYwKcWtt393EWi0Wzs
         tH3s79r/aoLCz4v3L6gJ/5QY8QBkbFnM6ihuzwvZkE2ZbMIKNcFVAStP+ZPSLoHnjQOR
         8Wh7EVhjfEiORCaVFbQSc35e4GmkjpEyl9WTlSqafQZBpJ9KIBbMxiNFxLl9JJSIpAV8
         zeFfVKJMe4tcGLpku+B1mx7/ymqZFd75nYfG/Ym6y7/sUqht5b5wUMClbCVbtseEoai6
         +WxAG1Z1qBFjIDe+5aFpWRWVL59QyKk1AfQOyimNrp0Vq9HhQPB6qRPjshKSMixX2dp0
         CZdw==
X-Gm-Message-State: ABuFfoh6SkD7V/bPXgAB3Hvcq3GoXie1ge4MEyz3gTfc6mKiPjIH4r37
        2c6FlL3raJD0jFwdTmM9xc6pBuq4
X-Google-Smtp-Source: ACcGV60Z1X43rBWSQ6yWISGZFaTqbJBkUC4qXp4yYp13+8T9venbn+Nc15dkAveY47YANllx3HwCxg==
X-Received: by 2002:a63:844:: with SMTP id 65-v6mr1528516pgi.144.1538575602927;
        Wed, 03 Oct 2018 07:06:42 -0700 (PDT)
Received: from [192.168.2.4] ([171.233.129.129])
        by smtp.gmail.com with ESMTPSA id x17-v6sm2429396pfn.59.2018.10.03.07.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:06:42 -0700 (PDT)
Subject: Fwd: Git credentials not working
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
To:     git-security@googlegroups.com, git@vger.kernel.org
From:   Dimitri Kopriwa <d.kopriwa@gmail.com>
X-Forwarded-Message-Id: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
Message-ID: <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
Date:   Wed, 3 Oct 2018 21:06:38 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git list,


I have tried to used git credentials within Gitlab-CI runners. I have 4 
instance of GitLab and discovered a weird bug with Git credentials when 
use within a CI process.

Please note before all that the time spend allowed me multiple time to 
check that my credentials are valid for the repository. And calling git 
fetch --tags with the full remote url that include the credentials 
always succeeded.

Tested with Git 2.11, 2.19

Git credentials in ~/.git-credentials and ~/.config/git/credentials are 
being removed by git upon reading.

This happen randomly accross my CI runner, and change that make them 
work on not related.


{ Error: Command failed: git fetch --tags 
https://git.example.com/example/some-project.git
18:25:52.554903 git.c:415               trace: built-in: git fetch 
--tags https://git.example.com/example/some-project.git
18:25:52.555234 run-command.c:637       trace: run_command: GIT_DIR=.git 
git-remote-https https://git.example.com/example/some-project.git 
https://git.example.com/example/some-project.git
18:25:52.692741 run-command.c:637       trace: run_command: 'git 
credential-store get'
18:25:52.697314 git.c:659               trace: exec: 
git-credential-store get
18:25:52.697372 run-command.c:637       trace: run_command: 
git-credential-store get
18:25:52.936024 run-command.c:637       trace: run_command: 'git 
credential-store erase'
18:25:52.940307 git.c:659               trace: exec: 
git-credential-store erase
18:25:52.940365 run-command.c:637       trace: run_command: 
git-credential-store erase
remote: HTTP Basic: Access denied
fatal: Authentication failed for 
'https://git.example.com/example/some-project.git/'


See the full question here: 
https://stackoverflow.com/questions/52614467/why-does-git-credential-store-call-git-credential-erase-and-make-my-credential-f


Can you please help me found why is git credential-store erase called ?


Best regards,

