Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F101F404
	for <e@80x24.org>; Thu,  1 Mar 2018 17:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033203AbeCARfn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 12:35:43 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:45970 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032900AbeCARfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 12:35:42 -0500
Received: by mail-qk0-f175.google.com with SMTP id g2so8533700qkd.12
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=tehjaPT0yUamaSexUCB2XDRFN5fmRaWEz8hR3EyOcio=;
        b=Dt/gE0JK8z8AidLOE4+DjnStr6Pwppr6PWuXdwwztbzdRkRScPjp0ZUsb1X/ILai+8
         SyOcSAMaLWg1+RzuEFwkhkBx2Lt0o34Z2MVWW2H7UGkAZeALIidWxzAPcBAFY9rtzYAl
         MUT8TgOKefExJiVGmKcTP3LLFc0NafbAbigux2tU41LjR7owyab7VVeoGyP2+u8q6NAi
         GcVafQRfhmRJ1vtzTJlKfP88mROPYJ/OkYPYMFjxA0FHH9qfXvlxy6ZE5foX1yHhxCYV
         PMFMqtOW9Af8QuEMl9J7iK8Xsuc3XHqWnWOIARbaSNdWe6dVvYua/lksoQZEOUqOYN5t
         9oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=tehjaPT0yUamaSexUCB2XDRFN5fmRaWEz8hR3EyOcio=;
        b=Yn8CcMx1DrAKeZS2H6AcomeGPHYlQAiqx/wPuxA0jxAbqwqNLb87K3zW4Ywh4Xrq6S
         z1sFp+SbhxBgNdz4zYtYmI9OzGRQKxkjZN9RiOPBXlo01/1u/yyavsyvx0Kl5zbRF3gb
         OlJ1PHlkXakoh0dpcsmCphOLl3thEb9TKB2y8ZrjS3o5LakpIP17xAddyeRlF47NjW4Z
         eUAeWni7f3IDO8PYpIQrc2/D0MUIMXyAXZhgPRwjCfBg7UjJnzPDh9LI30ZxBmo09WE2
         xkTVwLVMTULKC37CGzLdT5Sqzjw65i29SHJy4hCeNgSBi6Tns+SMTkiQv709/TY5s6x/
         TO+A==
X-Gm-Message-State: AElRT7HoYHYLskno7SPTzil4OeWZtBdnffNpicpSE5pNoifnZtCz32nw
        n+OyCcyvmm1jfUhhgspaBznsKkSb
X-Google-Smtp-Source: AG47ELswWQ3iSY6SmrV+yPxLMr+ucEGaPn0PDjym25jCxwwo6CMV895lRIB+3HsJs8u5M4btAT1lPw==
X-Received: by 10.55.147.195 with SMTP id v186mr3994674qkd.81.1519925741567;
        Thu, 01 Mar 2018 09:35:41 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id w18sm3101429qkw.35.2018.03.01.09.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 09:35:40 -0800 (PST)
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Subject: [RFC] Contributing to Git (on Windows)
Message-ID: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
Date:   Thu, 1 Mar 2018 12:35:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We (Git devs at Microsoft) have had several people start contributing to 
Git over the past few years (I'm the most-recent addition). As we 
on-boarded to Git development on our Windows machines, we collected our 
setup steps on an internal wiki page.

Now, we'd like to make that document publicly available. These steps are 
focused on a Windows user, so we propose putting them in the 
git-for-windows/git repo under CONTRIBUTING.md. I have a pull request 
open for feedback [1]. I'll read comments on that PR or in this thread.

If you've ever done Git development on a Windows machine, I would love 
to hear your feedback on this document. Any other advice you have is 
greatly appreciated.

For anyone interested, there are also a discussion about submitting 
patches upstream. The document links to Documentation/CodingGuidelines 
and Documentation/SubmittingPatches, but tries to elaborate with 
additional advice.

Thanks,
-Stolee

[1] https://github.com/git-for-windows/git/pull/1529
