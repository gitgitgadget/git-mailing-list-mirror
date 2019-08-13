Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650181F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 04:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfHMEGc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 00:06:32 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43956 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMEGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 00:06:32 -0400
Received: by mail-ot1-f49.google.com with SMTP id e12so23221460otp.10
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 21:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbuj/5X0YAr/yhy3NwdUxkvIxPIP0GBkGxrIR77FkzI=;
        b=KS3gp2jBK80PuE2W3KgKh/Rz7l/aWOJ+y8bHRrAHI+Kc+P7u4R3waNPMXh/GgHeF1Q
         q12P/NnWn6Fkn7e6jdqT12NRqrxTMWt3rpwha3ROhhkfdTrzvJTI99wgH8fNtUmzaohl
         4vQGceg24gI8r+l9yDTmsY8sXdGVPs4KQ7odhljYZ/REjEzsoQVTzDI4fm0Eg7safBCM
         gLjhRuBv1zXq3cTPTfdLmTm9XtmkPYPEx50FGvz+7QpRHFq9VD7ejGxhw7kHYIXic4Lx
         egcyX2ovSvMlpWuXAUMNriKc/4ULz2suxj+UHSNE4t/gbxAxpNf/OkodLw5lWX2+xhTK
         PFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbuj/5X0YAr/yhy3NwdUxkvIxPIP0GBkGxrIR77FkzI=;
        b=RIRor+7qKIml7V/nPJKMHU4GZQbIjnE8/v1eJnp90IZHyFLWrcE+XvAWSMh56FiD8P
         WSvmxDncFk0Mn0IEpEZcAe+x1Iz4YGTQwe/LiAOX/RH8EmCfvcxIVrjWKAR3iP2cIALb
         3CqksalKc7q2Yi02brhw5SziRRFfOkmJLyXcW4E8+ViG23y51cte6qnaRCA1c8OJ9Wzt
         8WKpsXvwwRJVtsH25v8b+TQd69BPEg2chGhfRWMttiN7TMr8Cc46xyLo4nNB7GAuS5E+
         3v2C+8qCbclMDudC3C2h7BdiPPRoTNit/MThYgblbsShhfz0gspXM4RZj2GmX6tLGHTW
         Ocuw==
X-Gm-Message-State: APjAAAV6p4fxNuT2Rx0Uru7vt5xRNFKADNjDE/pAgHILCxv3MuSb12bF
        QCkV7875iRCI0i0OGGpqB0vlbZve3iq4vwTAhylo7TaCP+I=
X-Google-Smtp-Source: APXvYqwTlGnpvKljv/A+gWXrBQagPeWRX4escL+A4EvlnkUGjBnCOUsATpmufVFSLOgBGzk11NkHm8JcscBxL8t1bWQ=
X-Received: by 2002:a02:bb98:: with SMTP id g24mr2975062jan.142.1565669190112;
 Mon, 12 Aug 2019 21:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
In-Reply-To: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 13 Aug 2019 01:06:19 -0300
Message-ID: <CAHd-oW7aOeDEDFJxj+Pro7-fDiaMzOvas-YQs9Vtx02nZEQkpA@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I just posted a new update on my project:
https://matheustavares.gitlab.io/posts/simplified-version-of-parallel-inflation

This week I sent a simplified version of the series I was working on
last week (which would still take some time to finish). And I'm
working to improve it with support to --textconv and
--recurse-submodules in the added optimizations. I've been also
working on a patch to make git-grep stop adding submodules to the
alternates list.

Thanks,
Matheus
