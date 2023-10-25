Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986628DDE
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay60sQgX"
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A479B184
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 13:59:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5859a7d6556so225658a12.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 13:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698267560; x=1698872360; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muqlj1Y8gcIQHyAm+5IW8Me255x9DTNv7AIDntQ2Kbw=;
        b=ay60sQgXlRdqB32OUdvJJ97COASZF3ifi6rq3l1CUukTzq8o+kKuL2FOdTx2ybSgoa
         C1QKnU+V5iIMwEJHrEgSLOM/nb1gLY0CZccR0kKLKrSO63eVqrH6QmBkTSsngs9JkscF
         LzSyUrD2eqCERpwwDIbrKILo4CSrfEE/G6g1UkprOehvoBs9gdbI+6Nu2/SOWSHKyGHu
         KC/0jjQtHcIhFFr6Wes9B2Pwj2N3OusoEkLXWCiBNUikaTjyEks30jXrDjZc1FsdJGOM
         6gAdrTcE3uReLaZvN4FpOygtTMgbetslkbaWHIEylBJNUmNRTGGFkV3LdU3Gc4enkYBI
         aCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698267560; x=1698872360;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=muqlj1Y8gcIQHyAm+5IW8Me255x9DTNv7AIDntQ2Kbw=;
        b=vwhPdaX/UY5Eog03JNsk5/K9j5Z+6hvkfO90CoDNf0m8hQe3c9BSVcl1m4DYvFFXBl
         oOgZ/M3qp1a5A1N545wvw3023+kKwl54gZhuKU59oAkp2D7EVN3ni7w+1SN7v1tCXXJf
         NwQioIRwPwTas6WaPfuM69t3KrbVOXT4a3mhM5G7Nb1lKpG/PSSxhtNm3iRtNnMBes6J
         X7o9hDVSsu96u1eKANU2WqPDiQgQaUq/Vsf3TTuevfYCCo5ySe+wKNQNHatRG+y4qWFo
         TqzOsrLy/7RThMhLkiPaUFJi6Z4xZrnetQY1w1VwcBvGvqPz1ZkvGtaTudkWPoqnDlOf
         3d8Q==
X-Gm-Message-State: AOJu0YxJiEt1vpgIWpjPocEe5qnZ1uKmKgybM2Hi9IWFVEpYROJWRLw7
	AEW3/D+9TY0muvxT56TTmdeRNk4kq9w=
X-Google-Smtp-Source: AGHT+IFYkHr7YAGJ+lO24DsQYaScrtawgR8ftV8iZ4VzMD1QXJGy38cO78W/IQ2q4tLvjAYfoq9vMQ==
X-Received: by 2002:a17:90b:3d8a:b0:27d:b87b:a9d4 with SMTP id pq10-20020a17090b3d8a00b0027db87ba9d4mr15696506pjb.7.1698267559676;
        Wed, 25 Oct 2023 13:59:19 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090a1b8f00b002791d5a3e29sm315262pjc.6.2023.10.25.13.59.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 13:59:19 -0700 (PDT)
Message-ID: <7a92b537-ba88-4667-bb18-2e8c74aa9915@gmail.com>
Date: Thu, 26 Oct 2023 07:59:16 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Sheik <sahibzone@gmail.com>
Subject: git bugreport with invalid CLI argument does not report error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maintainers,


Running git bugreport with an invalid CLI argument in a valid Git 
directory does not report error. Expected behaviour would be that it 
reports an error.


#Example git commands which should have reported an error but continues 
to succeed

cd $ToAnyDirectory

git bugreport diagnose


Thanks

Sheik


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.6-1 
(2023-10-07) x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]


