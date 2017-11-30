Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B790120C13
	for <e@80x24.org>; Thu, 30 Nov 2017 00:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbdK3AGY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 19:06:24 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:44308 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbdK3AGX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 19:06:23 -0500
Received: by mail-wm0-f54.google.com with SMTP id t8so9703551wmc.3
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 16:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=phBLiaCZonF9BAq4cFR4vqfQggyZZ+eFXM+Z41lpKT8=;
        b=kvDv6OBJeD0x0pHdn7GUbpfeQc9sf+MFoZA4gWwWhNrIa3U+a/Sh0113Zo1im9U+T0
         1By+xT+VtTuP/wlgP7j58gHKspHZUVbPWaFpfmQnxEf4bOLodyjWdskVMzVry2GO5jMH
         ZnL1BU0t7b/7kmb+LRZIc83TXKG1mUB5sfM8O3Q9zQmJTMpxWEcYTqPptNN69qHpM1XW
         0FYW1D2UWOZRhziBs4cWlrok8+c+XRPiw+kUjGYCkqAT9J1B8JQ5CcxKu2oCLxKv1+YB
         kfSXdQbtR2Kt/dmFTtOXZzFSjvq5SSpFImqsBgZuIlzwx9UW5DMcpPKxnIeebyG3/xd1
         5Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=phBLiaCZonF9BAq4cFR4vqfQggyZZ+eFXM+Z41lpKT8=;
        b=LPT3GX5nhqe9xpx5aE4zFcAPwGTqaUZl+x26l6mA5cZC+afWl41TImGNJA1SoayFla
         QkxMdFm+5JKdLC4VTWZDuZCVHGX5g53huEl72C7kh8u/WLGy9yCauZJiINjB9RkVp1N3
         cX/6WIIUCJ1nPsY3mZBkxNjFY8ojBpIDcg2kHRMm9lZpRzuYQZjdyifxFMZvM2AVdJDb
         5M096DMzkGrWEOXcDXZttdEw+COLf9YCv6Ni7TOIDzDnMzN/KT7/XjUS9qR3v5VTkTfF
         H828JlJWDAM8cPCanY9vtKsw5kaEovXWCQuseekdGl6nhic52fKK+DIIl+W/UVlOxRr8
         qF5Q==
X-Gm-Message-State: AJaThX7wqdt68zjucqJsgH5NxWLfy1NG68yRDdR5wlrs3F1U13x5M9D0
        x8R39qnM6FGBuGS4+tQ1h8Xh5a54jGc=
X-Google-Smtp-Source: AGs4zMYr3ckA9mRMMXmZa/OEeecfsuZ30RIKfeFaX47BkKeoQQNT1b0NtHiHoYhpo1gV38/wJh9rOw==
X-Received: by 10.28.149.203 with SMTP id x194mr324176wmd.145.1512000382091;
        Wed, 29 Nov 2017 16:06:22 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id i8sm412288wmh.42.2017.11.29.16.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2017 16:06:21 -0800 (PST)
Subject: Re: [ANNOUNCE] Git for Windows 2.15.1
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20171129135723.11664-1-johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <af169d17-708e-5ec0-53ee-b85df76e67c2@gmail.com>
Date:   Thu, 30 Nov 2017 01:06:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129135723.11664-1-johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 29/11/2017 14:57, Johannes Schindelin wrote:
> 
>   * It is now possible to configure nano or Notepad++ as Git's
>     default editor instead of vim.

This seems as a really nice option, as it could\should greatly help 
Windows people in lowering friction in first encounter with Git (for 
Windows).

Being pretty unfamiliar with Linux and its tools at the time, I 
remember the initial frustration in trying to do what otherwise felt 
as a no-brain, simple and trivial task - write the damn commit 
message after `git commit`, lol. Even had to kill the bash window a 
few times, not knowing what to do, where it was clear it was 
expecting something from me :$

I later learned about vim, like getting started with Git wasn`t hard 
enough... :) As soon as I found it being a possibility, I`ve set 
Notepad++ as my default editor.

That said, what is the Notepad++ as default editor option doing, just 
setting:

[core]
	editor = 'F:/Install/Notepad++/notepad++.exe' -multiInst -notabbar -nosession

... inside users` .gitconfig (`git config --global`)? Asking because 
I already had it there, and seems the option made no difference, so 
I`m not sure if it actually worked.

Otherwise, I guess I can dig the answer up from the installer code as 
well... :)

Thanks for yet another Git for Windows release.

Regards, Buga

p.s. Ok, It seems it actually went to `git config --system` instead, 
like:

[core]
	editor = 'F:\\Install\\Notepad++\\notepad++.exe' -multiInst -notabbar -nosession -noPlugin

I removed my original (user) configuration, and it still works (minus 
plugins, due to that last parameter), so all good :)

Plugins do come in handy for me, though, like spell-check when 
writing commit messages, so I`ll just stick with my option for now.
