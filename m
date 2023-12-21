Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1333539E5
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/4yE2/Z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c31f18274so11268225e9.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 07:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703171400; x=1703776200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zxKvooJkrfE+5GzKgfVL4XgMGWqrWWKBJ/1WU6MYhlI=;
        b=C/4yE2/ZMS16M1doSQpis8FDOkasHqtvjL+mDT4An7lXGhdPHYf/vNZMaXOmBdccxH
         9wMdI9LNRN2p0GW4/9iGFjLI9vC+8oBaVfZvdz/4JOXDRr+JfJ8Lqica2Vzfdshf2O2G
         tBUmic/+OUDx0GGd0t/YUbFQpbnNvhd6RWnHzq84XCjPiB3VkoczqXE3NIo6CwYg7kED
         5l7hSMnHyru+gpj57Omixhwhnp3Q+qWnpfQRkkyOa4gv0vkpqHxKXH+EZP/ojhEKga+g
         BVU2AevpLXd4WGlKK8A2ob/qrR2xnl/AH7X7ZzaITIw/gWXrprHjIOD0pMwp8VcvEXrA
         vf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703171400; x=1703776200;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxKvooJkrfE+5GzKgfVL4XgMGWqrWWKBJ/1WU6MYhlI=;
        b=F5GZD94wA4CSa3niPSDwLCsP1Hlu97tQRJRRrgXqKNrgwPqO5+0ZD3k6ZQsQ2ebxJS
         F7oXvQsn+LW+gI9pKVCkkU8lVBuFUgdnlGcvVy9qcHe3ZiWITpHRvZpsJDFY+ZcHElQS
         5oOX24dISXzqenc950cSmbNaaUS47FgCA8JXp91jPVzmizRP17DDMtpgWnQ/BrDR69XO
         smJtLoXZs8XCvHMa5tU7b2v+DU05HmeOfzZo7hif+wbatVRTwaOzK0YYvALJqTN4bRtF
         r0rkgkwoA8wDra5EQdBU5rVIVN7qc9YuOQNdAH1qhNfrw2od3KnJhbX1wcLH3/txSZmp
         3CfQ==
X-Gm-Message-State: AOJu0YypzdejTMxkKV27yNPhn5UpAmDeV99hao1yxAxwAZw9u2NvXDMJ
	gophBZP5uuYqMnnhLsWkbhqQYu29dE8=
X-Google-Smtp-Source: AGHT+IH0M6dBFVC/GeEoZzLBt2FBmpGLKk/6vc3DmzXEqL5d8XLEV0pl7e0NVyU7mMrmtqcWDiZr4w==
X-Received: by 2002:a7b:c8d0:0:b0:40d:3dc8:8221 with SMTP id f16-20020a7bc8d0000000b0040d3dc88221mr548074wml.37.1703171399798;
        Thu, 21 Dec 2023 07:09:59 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c1d8200b0040596352951sm12116047wms.5.2023.12.21.07.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 07:09:59 -0800 (PST)
Message-ID: <e4b6eda6-8d20-48b3-a33d-13ee07d227ce@gmail.com>
Date: Thu, 21 Dec 2023 15:09:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/8] SubmittingPatches: update extra tags list
Content-Language: en-US
To: Josh Soref <jsoref@gmail.com>, Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
 <35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com>
 <CABPp-BH_iP2KjPi-5kW8ROQWfy8XoUmbGhyT-Y1dZGtCtZXQGQ@mail.gmail.com>
 <CACZqfqAiSpGP5ABN7MZ50Za=-vAEKnqE0ravzEMbLJCByfRd8w@mail.gmail.com>
 <CABPp-BFjotLN4sCe+6uHAU7qhr1COM0B4EdW0f0-X-xf5qXinA@mail.gmail.com>
 <CACZqfqCar=tay5diocU7jVWBwPUFqewNYfPLHkYvvR1fSBSdPA@mail.gmail.com>
In-Reply-To: <CACZqfqCar=tay5diocU7jVWBwPUFqewNYfPLHkYvvR1fSBSdPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 20/12/2023 17:42, Josh Soref wrote:
>      SubmittingPatches: discourage new trailers
> 
>      There seems to be consensus amongst the core Git community on a working
>      set of common trailers, and there are non-trivial costs to people
>      inventing new trailers (research to discover what they mean/how they
>      differ from existing trailers) such that inventing new ones is generally
>      unwarranted and not something to be recommended to new contributors.
> 
>      Suggested-by: Elijah Newren <newren@gmail.com>
>      Signed-off-by: Josh Soref <jsoref@gmail.com>
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 32e9023877..58dfe40504 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -358,4 +358,5 @@ If you like, you can put extra tags at the end:
> 
> -You can also create your own tag or use one that's in common usage
> -such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
> +While you can also create your own trailer if the situation warrants it, we
> +encourage you to instead use one of the common trailers in this project
> +highlighted above.

Thanks for this, it looks good and would be a useful addition to v2 of 
your patch series.

Best Wishes

Phillip

