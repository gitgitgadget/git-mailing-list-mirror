Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047A9202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753501AbdCHPpE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:45:04 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33173 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdCHPpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:45:03 -0500
Received: by mail-wr0-f182.google.com with SMTP id u48so26206414wrc.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 07:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i6LRYFa8YrNAUwMeUp6672mwWdxmeEfNO/pC4n4GguA=;
        b=p3EhkqODWftUkhkOLeSlo0JXNSPjzZ4XvZofmlPNYlT18VzR8z2Y8kXe3ki8A1zqVE
         MfRkqSVN7/TkblXEBpt74c7cM5O0Rgz7fysnH9iVVBTumJf0RrpGhTFNGTD0J3M91dmY
         CDlOQvHJU2KXFVjZyPumUyii6aFTJTwqKrII4lgmqJPO0rIxNtZgrbwMr1msAcy4CKFP
         OrPv4Kar5JOdxkKYdztsykLRqsc5ru/ZjoWeQ1066RzGuEYaaboyYUlT3I/GcMIHRIUr
         o3PQBHpwG+tjWTSPgaWRojIBlfAbm0GGItRzVJOH7G4vftiF0B9LDnK+f5HgDZbjuW8M
         Jr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i6LRYFa8YrNAUwMeUp6672mwWdxmeEfNO/pC4n4GguA=;
        b=RWNbwfxIxyAXXyhg1JZCnT7JKX5uk+DpGbVm7P30l7kAR9cpE16lJ6JAHxPqpNtqAv
         1haakmwTW337PCm3H2cPYa6oPCCSLsEl52qA21py4mEKAH8RKCauMmEaEesNZtEARUbr
         Gji2sgDdBPb2qvLUi57lQHdAamLFjAIrq+taikp+uNyPW/hpiQAHcyf8TIw9TMEv//5P
         JCFdUeS+dYttUMYimIDNbNqVEysnqaBrnXQihVQtNMR7myAk+/zDXqIg0bJJvwEZz1ls
         ojbssZofciszzC//1WMNgxP1spjghRfcSLcYL1RSoQHLLVTTzjobm4snDZu75RtFWZFP
         9Tfw==
X-Gm-Message-State: AMke39lJl4w2wy7yXUHT+7do6fSEBqWcP/WuZTU1mZd3L+H8G2XV6fJsPAN+ZsJkp53U0EHXJMEass5z5yZdcQ==
X-Received: by 10.223.177.148 with SMTP id q20mr5572717wra.154.1488980580502;
 Wed, 08 Mar 2017 05:43:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.126.201 with HTTP; Wed, 8 Mar 2017 05:43:00 -0800 (PST)
In-Reply-To: <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com> <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 8 Mar 2017 14:43:00 +0100
Message-ID: <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 2:33 PM, Jeff King <peff@peff.net> wrote:

>> I'm getting
>>
>> $ git config --global diff.ignoreSubmodules all
>> $ git diff
>> diff --git a/scanners/scancode-toolkit b/scanners/scancode-toolkit
>> index 65e5c9c..6b021a8 160000
>> --- a/scanners/scancode-toolkit
>> +++ b/scanners/scancode-toolkit
>> @@ -1 +1 @@
>> -Subproject commit 65e5c9c9508441c5f62beff4749cf455c6eadc30
>> +Subproject commit 6b021a8addf6d3c5f2a6ef1af6245e095c21d8ec
>>
>> but with
>>
>> $ git diff --ignore-submodules=all
>
> Hrm. Isn't "all" the default? That's what git-diff(1) says (but I've
> never used the feature myself).
>
> That would imply to me that there's another config option set somewhere
> (perhaps in the repo-level config). What does:
>
>   git config --show-origin --get-all diff.ignoresubmodules
>
> say?

It says:

file:/home/seschube/.gitconfig  all

-- 
Sebastian Schuberth
