Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702EA207F8
	for <e@80x24.org>; Sat,  6 May 2017 17:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbdEFRSG (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 13:18:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33840 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdEFRSE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 13:18:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so7019906wmb.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aOIEo7UQVKVxvWilLDEyh56sOxF9gtJEi+x10ADWUKs=;
        b=I6DFQJ1RdKUVlqro/WchMMQLYm/sxYYDnwmtUsGCHL051IhciWNGWNuUuHhqH2aR0Q
         L0iRRMrhaHckW+Mvy2MmW6kIrf5h5oPHpYlVSI547ItecS3P5466Iv7TlqIbyNNmneBG
         RAYTcwzOVvOpMVphZT12lzo6PLbaxFA9nc8h4pTiP0RjIsGCL9TOcW1gKN+9VIczarDJ
         8y49gw9tembuUv6hx7vqbNt11KbKyJL6fP+EoqBPn1u4KZMTrxS6W6JcUU7BvbFtqByc
         fKRL2DgbBKgRMnYv80UjJyer745kmB7qsewT9XagtFv/VSL7H9CVhf2ELbRl92xVDrQG
         eR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOIEo7UQVKVxvWilLDEyh56sOxF9gtJEi+x10ADWUKs=;
        b=cPI7cvMiiuKDGxAMamPv/KWAe9m3K10qb8HEfdmbnz60EtKVNlUkGYXDC30hz53kst
         +Ym0QbaCfzkWCMLrReGAgFrlo29FhdFvS1SkOJdoVBMhRfGLk1fUNS4MwYr32EHBNP+Z
         sz0OGEp+ex6bogHCdjx3XrDcO4XdN8C4+/ZRL18BK6UW3YMyk4sCmsP7rUFlluYGiUKZ
         T3uzYlkzUZrZ4dQKQVmLyzP2TfISIg8NhLxzQNGmApQDzVcHNpf5EYSbhyvT8zvz712h
         1rKot162jqOff/pe3t17tP41jvbY34HnFhS4caj/zdmkxtOPUhWsX6zufczgnxkvU7X9
         Sb7Q==
X-Gm-Message-State: AN3rC/4lk7AzOg32p2ZNKVjA6XsbuRJVCd84dXnRL6eF3E7ANnH5K7sN
        MX0Yj+kCQ+uJ3w==
X-Received: by 10.80.186.199 with SMTP id x65mr38750448ede.46.1494091083350;
        Sat, 06 May 2017 10:18:03 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id d38sm2729346edb.26.2017.05.06.10.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 May 2017 10:18:02 -0700 (PDT)
Message-ID: <1494091082.24179.9.camel@kaarsemaker.net>
Subject: Re: Bug report: Git Stash; spelling mistake of stash followed by a
 yes prints character 'y' infinite times.
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Rashmi Pai <rashmipai36@gmail.com>, git@vger.kernel.org
Date:   Sat, 06 May 2017 19:18:02 +0200
In-Reply-To: <CAOqCAXSOZCG8mijV+yATtmC1PFGYiOSqtraSdbhbP2rRHBO_Qg@mail.gmail.com>
References: <CAOqCAXSOZCG8mijV+yATtmC1PFGYiOSqtraSdbhbP2rRHBO_Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-05-03 at 14:51 +0530, Rashmi Pai wrote:

> I am a corporate user of git. I noticed that when you switch between
> the branches and do a git stash ( I miss spelled it as git stahs). Git
> asked if i meant git stash. and i entered yes. and git printed the
> character y infinite times.

Hi Rashmi,

While git asks the question 'Did you mean stash', that question is
merely rhetorical, it does not expect an answer but exits. So what
you're seeing is the output of the shell builting 'yes', not output
from git.

D.
