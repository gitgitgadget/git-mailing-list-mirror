Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F522C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiEXWDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242017AbiEXWDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:03:33 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE816D4FE
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:03:31 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id dm17so15243045qvb.2
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=29IgCOgVqysALq3Hw+klbJnTN6Wvluzht+eLqeOP8uM=;
        b=iZCfnLhqmHVOAX9XbYwJ1BpbeIaaXj3OSs956EQQKiIVum8PRS0pAQSftBLaHurTIi
         E9zxIR9aHyBqr6tmg5YS+t/nr2UPJgSQkplMvS88gb1kG1uLRJMzUlF/JpiOrdNJrz18
         qrltVSSZruvSHCrgNfwBELfC7UXY/LwJ+Vhr0wp8YEcA97CxurVSyurVgqwDL9ac41fD
         qL731hp7A36v5guWHBYsmjEOYiK6LZDzXsuwSCb1dRsdNrRuYGpMfKPOTCgpQk4J+qJJ
         uAa+yrgXK8JAXHOwX9pysG9elQhBlhp4x+gcw8kHbYQHE9V+CeHOB0XCDazEih3tUkcF
         E6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29IgCOgVqysALq3Hw+klbJnTN6Wvluzht+eLqeOP8uM=;
        b=c+rhQmv3t3aRwjji+KYvhzHtsjn2V7h1fcAztxTom5jL66z3KSCnaO/QGBSMk2bhig
         zAkSRktCTznqe9AYFKTYYUdZDYSEmr4LVlwE4uZnUNGlaJJ10iGVyNpwt9eyojt7wL+Y
         YtyulAI8oNcQ3L4HZWjROggrI8inVNe8ZJ29q7xcCA6MFfh2/5NbDw9hrNwczowOA0ZM
         iryjPXBS6IAkv7gxVfeUmsCq+cmMOTuhFG8wVBQpCthZNa/CVvqlx/bl4GXK8lVuws4c
         /cN/Y6ZnqJZJPU0LP/7+dA6p0EIEHUspXmZfJzVUO2I/CfTMa7FkavozUplmrhhY4jR/
         ps7A==
X-Gm-Message-State: AOAM5336jFyGeCBTuyG3WyNsxgS/HwSRYwtsi7Zm3QDUJ1XqchJCocnD
        s4DnSaUX2I/L6oZS2yL1D/s=
X-Google-Smtp-Source: ABdhPJwTg6q6mP3nqAuw9QsW4i4MQM6/vGaRdU86sYtS/DeTYwy8gQSroIjQ4ruxRF6hGUCh8X8sQw==
X-Received: by 2002:a05:6214:629:b0:461:e291:6c4e with SMTP id a9-20020a056214062900b00461e2916c4emr23583005qvx.33.1653429810875;
        Tue, 24 May 2022 15:03:30 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id 11-20020ac8590b000000b002f39b99f684sm423206qty.30.2022.05.24.15.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:03:30 -0700 (PDT)
Subject: Re: [PATCH] Fix wrong info in `INSTALL`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Shao-Ce SUN via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Shao-Ce SUN <sunshaoce@iscas.ac.cn>
References: <pull.1241.git.1653424998869.gitgitgadget@gmail.com>
 <220524.86a6b6vcao.gmgdl@evledraar.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <572f5565-3892-2056-f202-b547ced4a9fc@gmail.com>
Date:   Tue, 24 May 2022 18:03:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <220524.86a6b6vcao.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shao-Ce,

Le 2022-05-24 à 17:39, Ævar Arnfjörð Bjarmason a écrit :
> 
> On Tue, May 24 2022, Shao-Ce SUN via GitGitGadget wrote:
> 
>> From: Shao-Ce SUN <sunshaoce@iscas.ac.cn>
>>
>> The user prompt should be `$` instead of `#`.
>>
>> Signed-off-by: Shao-Ce SUN <sunshaoce@iscas.ac.cn>
>> ---
>>     Fix wrong info in INSTALL
>>     
>>     The user prompt should be $ instead of #.
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1241%2Fsunshaoce%2Finstall-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1241/sunshaoce/install-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1241
>>
>>  INSTALL | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/INSTALL b/INSTALL
>> index 4140a3f5c8b..7bb3f48311d 100644
>> --- a/INSTALL
>> +++ b/INSTALL
>> @@ -5,8 +5,8 @@ Normally you can just do "make" followed by "make install", and that
>>  will install the git programs in your own ~/bin/ directory.  If you want
>>  to do a global install, you can do
>>  
>> -	$ make prefix=/usr all doc info ;# as yourself
>> -	# make prefix=/usr install install-doc install-html install-info ;# as root
>> +	$ make prefix=/usr all doc info ; $ as yourself
>> +	# make prefix=/usr install install-doc install-html install-info ; # as root

The prompt for the first invocation is already '$',
what you are changing in the first line is the '# as yourself' comment
which is a shell comment and thus uses '#'. This allows 
the whole line to be pasted as-is.

The second line is supposed to be ran as root and already has '#' as
prompt, and also has '# as root' as a comment, which you simply
prefix with a space.

I don't think there is anything to "fix" here...

>>  
>>  (or prefix=/usr/local, of course).  Just like any program suite
>>  that uses $prefix, the built results have some paths encoded,
>> @@ -20,10 +20,10 @@ config.mak file.
>>  Alternatively you can use autoconf generated ./configure script to
>>  set up install paths (via config.mak.autogen), so you can write instead
>>  
>> -	$ make configure ;# as yourself
>> -	$ ./configure --prefix=/usr ;# as yourself
>> -	$ make all doc ;# as yourself
>> -	# make install install-doc install-html;# as root
>> +	$ make configure ; $ as yourself
>> +	$ ./configure --prefix=/usr ; $ as yourself
>> +	$ make all doc ; $ as yourself
>> +	# make install install-doc install-html; # as root

Same here.
