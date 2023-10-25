Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BA883B
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzYvXrGk"
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A012A
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 13:41:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6be0277c05bso155730b3a.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698266502; x=1698871302; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etmrizWDtfVBCGuGqT7jU0OQgYeJjcwpupJU10dJlG4=;
        b=OzYvXrGkx73P0nEvVg9rzQnC2s0NBzUzQR7NDamy9qsUeUYQ4KS1ZDQjAvoXRucuan
         Y6YMD/tzPLAumbFyHmiSgjGU9cFIZQ09M8ZuHaeDS28CV146ZUCZZLDn+C4YscAJdix8
         aOBYu8TRTMU+zWR51J7aaTWDyOWOQWTPuhed7uWW/bQOiK77NeJsM3VpmbMdDgHGfoEh
         tctvl1LDriXRusR1ScaNwT4QrkAZWVa4TlI2OnrprTk6sgGb5dXvGNMRk32ZqMQ3SY7V
         LiETlKpA3Rxiht6o77IMsHccQLTx377PwBrMDkUmdpEVTTGLzu+zI+ZZVxnAjnK9HCvD
         Y03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698266502; x=1698871302;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=etmrizWDtfVBCGuGqT7jU0OQgYeJjcwpupJU10dJlG4=;
        b=cLFTEYOmFuFbrybjFVq8man5O3jYJXJbmInaNmh8Asdy0cTZJJvbsBiQAsgeaZoGVI
         FiFbqXAq20Za4MTqBhdIJc42YdwWOheiCZvJEWv1YMxPMKbArqFzstLGeYQRPin6CH5i
         /Hw9vJb962Sh4QWp6m4cG/TgMerohY+3f0+cTjbEOK6lMIb3f2CC8sXBiEz95DUhIhgy
         UI3WrWtzAx1mN8Lbou3CMBM85Ab7cgYoNTIvT49paqKd0jlHajmFoLmGazVQml+s+sTl
         K1lbMeAXfs92Tp+6wnhEPSt4nV3bi2m1jftShx7DMcWYXZ2V05isTBBZ7BhYxkDu0+bc
         NERQ==
X-Gm-Message-State: AOJu0YzmLKFHscdQxxJN2tHgAYWKGlvLWovqztDweZeO/mXbZW3mwh6c
	Q2EFyD/GV3P7/tMY9LIFZrktdPtfDa0=
X-Google-Smtp-Source: AGHT+IEBPdTIDtdrpT41tE7Ygf9aqfZAWibxu+YyqWRa0NA2QrL26OB1w4jmPUwpLGC/WhcA56kFyA==
X-Received: by 2002:a05:6a21:a583:b0:17a:eff5:fbcb with SMTP id gd3-20020a056a21a58300b0017aeff5fbcbmr8656710pzc.43.1698266501729;
        Wed, 25 Oct 2023 13:41:41 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id z19-20020a63e113000000b00577d53c50f7sm9339081pgh.75.2023.10.25.13.41.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 13:41:41 -0700 (PDT)
Message-ID: <3e409165-2468-47be-895e-f3ec86b94730@gmail.com>
Date: Thu, 26 Oct 2023 07:41:37 +1100
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
Subject: git diagnose in non git directory results in core dump
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maintainers,


Running git diagnose in a non git directory results in a core dump. 
Expected behaviour would be that it reports an error.


mkdir test

cd test

git diagnose

#Output...

Segmentation fault (core dumped)


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

