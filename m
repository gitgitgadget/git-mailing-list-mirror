Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7ADF2021E
	for <e@80x24.org>; Mon, 31 Oct 2016 16:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756931AbcJaQJz (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 12:09:55 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36385 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756823AbcJaQJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 12:09:54 -0400
Received: by mail-wm0-f41.google.com with SMTP id p190so156468783wmp.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=9z4fAaKDvMJR9B3XXbxvgnzgSLp10+/jIPwNiJRujaI=;
        b=LhVSSRXHIylrfxUEIBKS1/Ivw6gRUN8A6IVvQgeK4u/+r5hkUQDtYhuNVyH919K8zp
         TGTZeOwibULI1/G0Cu7p1B1lStZCEDYB/Kyz3sVUSeg9lPBgO90I7iuwaNEwGlFrECwP
         QLjUtc3A6d105GXFC0NXgkZ9oUrKeIwFeG7Pr3vM/oP0OsLMu0DRxWQPD2nQGtESCTxH
         JSJCt9vd+SV5BnFwn88eyIWdFm/u0ZDWHb0PGR7mshYVPNvJpOb/XwNAQCrnn4I38KQW
         5rmvTXapIRbPSYAZB4GeKMWHNZc53FNVQhq98hTcmdVsnE47iWxvJaXlzZolTpyLzMmw
         dnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9z4fAaKDvMJR9B3XXbxvgnzgSLp10+/jIPwNiJRujaI=;
        b=QYjViAi0cmd7zEcclzeEqiDSsHL1O8j1hX3QNeSxUzR20rs/KirVMkCbc+YtyZZ/Hr
         0WixUJUaSwHKUT6hTp4lI8F1+rOENAo8HMM1SztZKy+OvHZzXu7VT1HX6D4CrY5p8pT+
         Ide1tDPd/T4AkElsN0Ucf5uscrbf72kQzBntTkGMxTwet1xSVpT6Na2LvsaRMyKjgVFY
         dYaQfUZxYafedLNL/3OuZtgkwJxAhW43rkc8inhWqHdWD7avKtMJSrCXRX+1foz4sPng
         II+SRyftAx7d/Uf1X0AsXZq+HMA2VFjGYOSgN2RrjqgsxoHuxP9O5Td84SGv6XYY6J6Z
         tEWg==
X-Gm-Message-State: ABUngvesgGhcO9YCiuLXgL/h6mZRRCSjrPYSDec0gU5EkwG6tOugE6PQ4/1lKX4HXHdrBQ==
X-Received: by 10.28.107.68 with SMTP id g65mr10832625wmc.91.1477930192662;
        Mon, 31 Oct 2016 09:09:52 -0700 (PDT)
Received: from [192.168.1.26] (actf148.neoplus.adsl.tpnet.pl. [83.11.59.148])
        by smtp.googlemail.com with ESMTPSA id za1sm30758546wjb.8.2016.10.31.09.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2016 09:09:51 -0700 (PDT)
Subject: Re: Reporting Bug in Git Version Control System
To:     Pranit Bauva <pranit.bauva@gmail.com>,
        Yash Jain <yashjain.lnm@gmail.com>
References: <CAN8fUZe4iWJCZYqBBDbNyPq1Dz7f4xvTNRVEZgg5AYN2NrKCbg@mail.gmail.com>
 <CAFZEwPNB1PX_NOaYzKr+rUKvbC9s5A1G58v5aS=sGdzPVsv4ww@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <fb358e96-02e3-e162-94a6-7cf20ee3f7cf@gmail.com>
Date:   Mon, 31 Oct 2016 17:09:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPNB1PX_NOaYzKr+rUKvbC9s5A1G58v5aS=sGdzPVsv4ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.10.2016 o 10:51, Pranit Bauva pisze:
> Hey Yash,
> 
> Junio has explained the problem very well. Since you seem to be a
> beginner (guessing purely by your email) I will tell you how to fix
> it.
> 
> Remember when you would have first installed git, you would have done
> something like `git config --global user.name <what ever name>` and
> `git config --global user.email <what ever email>`, it gets
> permanently stored in the git configuration file (~/.gitconfig). Now
> all the commits in git are made with this name and email. If you want
> to change this, again run the above commands with your new name and
> email. After that commits will be done with a different name and
> email. Hope this helps! :)

First, per user Git configuration doesn't necessarily go into ~/.gitconfig;
it could be in ~/.config/git/config

Second, you can configure user.email and user.name with `git config` or
`git config --local`.  The information would go into .git/config for
specific repository.  This might be a better solution if you want
different settings for different repositories.

-- 
Jakub Narębski

