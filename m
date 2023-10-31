Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9219BA5
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGmOqnew"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B466DF
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:05:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c5056059e0so79316311fa.3
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698750313; x=1699355113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rVDNUYzPNARUUf6jOr9XPnDPcPmj7laIUxvLnPo83WM=;
        b=kGmOqnewebRz9SB8LKuGc1//KFdFFwa0Kz4/MidJLKLnsV4oMDU5qzuyNu4YiBbnFK
         VMzHq91Ayfw18lLLj/YXVsuKRh++t6qdgtk18DvowIfT+kkObuE0l1+qX7izhnhafFXG
         lbQBlDtThXhCJTjR3SLmoP+HGXQM0pPgulM+/UrmpukL0d/lhvGxRKxxbBHHSBxXf6ak
         KSkwqipY6+bJ0aI9O96C+FxJxXjuiGrAK/sUg3+VCAV78yV9jXKAhzprzIAdPi5zRqrw
         wRh+kgYqYgqTMWSuvd+Fy3vgf8033lQOSd22zv74w9LevTXGqoBC1edRHiV9gSHJn99D
         n6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698750313; x=1699355113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVDNUYzPNARUUf6jOr9XPnDPcPmj7laIUxvLnPo83WM=;
        b=aNCTL/HLQQm1IAINUGvgs8yRR/guFYSfdoDaRfFQIbVak+QIEBsCYlNgtdy9Mc3EEl
         cMwE+SAEWdd27EENamoKgCXjIdUETlOQtbFOk6ebGtB6roG9M0a6I7s9etxgFudzMetr
         wO2YlQt7oGIEdjSUaYVZSaCBDdxWuabGfqJguKUb2JGmnNAPHJFGptuXMrpHJAfAZeiu
         FeFfD7M2f7wUGPU7nPm3+L71zlYd8WC3Zjv8MTqYgklH6rDj1+xZcJxBeFADfMqWdvOW
         4jhaqHJJfFuIPBPSMo+kqZz4JuC5xAQ/up4Ht+YnEYvGGqtD5RkDNqAP702opkPc1LwO
         BoQQ==
X-Gm-Message-State: AOJu0YwALEnBS1Ou2Hg9ugBGCxAPeKuPFq1waoq6o8tMIpdKrpMgUJxJ
	PKetvt+A5emh69ExYo6rfnk=
X-Google-Smtp-Source: AGHT+IHxYpvcwHmW0MKjUcEuZJ2OXBeGAKkYx168ubTAmKytWmBfU/2OTrPuPPudso9IORytfI52og==
X-Received: by 2002:a05:651c:b20:b0:2c0:17bc:124e with SMTP id b32-20020a05651c0b2000b002c017bc124emr10869868ljr.38.1698750313182;
        Tue, 31 Oct 2023 04:05:13 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id k19-20020a05600c0b5300b0040773c69fc0sm1422089wmr.11.2023.10.31.04.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:05:12 -0700 (PDT)
Message-ID: <6a8f3a6c-c3b0-4aff-ab36-be980ec6bbe0@gmail.com>
Date: Tue, 31 Oct 2023 11:05:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/1] Object ID support for git merge-file
Content-Language: en-US
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Taylor Blau <me@ttaylorr.com>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231030162658.567523-1-sandals@crustytoothpaste.net>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231030162658.567523-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

Thanks for the re-roll, this version looks good to me

Phillip

On 30/10/2023 16:26, brian m. carlson wrote:
> This series introduces an --object-id option to git merge-file such
> that, instead of reading and writing from files on the system, it reads
> from and writes to the object store using blobs.
> 
> Changes from v1:
> * Improve error handling
> * Re-add `-p` argument for documentation
> 
> brian m. carlson (1):
>    merge-file: add an option to process object IDs
> 
>   Documentation/git-merge-file.txt | 20 +++++++++++
>   builtin/merge-file.c             | 62 +++++++++++++++++++++++---------
>   t/t6403-merge-file.sh            | 58 ++++++++++++++++++++++++++++++
>   3 files changed, 124 insertions(+), 16 deletions(-)
> 
> 

