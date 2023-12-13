Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km801F/y"
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A2F4
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 01:54:34 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so84824641fa.2
        for <git@vger.kernel.org>; Wed, 13 Dec 2023 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702461272; x=1703066072; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktMZFq6CTm/6OBr5JACmsDlnhqSrArSojtdhkLoVF7E=;
        b=km801F/ycFoL/Qe1rVGKmpRuW/Vnem7eAwwM+xVpzQJWOxwsqF2oGuoY89mFTqYiJF
         mn1NI8LfBy1Q6AY7o3VQrleXzRaAXNaAdUDTL/ddWWpgLd0uQ8RVbvueAc+v9ybBGHv/
         BPMiomZz4Xz/fexra9hnqIRLpF3zjpyPq3AnvASEeLcsV/KSzf7ZSylh1isUsOdwuy+L
         HnaeGWp+tt/HmTglpyB6KPncO1JK7gvmwQV96qvRCK6hyqfVf1Ur7xjDhjCBgMWBWh3o
         b7F7IJm/a6iTwapHoNT9QmTZ0zWp22xdhSePYCTq3ybwbOVmnrra9nonezm9N8v3YGGl
         TY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461272; x=1703066072;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ktMZFq6CTm/6OBr5JACmsDlnhqSrArSojtdhkLoVF7E=;
        b=FwxqspM6VLWARmz+sxfRMoOeIt4FJtHB6iJ6C8miy6K9qNcRaWVgHff1vxnR6JIGtp
         Ittj3bXK7l7cM8NOGuiATo/5nCN6KROQx6scqPKpjeKVx8nJph5Yhq02FzgRQnBVEjby
         k5tgw3YEuUrRyE1rzAZPMnfdgQIzznfsb1dbpPkAf4iF9M5ojo4vXW4Y6bVLqmx9GLiZ
         V6QE/9yc6TZNQDyxSbNmA66TYqwJaoEX1SZkvA33bp2ur1O12ch7EU/ZuY/64ONy6aI8
         FS7GLzY2ydatBeAfUEXAWk3/6S4XjCgnqELw246FMb4d2RUeNirT/3DgKCkJLNO8L1IW
         xDpw==
X-Gm-Message-State: AOJu0YyPzZb/W3yg4kifW0DhzwCRYh03WsCPpd4xFUAVxj95qNL1xd6A
	5slBbOPgNhKSCxaH69pW+I+37AEzKQA=
X-Google-Smtp-Source: AGHT+IHzHG6Gtcdlcj/X3fDEApHm0yxqWlf22Ztht8k8aHPlNf4UAdBkpNAd2FgWaCcXXalBMq+VOQ==
X-Received: by 2002:a2e:a103:0:b0:2cb:54a9:77d6 with SMTP id s3-20020a2ea103000000b002cb54a977d6mr4257722ljl.7.1702461272194;
        Wed, 13 Dec 2023 01:54:32 -0800 (PST)
Received: from [192.168.0.5] ([62.33.138.36])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e97d3000000b002c9f90021ebsm1785311ljj.29.2023.12.13.01.54.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 01:54:31 -0800 (PST)
Message-ID: <71f2b28b-3e27-4773-8408-2f4c13757b73@gmail.com>
Date: Wed, 13 Dec 2023 12:54:30 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Alexander Zhirov <azhirov1991@gmail.com>
Subject: Communication channel interruption
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

When cloning a repository from GitHub, I have a channel break, although 
the connection is stable. What could be the problem?

# git clone https://github.com/Thinstation/thinstation.git
Cloning into 'thinstation'...
remote: Enumerating objects: 79839, done.
remote: Counting objects: 100% (535/535), done.
remote: Compressing objects: 100% (319/319), done.
error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: 
CANCEL (err 8)
error: 7473 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output
