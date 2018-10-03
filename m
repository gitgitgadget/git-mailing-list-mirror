Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732D91F453
	for <e@80x24.org>; Wed,  3 Oct 2018 18:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJDBBo (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 21:01:44 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:41632 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDBBo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 21:01:44 -0400
Received: by mail-pl1-f175.google.com with SMTP id q17-v6so3858189plr.8
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xkbxd0uCbQv0GKwfkGwHRKFcTLbpwTBfuxrmLDRRpEg=;
        b=b/U7GEGWjtYoCyCYS+0rhz0MGHB/25shw5CJYE7zBto7gbMQ+zQGR3Yw+qab/eOvD0
         WfsRGMGE+LsiG+SsfV2vG2iPuTV+I9aiLqWL2KVVlLYMUwccsBZpGw2qWpjHemQhhala
         M6eARf89up4ormCYQ8xCx/csUh4FDcEMZO3N9qVVtlK6S8bVwhnNviJX20ZchKlgBXnz
         1Fdzbe9SufPUqdeuEuyilhY+pCz5LSzYCvpH+mNfb+Y0QUam3RS93MC/CNb4Za8FzElj
         U/MQZTLMP9umH08h1oqlWo79u1HMWPYFbmYHxE4LNpHKhBUXZ7YQEMiqy8EvQCfAymPi
         CKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xkbxd0uCbQv0GKwfkGwHRKFcTLbpwTBfuxrmLDRRpEg=;
        b=ZTswApl7CD3OPtR9+xyankQubAhmvMJ3SrVq76gd6WpAxi+W1AgHQeOc4Ycg44FHIA
         2hjJXyz9/gDSZ1an9khxR0349ST5Ley4ku6HxocWIMIlp++q1df+XM4AN3UgTIkB2+Ky
         KFVqvHtHn0/j+lIWR/oBzcB5Tr3BAAjDaLHfOGNaAKLWqziRF6JxcjIy1ltG09+CMg/C
         wE5/9+UECg73RGABTlDSeIJfEXKyB9OdNQQ6XQMaudWXbZrgzLg3OV4hw7fzMEPj6Tvv
         OQkF/4/s+ypkuOHaiqyLsaaUx1nmSPGV3hTE1UZIAa16cMScnbsH3WJDCLkIrIrtHnol
         Exug==
X-Gm-Message-State: ABuFfoivsez74KPP9ZrMVsrbpj06T/cT+1uepE/URhZzR1WKDHw8CuIH
        9X/0SfLa7RTaHHEp58GiQU4SfHmk
X-Google-Smtp-Source: ACcGV62GKy33tRUdoJvo0j8kQS3x1EOWuHLYjFn3JHHWZXys5MF7oAqgdWWtoJ1WMZCrbxwY6KhTYA==
X-Received: by 2002:a17:902:680e:: with SMTP id h14-v6mr2841680plk.177.1538590334760;
        Wed, 03 Oct 2018 11:12:14 -0700 (PDT)
Received: from [192.168.2.4] ([171.233.129.129])
        by smtp.gmail.com with ESMTPSA id u65-v6sm3887708pfb.144.2018.10.03.11.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 11:12:14 -0700 (PDT)
Subject: Re: Fwd: Git credentials not working
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <a1ceb967-6020-6074-f504-c684242c79ab@gmail.com>
 <f4f7bd2c-4c48-e749-4df1-ddf05896b337@gmail.com>
 <20181003171104.GA12200@sigill.intra.peff.net>
From:   Dimitri Kopriwa <d.kopriwa@gmail.com>
Message-ID: <89f60502-c67d-83b6-593b-a0e6d8567183@gmail.com>
Date:   Thu, 4 Oct 2018 01:12:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003171104.GA12200@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your reply. I have activated GIT_TRACE_CURL=1 and I can see 
that the request is failing 401.

I can't see which token is used and using what header ?

The log say:

17:50:26.414654 http.c:657              => Send header: Authorization: Basic <redacted>

I have retested the token locally and it work when used in the url or 
using `Private-Token: <token>` as stated in the Gitlab documentation 
https://docs.gitlab.com/ee/api/README.html#personal-access-tokens

Peff, what would be the appropriate way to input my git credential in a 
100% success way in a CI?

Is this good:

git credential approve <<EOF
protocol=https
host=example.com
username=bob
password=secr3t
OEF

?

I would use the custom helper after I can understand how to properly use 
the git credential store in a CI environment. The fact that I am using a 
generated file is simply because this is what the documentation told me 
to do. I did not found anywhere in the doc how I should create that file 
in a non tty terminal.

Thanks again for your help.

On 10/4/18 12:11 AM, Jeff King wrote:
> On Wed, Oct 03, 2018 at 09:06:38PM +0700, Dimitri Kopriwa wrote:
>
>> 18:25:52.940307 git.c:659               trace: exec: git-credential-store erase
>> 18:25:52.940365 run-command.c:637       trace: run_command: git-credential-store erase
>> remote: HTTP Basic: Access denied
>> fatal: Authentication failed for
>> 'https://git.example.com/example/some-project.git/'
>> [...]
>>
>> Can you please help me found why is git credential-store erase called ?
> This is expected. We tried to use a credential that was rejected by the
> server, so we told all of the helpers it was invalid. You can try
> running GIT_TRACE_CURL=1 to see the HTTP conversation. There will be an
> HTTP 401 with the authentication failure, though it may not tell you
> anything more useful than that.
>
> git-credential-store is meant to be used interactively, to insert and
> erase credentials as they're grabbed from the terminal.
>
> It sounds more like you want to just have a stored credential that you
> try to use. You could do that with a custom helper. E.g., something like
> this in your ~/.gitconfig:
>
>    [credential "https://example.com"]
>    helper = "!f() { test $1 = get && echo password=$(cat /path/with/password); }; f"
>
> -Peff
