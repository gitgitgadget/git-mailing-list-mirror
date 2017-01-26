Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888CD1F437
	for <e@80x24.org>; Thu, 26 Jan 2017 10:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbdAZKtK (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 05:49:10 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32997 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753201AbdAZKtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 05:49:08 -0500
Received: by mail-wm0-f67.google.com with SMTP id r144so49531198wme.0
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 02:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EoTsM9dNEvr5hKIYwBSl8uS6ZbOeJEUt02zyH2x3Sb0=;
        b=LySlmUjd/7dc7jXgRBXGB+UwGUBo6U+PWUpeCIGpD/ozKtONTwrmUtqxmgyVkL853Q
         QS3iMUsp8EwPDYNQrR/eF7Jonfe4ikp/TuhbKynNB/1tFwMdXi7AUdLmYwMyWGEuZUjk
         BZDSRCtz+I6nMswWOy4zyNpPetdZTuZGaWBMPzPiLjP5/hDZQhUiE1OAfYcGbHkDKehH
         cf/Vd0THtvJ5PzvlDnSo8HpdJVzkypMsUh8io2vG1sKbLs33xZWEGQXVpiRhJTM1Kn2L
         jmx1FtslPU/5mt8KYr1BrblNLmKt9UdYQHmGwxuriEbZKm5tCUYwUUhYI7xTjkuJaGzz
         a0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EoTsM9dNEvr5hKIYwBSl8uS6ZbOeJEUt02zyH2x3Sb0=;
        b=jLOgwnd0j+ZN3pcotRyuBpIme88dMSJ0/XMZQ3cynJ8//GVOCREBgx/UMeXyUYa42d
         3mddnK/mxZNg6ct3w7+lA2wcIvx2d5ziCmlWOJcXjxqBB9XuZUpKGzV7e9lj0lgVu0LU
         sW7glZEa4m62+9Tjp9HI77hFoDVRw2bWoZfg8JhJpJn1ZLLIp8mrs7vTLcEjLPu0/oU9
         75m/OsQPyrvj2eYWxl3+wb2ju3Yeo7UjNBrFWvzD2p8ynpkMPO8+zqPWnLLs+Z7rp8yC
         H0EcKvjQwbY2NEvQaYURktTHN69mbZpyeBcSTBmtCwEFiqVA27ZxAJOFr5WFVrYBb7N/
         Rebw==
X-Gm-Message-State: AIkVDXL44fKpxVP5JT8s0Yn4TjXmeyQxxJkQDOX5/8mZpf56cbiJvHBlKgXB9h8cta7STw==
X-Received: by 10.28.163.3 with SMTP id m3mr2236751wme.85.1485427747334;
        Thu, 26 Jan 2017 02:49:07 -0800 (PST)
Received: from [10.146.248.54] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w16sm17045133wmd.4.2017.01.26.02.49.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jan 2017 02:49:06 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <D9F0976B-9F78-44BE-B9DD-CAB6506FA3A9@gmail.com>
Date:   Thu, 26 Jan 2017 10:48:30 +0100
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <8141FBB4-ACD0-42F5-9B5A-DA8DF1693972@gmail.com>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com> <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com> <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net> <alpine.DEB.2.20.1701251800120.3469@virtualbox> <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net> <xmqq4m0nc8dz.fsf@gitster.mtv.corp.google.com> <20170125183924.6yclcjl4ggcu42yp@sigill.intra.peff.net> <xmqq7f5i92jk.fsf@gitster.mtv.corp.google.com> <D9F0976B-9F78-44BE-B9DD-CAB6506FA3A9@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Jan 2017, at 10:14, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> 
>> On 25 Jan 2017, at 23:51, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Jeff King <peff@peff.net> writes:
>> 
>>> I guess the way to dig would be to add a test that looks at the output
>>> of "type mv" or something, push it to a Travis-hooked branch, and then
>>> wait for the output
>> 
>> Sounds tempting ;-)
> 
> Well, I tried that:
> 
> mv is /bin/mv
> 
> ... and "/bin/mv" is exactly the version that I have on my machine.
> 
> The difference between Travis and my machine is that I changed the 
> default shell to ZSH with a few plugins [1]. If I run the test with 
> plain BASH on my Mac then I can reproduce the test failure. Therefore,
> we might want to adjust the commit message if anyone else can reproduce
> the problem on a Mac. 
> 
> I can even reproduce the failure if I run the test with plain ZSH. 
> However, I can't find a plugin that defines an alias for "mv". Puzzled...
> 
> - Lars
> 
> [1] https://github.com/robbyrussell/oh-my-zsh

Oh. I must have made a mistake on my very first test run. I can reproduce
the failure with ZSH and my plugins... looks like it's a Mac OS problem
and no TravisCI only problem after all. 

Sorry for the noise/confusion,
Lars
