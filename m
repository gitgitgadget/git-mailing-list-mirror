Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7A3C13
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7ApNl90"
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0493BC
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 03:15:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so1994777f8f.0
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698574505; x=1699179305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NtWrJ9YYvqIntREhHko4QahlkXKuJlJ6ITfu2fPiKxE=;
        b=W7ApNl90fDehSHt3nxoyFvJHsmLFQWrJlPYEK0jaJEsscgI7vzVql22bt2Gdi+gjFH
         chHF4ewMGjNvPQeA51JpP3cb5sxpjZ63JtCD6OEkVufn+DP3K+QyhtILwrXXGrC1u5l/
         uH2oXh/Y82yH95qplZV6YirKfIRl8WRtN7lS/3X1ficsWBsZVoZw8GvD5m6rD2jNNv2w
         +VNsxUQOMhvc1fxUmIwYKjOzEIWjkwjg67s5Ie7twKb4NkhLLXqSKVFZa3WAQ9VvlE9p
         OPy8T4ZkjpLfYsX+AMH4PNFf5f9nC3ftcHJ0mEgtAaj6WutO7hz22cpQtAkkxyFCCVXD
         kaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698574505; x=1699179305;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtWrJ9YYvqIntREhHko4QahlkXKuJlJ6ITfu2fPiKxE=;
        b=UTE80womXz+r1vAOIpdfMtmEeT5SKhuoTod+200mcopBgA3grkStg4nZSVL1mLn3p5
         rcH1cPxHxod1rAMNAqNRQY0ugk5KBNEWBn60ikm8aGB9BawYX0Wpa6eQ8RfstPadH7XI
         0nrd/xVr+WrFkuFntIDjNerMwu+ETpfgmeL1KeCo9crK9tSqIRmGUag1syDDl4PJbVut
         xInX8oReFyPb44ZwVzGW2jBqlMCUuYWg114QkIEdcC+oqrMoOi7V87Xo60l9aTVda/E9
         B7m4h1YVhJbnhMFjlYfEJkGVoToA4g+5K/RFl/IOmv5+8EFSv+FDAhEFehmtwh3a5esz
         /1Qg==
X-Gm-Message-State: AOJu0Yxskh7JQ5+oe/YkZVTqXDqFce4hvvsadYZtN/4PlRZQW6W7c68h
	HV04esWCsJObAKtKT+Azv+o=
X-Google-Smtp-Source: AGHT+IFBDkpTydb9k0WsOOoSWKcs+oind6jvjww2rp9WwMoecckvFmIOj9KEdRryyGQ2dLC5Ws5rEg==
X-Received: by 2002:a5d:6483:0:b0:32f:87e8:707d with SMTP id o3-20020a5d6483000000b0032f87e8707dmr564628wri.5.1698574504782;
        Sun, 29 Oct 2023 03:15:04 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b00403b63e87f2sm6251344wmq.32.2023.10.29.03.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 03:15:04 -0700 (PDT)
Message-ID: <80c6b0d9-7d6c-4a1c-ba2e-330786b13cf0@gmail.com>
Date: Sun, 29 Oct 2023 10:15:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/1] Object ID support for git merge-file
Content-Language: en-US
To: Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <CABPp-BFJn5NsSaaxEMpicqND_-8CBw370kyBQuKHGOX-3PRyMw@mail.gmail.com>
In-Reply-To: <CABPp-BFJn5NsSaaxEMpicqND_-8CBw370kyBQuKHGOX-3PRyMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/10/2023 06:24, Elijah Newren wrote:
> On Tue, Oct 24, 2023 at 12:58 PM brian m. carlson
>> This is in use at
>> GitHub to produce conflict diffs when a merge fails, and it seems
>> generally useful, so I'm sending it here.
> 
> But...wouldn't you already have the conflicts generated when doing the
> merge and learning that it fails?  Why would you need to generate them
> again?

I was surprised by this as well, but as you say this seems like a 
useful addition independent of any specific use at GitHub.

Best Wishes

Phillip
