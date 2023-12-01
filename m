Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jguk.org header.i=@jguk.org header.b="e3Svwa3T"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF21B4
	for <git@vger.kernel.org>; Fri,  1 Dec 2023 03:57:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso20217775e9.0
        for <git@vger.kernel.org>; Fri, 01 Dec 2023 03:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google; t=1701431863; x=1702036663; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlO7I5F27fUBohRQUg3w3V0unyf3SPNXtVsjI1CTDFw=;
        b=e3Svwa3TlwiNkZ61nmF/hPqe2ifLA6bR7Sbg3FsgQzSde7kkjRJK35cPagLpR9Aa92
         i6EjftEluNZpTcQqNt+KnJ4bphB+RpVCDJ0JIBCOCCeA+sYQ/jvB3SgNG0n8bDEVbw2n
         JoRqfdlEAcnOCB6cw5MJq0NmCdSLmLCnU2sfIrISSuU7QgstVapbnZO4+6hsDbcE89Az
         6GIiYlDUdbPBg5UlsOYywNQ6umhbL+5wlOgayPk7pHAKt9tmSyrk2xy6QcoRJwlyhXjL
         SVvnMda8gaLcyAMr8uN+YtHvSdLH3J6bGtOOu6faDxF/AcqXXXr0GtJP/7y2f4dSsOYz
         w6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701431863; x=1702036663;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jlO7I5F27fUBohRQUg3w3V0unyf3SPNXtVsjI1CTDFw=;
        b=lXbHQdcCWFsuubFw0BanOM921R8uHJrcilVLBJ9IEQxaurGIyxjt4PQeqpasTaJ7n1
         DI350GKrVX9pXjGbSyOs+/3tPHIFP1W3jOdAVuzE7q1n4YOcvOzTePNgmiTl0kSJAPnz
         BLQtOz0boWdqj0Mt+mskAFkA8K+uX2V8F+VcVO1pn+AEevREQXXZMpG763gAVVs1AQEa
         Tdmoy79+7h6sjC6qBha0zgrUDTmMqFXU8m8qPSVeh3KM+XWASqBsLXv4Lihw0rjGnuwa
         6YifJ48hjvq+eZQcp1hqSCpstEV8koUd5YE1D3UEjphT+0j7rzF6f8MFAQ+NVWoIvF+Q
         V+tA==
X-Gm-Message-State: AOJu0Yzk51dbTYmDFQDY3kQDUoL/GgX1vsHNOG6GTnwADumq081ThA0x
	jc/wXn7M9dzi9J7Jwqq0q44priE7VwYRdpyaBZo=
X-Google-Smtp-Source: AGHT+IFWbokzsIcvrdyCoMyo9tXr4kGLWDIzLjNXAGTe54Ft53y6JMB653hjSKI+wM7RUNiTy6hLnw==
X-Received: by 2002:a05:600c:4fd2:b0:40b:5e56:7b47 with SMTP id o18-20020a05600c4fd200b0040b5e567b47mr617959wmq.144.1701431863458;
        Fri, 01 Dec 2023 03:57:43 -0800 (PST)
Received: from [192.168.0.12] (cpc87345-slou4-2-0-cust172.17-4.cable.virginm.net. [81.101.252.173])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b004083729fc14sm8887667wmg.20.2023.12.01.03.57.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 03:57:43 -0800 (PST)
Message-ID: <b6e0f49a-34ff-4e8e-9c3e-b8fd41d59f68@jguk.org>
Date: Fri, 1 Dec 2023 11:57:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: git@vger.kernel.org
From: Jonny Grant <jg@jguk.org>
Subject: git:// warn as connection not secure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello
May I ask if anyone has suggested adding a default warning that git:// is not a secure connection?

ie "warning: git:// is not a secure connection. https and ssh are secure."

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
Cloning into 'linux'...
remote: Enumerating objects: 9863119, done.
remote: Counting objects: 100% (2360/2360), done.
remote: Compressing objects: 100% (1282/1282), done.
^Cceiving objects:   0% (8779/9863119), 3.21 MiB | 6.41 MiB/s

Kind regards
Jonny
