Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092BDDDE
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTmim/f0"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC3D41
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 03:31:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d9b507b00so1231563f8f.1
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697884283; x=1698489083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pPb20Ti5GevMk8srIozy6Bpkx0z32pKFg0+v3rTvYo=;
        b=WTmim/f0E6sfN/PSCsH6+EMa6AkUOXf5oPb67ERQCXcqL2rFuA1Jd3fGQCoyG53hft
         3Odu0AgGJ9mAl+wbjHPD6RtM23998/lqNYRcQRduuHP0t3tzH1xMFoeNh0/t7vxGZS9i
         DO6W4ms4ryjLqjHhjH5dwnuQzB2K7XQJQJmxQnCz4snLlwemrCCwGc3vrdxUWRHwGyrD
         gi8vn17fK0jSMtsTpIsR49ypKLLOYf7or4KVmy2dhGz+BLQQCytn4hJDZlZpvzMQQE1g
         7umyJJcc0GaxW6bC7zj59Q1Ct2GaKqxAJgGSe4MUNnNqoe59SXm7SOodFE0MTZFIitEX
         upuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697884283; x=1698489083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pPb20Ti5GevMk8srIozy6Bpkx0z32pKFg0+v3rTvYo=;
        b=VbSu5SEPfiqlIIzfkeQmMmJBOutDcW2rfsDNX4vE8cXiWHiZ0ljHX+pV5xFzBaaYTn
         FmpCJXz10u32fMRwo18IEJCtL2JlbyWBmKhfCNqpDtQ2X5If5X7gyLLH8dxclLfR5EMI
         /mN+6zNUiCwKAitCjFdGkngsYvqGdG6n0XH2YWaR2cTbGPrLnGMvYKOheVlYPVF4wwBq
         ba+9M5D7eu3N+ZNoN+fPYcyKpot9MifKnI7pa3H3+X1BQ3oHoI2REyX/NJv7lyn26NRA
         iu3S7bBNxkVU/uvTghaVMbVzSPmdBwMZ37go7cp6xCWr/+tVIBdOLFplfVLkf5D6lpcJ
         Sb/Q==
X-Gm-Message-State: AOJu0Yx/9C2C+FVAI7WdjVUFLbqqS3mL3jsiTsVYkvJ0Uyf7RY0seJ1r
	gcGZinyb8p2v/IhpJJ7Xsn0=
X-Google-Smtp-Source: AGHT+IEAJOJFFC9nzGkRCeyHTaOixtC0PxWE5Y7pO+dVpaFUkkooHtV4wBi2omlfxcct1zFLyV6VUg==
X-Received: by 2002:adf:e584:0:b0:32d:9a26:4d57 with SMTP id l4-20020adfe584000000b0032d9a264d57mr3499272wrm.20.1697884282615;
        Sat, 21 Oct 2023 03:31:22 -0700 (PDT)
Received: from [192.168.2.52] (150.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.150])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d60d2000000b003248a490e3asm3434290wrt.39.2023.10.21.03.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 03:31:22 -0700 (PDT)
Message-ID: <6996af48-4998-4370-813a-6c72a9ffb1b4@gmail.com>
Date: Sat, 21 Oct 2023 12:31:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] builtin/branch.c: adjust error messages to coding
 guidelines
To: Junio C Hamano <gitster@pobox.com>
Cc: Isoken June Ibizugbe <isokenjune@gmail.com>, git@vger.kernel.org,
 christian.couder@gmail.com
References: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
 <20231019084052.567922-1-isokenjune@gmail.com>
 <331e1ab3-2e8c-497d-a05d-ef197d664188@gmail.com> <xmqqwmvhqjyx.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqwmvhqjyx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20-oct-2023 10:31:18, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > On 19-oct-2023 09:40:51, Isoken June Ibizugbe wrote:
> >
> >> As per the CodingGuidelines document, it is recommended that a single-line
> >> message provided to error messages such as die(), error() and warning(),
> >
> > This is confusing; some multi-line messages are fixed in this series.

What I expected to see is a re-roll with no mention about
single/multi-line.

> >> should start with a lowercase letter and should not end with a period.
> >> Also this patch fixes the tests broken by the changes.
> 
> "Also this patch fixes the tests broken by the changes" -> "Adjust
> tests to match updated messages".

That is a more palatable description of why the tests are being touched
in this series.  Thanks.
