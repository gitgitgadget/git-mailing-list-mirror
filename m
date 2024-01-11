Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507DB50248
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W00WLReM"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so63856301fa.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704990838; x=1705595638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K7WQ8UTatwJjQDeWcWUVi138g1yqTonG8L2QoM91Xao=;
        b=W00WLReM0CM+OfOVjFuHoCdo7Cm5zzfpjHc/qUTfIdSv8ToU4vYZRQmN82ZKKqMo3U
         PnvFIXazSgyp5uupoLD3ADqhCL2BwWA1JfAgsAqQ8W1Wdzye/QoK8P+M5lDLSMMS2D4S
         m8v4tYydYf7cg/jl8T3SYZY6E/xaEsw2kiGgT1tLx+e3ag8dYRl3ytzKlCoV4sYVctUi
         syWZ0xnaX9D2+F4Rr5eoXI+8jO1ufOSOe6vGTVfjo+qag8TlPCWqt47IFf0q5fLvHd+m
         t9XKGzgTfuOJLmZaamVTMBDqA/EKuwRNgJQ8jCosI4J3nCgriT6J3c+Z/ZGHzfFc/n/k
         MJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990838; x=1705595638;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7WQ8UTatwJjQDeWcWUVi138g1yqTonG8L2QoM91Xao=;
        b=hWWDg2u8k+l2iA9oP5upUbol5+RPQEmzGmQFFrQAcbMHe1wgVHZZOA1UJje6sLfQ21
         8sMUatjDOGKuNjUaXtZkhekAoSQGiBbPW5CZ61LPiXVDD5p4kn/1lJiH73hhWfSKt4ep
         4QkDe6JZr01HgIp16Fe9zYtf87pAOALDEksV6nxMJTGOeYkWIZ8qcA8V1EjzMXSVFcD/
         mxoqktdCdMYiGiLN3R6NmeU6I8VbMpwM+IEn3d6g5mIc8uIvY7f1NhPP1VhUXmKjfGnP
         ciKTalrjvXAfn7aEWLS9OLA9fSjTgLvHOgpRD38+UmhRaDIJkVCFimOKC0XijGpKMgol
         BptA==
X-Gm-Message-State: AOJu0YxprG6XNj/QQqYaq9cRf5yA+/1ejtL6/Ee+pkuR4+YemMaLFfX3
	vNikg6ZhfYTdnSsuPUIbhBA=
X-Google-Smtp-Source: AGHT+IFyODPXPsNCzvfm87cVx1CFm7a2kC82NNPRjhazBmiviqyO8jPuW4e/NH4H5lZSsMDvEZjqGA==
X-Received: by 2002:a2e:b526:0:b0:2cc:db17:64af with SMTP id z6-20020a2eb526000000b002ccdb1764afmr520562ljm.93.1704990838090;
        Thu, 11 Jan 2024 08:33:58 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id f18-20020adffcd2000000b0033642a9a1eesm1585769wrs.21.2024.01.11.08.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:33:57 -0800 (PST)
Message-ID: <ba8824a3-caa9-4de2-bb80-3e592ec62b92@gmail.com>
Date: Thu, 11 Jan 2024 16:33:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] t7501: add tests for --include and --only
Content-Language: en-US
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, gitster@pobox.com
References: <20240109165304.8027-2-shyamthakkar001@gmail.com>
 <20240110163622.51182-4-shyamthakkar001@gmail.com>
In-Reply-To: <20240110163622.51182-4-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2024 16:35, Ghanshyam Thakkar wrote:

I don't have much to add to what Junio said, I've just left one comment 
below

> +test_expect_success '--only excludes staged changes' '
> +	echo content >file &&
> +	echo content >baz &&
> +	git add baz &&
> +	git commit --only -m "file" file &&
> +
> +	git diff --name-only >actual &&
> +	test_must_be_empty actual &&
> +	git diff --name-only --staged >actual &&
> +	test_grep "baz" actual

using test_grep feels a bit weak here, I think it would be better to use 
test_cmp to ensure that there are no other staged changes.

Best Wishes

Phillip
