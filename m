Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6FE71F462
	for <e@80x24.org>; Tue, 21 May 2019 14:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfEUOeg (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 10:34:36 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46230 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUOef (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 10:34:35 -0400
Received: by mail-pg1-f182.google.com with SMTP id t187so8676685pgb.13
        for <git@vger.kernel.org>; Tue, 21 May 2019 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=3ODhcjY9AHPEiVhmHHwIkNKdwmtg5h9kyq9oY4xH5QU=;
        b=so0Nx06KMr+SiY95CYaM9hZSoDWi4rzMo8SrLJs/eWiCxTduNB0TF/sORuIrZDxwHe
         Ys017AvCYUfZ9R6d8GnHMDIr0uyX5I6I7U/7rAyfzVmOTJxZWRoJl4OsjHNq7DOq5/kY
         lfzstErDrIg/cbkOBupx/sSWCN7wUYjoYVTjuSE64IyJJgfP3si2qqigSp5D3P3foKtY
         H9h3ZC2VAvyCw7VZZ1Snjd7W469+2xUeYDYDA8qGQKiXjq2zS1q5g7SWWc7X5XBdBOgW
         vFNprowN/oBMOVzR/9f5QUG4ewTtVOoducGJVRyN8LsP3S4vfTjifmwNBtS7kk193udf
         wEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=3ODhcjY9AHPEiVhmHHwIkNKdwmtg5h9kyq9oY4xH5QU=;
        b=izRo42K4BH1W0nuE+UFjvs8Y2ydwCcwxR4eiPR2CMwERVQO0QsbV5EJGJiKAjk9jKC
         9zACIC+ijIRbmHlv5teUkVvrw9VlK4wNntLDG46vxsT0AgLmhJTFNIDLCMwTIJNLjIbu
         0ogd9bp8PLXjjoNFemWY8U0EMoHY3QA2ZcqFxSMzRbA0j50WYV4ORMfMgt2DS19OhXmF
         H0wUGpOPLsj6y6Y3IamzENJkJ1yru94VDxQHNXspsbzmq2JodQ/xchILgv06cJ4LKTAV
         2QatY5TrhZ0f0u4oHw4oFZSg6hPS2R0fz6E471IY8CrVwQz7mVK31rrVjyMJZ5wFrllC
         RQMg==
X-Gm-Message-State: APjAAAVWZ3pzEVZIqH9tcDjFHeY0yvOhKjv138tW1rWrjOo0Dg+Hnio/
        wJB1lRzms09Y4piX+vAmMjuR43DriikojQ==
X-Google-Smtp-Source: APXvYqywfD5Ogn3UUitU/hzQWDOQbwO3rtmtl482PXFMU6Lob/6r+oRCXo6D5oz0okzoDHlunSQcvQ==
X-Received: by 2002:a63:e645:: with SMTP id p5mr82044845pgj.4.1558449274592;
        Tue, 21 May 2019 07:34:34 -0700 (PDT)
Received: from [192.168.0.118] (96-18-198-246.cpe.cableone.net. [96.18.198.246])
        by smtp.gmail.com with ESMTPSA id o1sm8037635pfa.66.2019.05.21.07.34.33
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 07:34:33 -0700 (PDT)
To:     git@vger.kernel.org
From:   Nathan and Ila Reynolds <nathanila@gmail.com>
Subject: Cygwin Git Performance
Message-ID: <01cf52cb-7e90-efde-a06c-f0413f9efc8a@gmail.com>
Date:   Tue, 21 May 2019 08:34:31 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am not sure if this is the right mailing list.  If not, please 
redirect me to the right place.

I have Cygwin's git (2.21.0) and Git for Windows (2.21.0) installed on 
my Windows 10 machine.  I run the following command with each binary 
"git push --all" on a simple 2 line change to 1 file.  If I use Cygwin's 
git, then the operation takes almost 5 minutes.  If I use Git for 
Windows, then the operation takes almost 20 seconds.  I tried using 
--verbose to figure out why Cygwin's git is so slow but it does not 
reveal anything to me as to why.  What can I do to figure out why 
Cygwin's git is so slow? I am hoping that we can get to the bottom of 
this and it can be fixed to help all users.

-- 
-Nathan

