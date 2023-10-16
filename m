Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2A1C6B6
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX+08g+8"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7AF1
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:20:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40776b200e5so22431115e9.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697451644; x=1698056444; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcRqStFEKYMmhuHpUkQdg5Vq7X4wuYH42AkLT5+RIUk=;
        b=YX+08g+8lWRoKa+SqRNDG0BsX64D1IDHclY9K2kgvGICX1KYKlqKT5YmzUdaCoefeE
         /TlUIWB50IpKIgRLWI4cBXo7ksmTlhaKdKKueJ/EcYM/dPsya6xXWZnudFcT623wuGcB
         +CDJaU/0Z4Sd8BYGE1C4x9ZtXLy6Xr/nMmFz80j0+jLpl6KE5bBRaLjfATP33PZVaTNv
         y0hP/5jEJM0uQ2ywI1LOzzf+niSvRsD9WXLB5Gz9zRH7fJnF0ebfYK4QxKty96YxdcdN
         aSa8mg4H1DvUgA0YGefkObKSeJXRGmnlW5tDOoBLwAgdYRPDjw3/v/p5HJqzHPY30VKr
         nxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451644; x=1698056444;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcRqStFEKYMmhuHpUkQdg5Vq7X4wuYH42AkLT5+RIUk=;
        b=ZYOO5e36X/qswQeNAGvzNyOHeF86mNoCohe8MaecFOS03JD5aEr+YjVYgt+y7eWOSu
         8IPVHaUg7LEgH6qOdvwTi+Ps1lD2+Vx17JJs1vM0yCFCfzLvGra57Z+J7duOiG0jRjqX
         9tvcbGwvDeWkd+ZvxexLWLXeZwdz+tgWjW93kfHOWeEJ7IeXF/jS2krjlwT54MWz6z79
         VD32+4ae3INQOuEzmmraGFfavmBjO9jh+pWoK/bpUUkMJEBgka5oe/b4cRPtIIXnmdvb
         d+CF8MPDNyxbT7PM0tXJ6SYyBrM41rQTgxheMgmkgQwLva4inMxYBL2/OpUZrikI+x/1
         5RFg==
X-Gm-Message-State: AOJu0YyIN1fqV9xROHyfXqw9+DmAytLFouAUTxaK+XuL7XpkEcNRg764
	F7YT0s0v/1rq9mj0g3qpYEsIA57ccPM=
X-Google-Smtp-Source: AGHT+IGYFjos3thub3gmC4+Nk5cyjT9kS1YgZmdCnAy1MDBvJDAWboSOW+7S35BhXJF/uC24qmQcWg==
X-Received: by 2002:a05:600c:2197:b0:405:514d:eb0e with SMTP id e23-20020a05600c219700b00405514deb0emr29219021wme.19.1697451643512;
        Mon, 16 Oct 2023 03:20:43 -0700 (PDT)
Received: from ?IPV6:2a0d:6fc2:4043:b200:fa69:5356:d4d6:9391? ([2a0d:6fc2:4043:b200:fa69:5356:d4d6:9391])
        by smtp.gmail.com with ESMTPSA id az23-20020a05600c601700b00406447b798bsm6806827wmb.37.2023.10.16.03.20.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 03:20:42 -0700 (PDT)
Message-ID: <75545e1c-ce62-4b49-983e-1e7b1afb2fab@gmail.com>
Date: Mon, 16 Oct 2023 13:20:41 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Victor Porton <porton.victor@gmail.com>
Subject: git log --patch for a particular file
Autocrypt: addr=porton.victor@gmail.com; keydata=
 xjMEZOOrBhYJKwYBBAHaRw8BAQdA+hStwyhZdwm4hT+azNakoYWDX9HxrZHyIiWEnL6Dcz/N
 J1ZpY3RvciBQb3J0b24gPHBvcnRvbi52aWN0b3JAZ21haWwuY29tPsKJBBMWCAAxFiEETzWE
 FkGWX07H657ywr523wwCDrYFAmTjqwYCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDCvnbfDAIO
 thNnAP4iVDlJffm/rF+1VzXZQvkXX7dq/09Onpn97vmLd34oCwEA1ia66qtessxOTqW3pFTp
 fcXUF5iE2t5uY3DCFsZmUQrOOARk46sHEgorBgEEAZdVAQUBAQdA0H6hs3jIOz01tcCCrvyo
 FgZ/FXAAvFsjDgU6/ut6K3MDAQgHwngEGBYIACAWIQRPNYQWQZZfTsfrnvLCvnbfDAIOtgUC
 ZOOrBwIbDAAKCRDCvnbfDAIOtiA0AP48A0g4+DUzzMY8gs0rfrrosFeDOwQy/9vpuC7gZbmu
 5QEAw/BykABCY/LkxC3PVqyYBZJKqfDx+wgAFHO5s1YKkgM=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I want this:

git log --patch -- server/src/api/docs.py

to print changes only for the file server/src/api/docs.py.

Currently, it in some reasons outputs nothing (this seems not to be an 
intended behavior and could be counted as a bug).

More generally,
git log --patch -- A B C
could log changes in files A, B, C (only).

It is questionable, whether to output commit information (commit hash, 
user email, etc.) for commits that don't change specified file(s). I 
would vote to indeed output this information, not to confuse the user 
about the order of commits.
