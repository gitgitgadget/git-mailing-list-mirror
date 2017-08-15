Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834F5208CA
	for <e@80x24.org>; Tue, 15 Aug 2017 13:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdHON4N (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 09:56:13 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37030 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdHON4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 09:56:12 -0400
Received: by mail-qk0-f195.google.com with SMTP id x77so743762qka.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o27xcLXbjmAUv1KZIgCzT9OtTrht8H5orI6JCLwTtTE=;
        b=Oot1byZOhyPxHjyaMVpld85xNXV6exA57MXpyEjMVuC0GJ69MlPjO1BU3eQDzy56Hk
         V5Jy5EoiQgvAtW1/TE02O7YeYHlFTiYuEj40m1FfOZp2NU+U9bbunDuI0QWulfwYwokN
         Q5wzCCn2E1KXF9433N2d1Wp91m5nA6w+wAZu1yKVMLoZLC9qov8MPkrHFqFNgMsmw+v8
         FqeNVcyzg96AYV4yHYFH5rovRALqLo/ZUxQB7iEvbwC5UaMLxLzaB3ElhNbHpGdaicv2
         z+6Khsls44wP6Rd8rvnDF9HAXtV67uyrwa9ZN5SmEUc1qu3aBFOk5fxrYMS7XJ2FhCkv
         TPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o27xcLXbjmAUv1KZIgCzT9OtTrht8H5orI6JCLwTtTE=;
        b=QSkiVxuMILt/PaATCtszvIfRyAL/zYYnpr1KYedUfFTyXb+MoVvDFHSEbLwZcEyudz
         e+amenoK/q51ESoUEJ+Ykas8xFipS/y/3s6rXkbxjpoZ60qJN7IPXBONB8nCC4ex/Rkj
         o5UZ05PNW2dXW/uIR87LkbtXCmaNxXuXibZqAGdhFEO6rYoxfZjH6T5sejPomFs5V82N
         CzS3O8vJz/QQiYoJ5u7Jp3+IYRycxTTcjlyjQEB19j3ZF9l/3bRakk5nQjPbunF00iBq
         0N8x66I1o1RujyhFuAs4mmIFSVmV9DvmICYWbWlncAvWWLl3KOwSdYGKpQRKvqaefMfB
         NAwg==
X-Gm-Message-State: AHYfb5hz44XLav/YS7zIkkcFAv8m1oU4posQDoJLq6epnLdbZpG8fMfB
        Vll1LHH/Xk1kyQ==
X-Received: by 10.55.121.1 with SMTP id u1mr19554411qkc.264.1502805371905;
        Tue, 15 Aug 2017 06:56:11 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id v23sm6546352qkb.65.2017.08.15.06.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 06:56:10 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding
 style
To:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com>
 <CAGZ79kau6_XeEQqYDhFC2FmyJiqWY2+SuRzvGFrfmLdhAaQS+Q@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <41c8c119-af98-f16f-1585-81b29429afe8@gmail.com>
Date:   Tue, 15 Aug 2017 09:56:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kau6_XeEQqYDhFC2FmyJiqWY2+SuRzvGFrfmLdhAaQS+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/14/2017 6:02 PM, Stefan Beller wrote:
> On Mon, Aug 14, 2017 at 2:30 PM, Brandon Williams <bmwill@google.com> wrote:
>> Add a '.clang-format' file which outlines the git project's coding
>> style.  This can be used with clang-format to auto-format .c and .h
>> files to conform with git's style.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> Applying this patch and running
>      clang-format -i -style file *.c *.h builtin/*.c
> produces a diff, that I'd mostly agree with.
> This style guide is close to our current style.
> 

I'm happy to see progress being made in helping reduce the time spent 
manually reviewing and fixing style formatting errors.  In an effort to 
help, I installed this in Windows and tried it as well.  The tools all 
appear to be working fine and are supported on Windows.

For the most part, the formatting rules look pretty consistent with the 
existing style.  I ran the same test and looked at the diffs and saw a 
couple of things that looked odd. For example, how it wrapped the 
"static int" on the function header below was different.  Not sure why 
as it didn't wrap all the other function headers the same even later in 
the file it didn't do that with "static void mute_routine"

diff --git a/apply.c b/apply.c
index f2d599141d..bb77242e3d 100644
--- a/apply.c
+++ b/apply.c
@@ -58,12 +59,11 @@ static int parse_whitespace_option(struct 
apply_state *state, const char *option
         return error(_("unrecognized whitespace option '%s'"), option);
  }

-static int parse_ignorewhitespace_option(struct apply_state *state,
-                                                const char *option)
+static int
+parse_ignorewhitespace_option(struct apply_state *state, const char 
*option)
  {
-       if (!option || !strcmp(option, "no") ||
-           !strcmp(option, "false") || !strcmp(option, "never") ||
-           !strcmp(option, "none")) {
+       if (!option || !strcmp(option, "no") || !strcmp(option, "false") ||
+           !strcmp(option, "never") || !strcmp(option, "none")) {
                 state->ws_ignore_action = ignore_ws_none;
                 return 0;
         }


Later in the file it wraps some of them again: (add_line_info, 
prepare_image, find_name_common, etc).  Again, it appears to be 
inconsistent but there must be some rule that is causing this behavior.



Here is an example of how it wrapped bit fields differently.  Again, it 
didn't seem to be consistent with itself as just below this, it left 
them on separate lines.


@@ -182,8 +185,7 @@ struct fragment {
          * but some codepaths store an allocated buffer.
          */
         const char *patch;
-       unsigned free_patch:1,
-               rejected:1;
+       unsigned free_patch : 1, rejected : 1;
         int size;
         int linenr;
         struct fragment *next;


Big thanks to those working on this!

> As noted in patch 2/2 we'd now need an easy way to
> expose this for use in various situations, such as
> * contributor wanting to format their patch
> * reformatting code for readability
> 
> Thanks,
> Stefan
> 
