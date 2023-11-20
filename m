Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEJnSCpU"
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E89F
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 00:36:46 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7d9d357faso43603607b3.0
        for <git@vger.kernel.org>; Mon, 20 Nov 2023 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700469405; x=1701074205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IEvmTY7Wv+S9mpUkqW/wQiWAxSZ9v8thhd42t7od88=;
        b=FEJnSCpUEzV2cUL3CFURYXmXi+TJHWol4N0MoMiXWMwvvUbCDHqIQtxmrUvXuWYSaZ
         A+io/KlQO0sayIV4rqT7gHRUyjmsrIC75x+zlqY6YSO0NBAJBDhYUqx6fPgQVQ56xjUW
         DT5aKsxuaqqw4XcEC+iy6PNY6nP9w8GWE8WxpItTEffv78ebxpEDJKRguSYZeXAXT9zA
         a1hY11mJBH1bbAh80BeMMIlGyMSGlEFC3IYVGz0SaIGUkxBrPucrcyGh1dicJm5HVer4
         SP1u9/eYlB9vqRD1K++sqYJHsSD45D9YaJwk4ArceIeKF39WGzaUaQY7xBiHFvBkvBmp
         K10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469405; x=1701074205;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IEvmTY7Wv+S9mpUkqW/wQiWAxSZ9v8thhd42t7od88=;
        b=N804nM6+Gp7hHOlJgmqkWQ+2xIDKQc7tTcJFIqCbb3q3K7gCzRHppoKcJcoIscVx5D
         kZQkviW/VCoSmC9nlQ3dGeqsE/0s6RhZ40zD/GZ15gvEf2cMA5I+z0JRtxh0LsBUggBO
         crn8cCWhscY/Y/i1OrUzRHb1I6Lw6qSAkVgmmWRnhdmk6re2Hgrf1GAvJaak5Z8yvilY
         tiJZWF5nIGM8svBHfOWHpPWghQrGwXN4d2UzruP0zu/ZdMj/k35fijkpmzbz6fgMSN1/
         zxvv0dpL/kNCPLZX4LzDUKrNO0npdVCJGvPxnYf/2Q+NDufDduvlV6KoixAxj43xxoS8
         1MaQ==
X-Gm-Message-State: AOJu0YwGBnFp22ArbiaMqUD54hGptPEcRlCfl6r6aCjfMeWy8bU4D1BN
	8Pv5Uarnwstz1qiQycHZofJCNC6+1NI=
X-Google-Smtp-Source: AGHT+IE0WFMBSNmU4z0moyXXeSJWZMZ0wZgq4ryg2tfXw+dCOlxfWZAMEesoCCp71/ldyfCPE5awpQ==
X-Received: by 2002:a81:ae65:0:b0:5ca:d2ec:7ee7 with SMTP id g37-20020a81ae65000000b005cad2ec7ee7mr778865ywk.32.1700469405226;
        Mon, 20 Nov 2023 00:36:45 -0800 (PST)
Received: from ?IPV6:2605:2a00:8001:dead::3ac? ([2605:2a00:8001:dead::3ac])
        by smtp.gmail.com with ESMTPSA id l10-20020a056214028a00b00655ec7bbfd0sm2746504qvv.7.2023.11.20.00.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:36:44 -0800 (PST)
Message-ID: <e855cb0a-bc9a-4412-bb67-01ccba7959a1@gmail.com>
Date: Mon, 20 Nov 2023 03:36:41 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bugreport
Content-Language: en-US, fr
To: galo joel <ilsmaciaszambranogalo@gmail.com>, git@vger.kernel.org
References: <CAKh3n_qqMiJL-Mn2MxBmG5MRL36w+v-kxjqb8wUv1i7KOEVaDw@mail.gmail.com>
From: Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <CAKh3n_qqMiJL-Mn2MxBmG5MRL36w+v-kxjqb8wUv1i7KOEVaDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Joel,

I'm copying your attachment in-line for simplicity...

On 2023-10-24 16:40, galo joel wrote:
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> execute as admin git bash and,(in cmd W10, same. open git-bash.exe as system-32).
> try chmod 755, 777... does not work 'cause im user ($) and not admin (#)
>
> Wha did you expect to happen? (Expected behavior)
>
> change .sh to chmod 755 for execute bash
>
> What happened instead? (Actual behavior)
>
> nothing ._.
>
> What's different between what you expected and what actually happened?
>
> i expected a good sript in bash. now i'm sad
>
> Anything else you want to add:
>
> Please tell me what happen, maybe i'm wrong but chatGPT also no have idea why
> i cannot be admin in my own laptop xD, or maybe i need some libraries that i didnot
> install. I sell all my information so please help me to understand why does not work :)
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.42.0.windows.2
> cpu: x86_64
> built from commit: 2f819d1670fff9a1818f63b6722e9959405378e3
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19045
> compiler info: gnuc: 13.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show
>

You don't need admin to use git on Window. OTOH Windows has no concept 
of POSIX file permissions, and this is the reason you cannot set file 
permissions using chmod under git bash.

This Stackoverflow question has the answer you're most likely looking for:

https://stackoverflow.com/questions/21691202/how-to-create-file-execute-mode-permissions-in-git-on-windows

Regards,

--

Thomas
