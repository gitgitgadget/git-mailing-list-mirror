Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4691428D
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXd86nRu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c25973988so15779005e9.2
        for <git@vger.kernel.org>; Sat, 16 Dec 2023 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702721010; x=1703325810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQ6zGFBDGx/gL+m2EOzoMUyQXEd2i3TyVcpWQWsBPFE=;
        b=JXd86nRu1lwm7ec1Zr1NWCTWJLSXaSRd/HpKhRVXGrq/KkY7e6Ni7uC4sJHUa9ndjq
         3uDCbgPVzYefKJWV5BrLL6aX/1rVefDl2i2y0V95qrZDFj6i00IolkyQwCAXg3qRpfYu
         DDQFzzxZoVj8irXzIpaB4k9X3Y7nc7eOCgLS49EbJtxFPYg+cWfvK94yYDRvMEiLo8CE
         HHZ1t7xGzzv6X5yc8lQ5dS+Kri4MVaZF4/+MkNkZqhAkOuzaKhQj0/VpOHNzkMi+sQbK
         P5mQes5LF3mcevEwqpM9WiwjPjkG/0wNcFxn+4uoxaxrPaydlACoB9Q3gyrRw0eowVcl
         UCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702721010; x=1703325810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQ6zGFBDGx/gL+m2EOzoMUyQXEd2i3TyVcpWQWsBPFE=;
        b=wriYWnbThb4ZWsxfPE/Iy18P6s3HWdIlSVPxADq0RCG9+T2gzLTpqwubtw7ocFaQS8
         fe5s2OwKbmqbBilP/M3QDbf94+8zwtaISm5ikYQeUVx0FgX9gfLirh935bS4dKjArItA
         ZY62eNudUhRyhp4ssAjhqY3lXj/IrBm9D9bpmGybeK5cwVAnkydIgMrNKmIqZwwa95UC
         HDnqfEbvIE5XjY1we5GhLEPRNVRmc70qQT6v5QMAplGPtfeTltv09unqeoF3KennSBnT
         TLADPV5XjKZtiddH1tDsW/ZAp5jFFHUnE73vg2pevC20j+XCBCN2kQtoXrK5y3o8mjxM
         hchg==
X-Gm-Message-State: AOJu0YyzR3c6OMapL7TnYFyWXzjs5WF5URT2J/L3+mJVkMichrBOLw7I
	2MSODIK39Jdw+aGkXBsWG55131xkyMM=
X-Google-Smtp-Source: AGHT+IHHzqjWtsn8CqXvYNVj/KMLlF/hGRVz7v/yeJnXRipYpvqIWtQAoESUqf/EFZFyNQJvIUDjOg==
X-Received: by 2002:a05:600c:2d52:b0:40c:2e1c:8f93 with SMTP id a18-20020a05600c2d5200b0040c2e1c8f93mr6350736wmg.179.1702721009530;
        Sat, 16 Dec 2023 02:03:29 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d504c000000b003333521a1cesm8978224wrt.57.2023.12.16.02.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 02:03:28 -0800 (PST)
Message-ID: <1bcd61c3-567f-4b3d-aaee-d29a6091a28d@gmail.com>
Date: Sat, 16 Dec 2023 10:03:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] refs.h: HEAD is not that special
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <20231215203245.3622299-4-gitster@pobox.com>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <20231215203245.3622299-4-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/12/2023 20:32, Junio C Hamano wrote:
> In-code comment explains pseudorefs but used a wrong nomenclature
> "special ref".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   refs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/refs.h b/refs.h
> index 23211a5ea1..ff113bb12a 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -56,7 +56,7 @@ struct worktree;
>    * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
>    * directory and do not consist of all caps and underscores cannot be
>    * resolved. The function returns NULL for such ref names.
> - * Caps and underscores refers to the special refs, such as HEAD,
> + * Caps and underscores refers to the pseudorefs, such as HEAD,
>    * FETCH_HEAD and friends, that all live outside of the refs/ directory.
>    */
>   #define RESOLVE_REF_READING 0x01

gitglossary thinks that HEAD is not a pseudoref:

"Pseudorefs are a class of files under $GIT_DIR which behave like refs 
for the purposes of rev-parse, but which are treated specially by git. 
Pseudorefs both have names that are all-caps, and always start with a 
line consisting of a SHA‐1 followed by whitespace. So, HEAD is not a 
pseudoref, because it is sometimes a symbolic ref."

(Also, the "sometimes" there actually is "whenever you're on a branch", 
which is most of the time for most people.)

Regards,
Andy
