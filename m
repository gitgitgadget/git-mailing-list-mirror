Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4261FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 16:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdALQVp (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 11:21:45 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36592 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdALQVo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 11:21:44 -0500
Received: by mail-qk0-f194.google.com with SMTP id a20so3378764qkc.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xe+r3fQcmURMV+ojr9w5UF3W/fTGrt3cua+yoUpnOJE=;
        b=Lstx92kfskuWNXrZ05AEmdL+QytwzpZcKgnG7eiQKrLg6LgSqGEefzxiBvQpbjqfxr
         DiVqvaVy/zzlIpAuk5isM30XXfnaYFBSs1ma4y2xjksm8EcGqfvZ6n3Vo7hBiwqIzyly
         wQOGOehaOKX2Z7fPcOmzyAPwzL/iLUWWcXQRxmUsFSJN+4tq2GJk+1gckTBTUVKlJxfP
         bEnJ5l0Hl+/55nicT7p0fbPwE5P0C0qmRr5OSQ8gv2Nh3V7YIvOwOOof80z+6CCVoi1m
         k2o/9ywWLJ+nCGVwecuT5EQhYbnJ4Bv6GNh+ThSCkwOAfaksi5lHy7zte2JjSXyR2BNx
         80kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Xe+r3fQcmURMV+ojr9w5UF3W/fTGrt3cua+yoUpnOJE=;
        b=T1UV7rJPVuFICGvzIoF+ly39ttNC/A36LqeMb6ooWcNt8hGVFSzr96KGhbEzH97Bbi
         2+9Ol5MjjhCMFNrSDUB/aHCiR11O0QSniqjjElaNACLB+HgM8EqICv8Y+zkKXB2YCL4e
         tfODrU9EPDaIXqUIo5Uz4rBPugqtIkWcoY/ISx4BHTskBgjfB0a40b1tZa/AzuGP9/kM
         +OP73Pvn4cA1hzR2m+1r6RM7iST3qoaNNN4qpAc3Vlh73bfv3gOQMdrw7jd/Xmeu3aaY
         V7qx2ba5xksBfe1331gdI65shuYf8YZ4wkBaEFU1qsAyWGd6YBjv3a1sdgoExiJrGFGV
         jwMA==
X-Gm-Message-State: AIkVDXJpch6B+S0LazNmG73HqY9CeLANW3wjUAN6qew1weVsg3FIlU8kK5LO3Dz6vWXltg==
X-Received: by 10.55.22.77 with SMTP id g74mr15365151qkh.54.1484238103824;
        Thu, 12 Jan 2017 08:21:43 -0800 (PST)
Received: from [192.168.1.100] (ool-44c701ac.dyn.optonline.net. [68.199.1.172])
        by smtp.gmail.com with ESMTPSA id t62sm6951012qkh.26.2017.01.12.08.21.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 08:21:43 -0800 (PST)
To:     git@vger.kernel.org
From:   Michael Gooch <goochmi@gmail.com>
Subject: problem with insider build for windows and git
Message-ID: <1bddbd50-86ea-6c38-6ab8-08336de2ba72@gmail.com>
Date:   Thu, 12 Jan 2017 11:21:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

when running commands like pull and clone I get the following message:

Cygwin WARNING:
   Couldn't compute FAST_CWD pointer.  This typically occurs if you're using
   an older Cygwin version on a newer Windows.  Please update to the latest
   available Cygwin version from https://cygwin.com/.  If the problem 
persists,
   please see https://cygwin.com/problems.html

Windows build is version 1607, OS BUILD 15002.1001

I assume they broke something that cygwin was depending on.

