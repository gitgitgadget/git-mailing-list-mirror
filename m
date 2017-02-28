Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCA6202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbdB1V7J (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:59:09 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33680 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdB1V7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:59:08 -0500
Received: by mail-wr0-f178.google.com with SMTP id u48so17919226wrc.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wRE8lNp1OmXNLPfAL8p1MH6tfvU9oWr12y2hgRyq3a8=;
        b=jrnBk9MwH+hIvVai9OSX9z9evtYoOpzZKrFon80kDdONHI539Gf/vLkzIe9Zd1OsCZ
         fbAv/eTVPVfU1cubE06FFwS1Rbd3m3dr0YDa8D3I/wj0vrh4+DsHB8DMwdPKRlIM86oL
         Ihn0r6DIhweEFvdRnMapy5WrpD3VcfgNzJc70WBJbjMlkBJlJelCxMGB7Jtv/f4vGTH8
         PGmU9tGDfP7F1/38+HcobCMcZoPr5jWgM8sr1RavS+d7yZ8B5OhddyfVe5Wifx7lYpeE
         gpFrLOaAypUwUftUP0V+Xh79JC1xbAAuP89yWpJO+qMbudlH8Qbw13KEdxg/k7NztVyf
         3Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wRE8lNp1OmXNLPfAL8p1MH6tfvU9oWr12y2hgRyq3a8=;
        b=VsWRY5Z6QOg4AwHO0D6xWoNlwKgpRYeTo+bVDKVkV0ePK8z+e1/mwn4Zf7YvtFZp/0
         tvEuHHDsXqveblW24KRvw5YfAyCoYmLZT96PksFASVm7x+qlcMuMvBbh+ZKf/x0PyJlQ
         wkrntF0V8UUgkHeq8Kq6TyOf94tVbIJdN+rQYHdbQG+PoMt/7bo4rSdWj2QFuOQkR0t0
         aU4x6ZUCT1OxbP1KMujv5Gr2fFgUChdSj0Po4ppIIXtpHM6p+MZTQyxOs2v8E0OTDrL5
         MbcQComRkVjpUdPOlysQtTSuaJHWxC57Xu0vKN9oYrVOkDkYoBqaAR2Tyi1dP2F46fuc
         MwAA==
X-Gm-Message-State: AMke39lyfQPKJjY2wd/jKJBJkRSG8u7L3BS2JKQDil9uhuTE2KjPDc9o2/B1ZuNQt0kjwg==
X-Received: by 10.223.170.70 with SMTP id q6mr3905432wrd.103.1488315303869;
        Tue, 28 Feb 2017 12:55:03 -0800 (PST)
Received: from ?IPv6:2001:a61:1052:4001:ede7:c9d0:a549:517a? ([2001:a61:1052:4001:ede7:c9d0:a549:517a])
        by smtp.googlemail.com with ESMTPSA id 65sm3770473wri.53.2017.02.28.12.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2017 12:55:03 -0800 (PST)
Subject: Re: [PATCH v2 1/2] Documentation: Improve description for
 core.quotePath
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        gitster@pobox.com
References: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
 <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
 <1487968676-6126-2-git-send-email-asheiduk@gmail.com>
 <f6845604-005d-06bb-e5e6-61f683cdbaf8@gmail.com>
Cc:     git@vger.kernel.org
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <245b0848-3af9-7d7d-02f0-df470ddcca79@gmail.com>
Date:   Tue, 28 Feb 2017 21:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <f6845604-005d-06bb-e5e6-61f683cdbaf8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.2017 um 22:43 schrieb Jakub Narębski:
> W dniu 24.02.2017 o 21:37, Andreas Heiduk pisze:
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> 
> Thanks.  This is good work.

:-)

> 
>> ---
>>  Documentation/config.txt | 24 ++++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
[...]
>> +
> 
> This empty line should not be here, I think.

Missed that bugger...

[...]
>> +	values larger than 0x80 (e.g. octal `\302\265` for "micro" in
> 
> I wonder if we can put UTF-8 in AsciiDoc, that is write "μ"
> instead of spelling it "micro" (or: Greek letter "mu").
> 
> Or "&micro;" / "&#181;", though I wonder how well it is supported
> in manpage, info and PDF outputs...

... and fonts installed on client machines!

Since I started with a two-line diff for just git-ls-files I decided to
play safe with this,


