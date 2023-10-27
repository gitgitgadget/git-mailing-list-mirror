Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACD1EB21
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEZYZYP2"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EE0D57
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:17:06 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so14166486d6.0
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698412624; x=1699017424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tS6x3+qPKmQMaGrpZOSpyxloqGuWbuy/ho1ezvFNwAE=;
        b=BEZYZYP2UCfz1g/20eMISgeubAFpsOz+HxEwRLvTIVDpyNK2SGpvV24mZepCf2H5/q
         35PrkmW/L1Fxi3LzQFf4XPqPIkzue9YWw7mQd5HgyDXTnMcnUMu2yxYsEelTgAZUqtPs
         PG7kD6CJg2+tfa6p/PONO/FNZeFHrBwJ4g1ePkFeB/kJCM10wy3HkCEeSq8ErzT6kAl+
         nA919Cqq5+uhi03AJn0gu5mdv7Oeiwp2uhUzHhzcOExLy4kRF1NE23U2ChleZYhqMaBM
         fxz1z2vOVEY38Tfhco6JCrE++4mW9etT1TJOPLcddy/oZyP+2tpMH8X2SBwcE43WOvwU
         m1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412624; x=1699017424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tS6x3+qPKmQMaGrpZOSpyxloqGuWbuy/ho1ezvFNwAE=;
        b=fVyCPdFMqmTwAcSY5em1sZsgmnUIRjqzNlxET5cSJCDVpFl5luv9Vsgn2jNW74NQwX
         WW3erkqYZlPtlsbd5k3tum0rD9kmH5TsbBxf5hEQQ5+cPO6zRpIMeb5MesBXbnFuRd2X
         PEUI9lzZYw1KMGxN7rVJKKKtLN+z9EoltQYX6JwwVeVgKhqYrIHVDVLVO9Mj3otWsk9d
         KdDXvBHJrq8znYIENL5Hw7Xsr9Dnmxtz5/ubGPkKw+NBQzlDwVXbv1UGBQMjpfoyL+3y
         MZkJLVxKFWWYw8+A0DFGtaLs2MC03BeivtUz0qtHaHNdLt6/MbWa5iGX5DeCMogv8bpz
         Zuww==
X-Gm-Message-State: AOJu0Yx02wXN4wtq3vH4Zha9JIETRo1MHSvGG0QNyYgd5qYs6vX5ns5j
	qBR+nq0PuyCJJzwvvZq2xYU=
X-Google-Smtp-Source: AGHT+IHdSfba0hLEr0uf6mBz04GLZ4PS3zEXrPSzCYi8Yl4ofVbqnJ7rTkfjQ5eZOzZlSdkPO1CbGA==
X-Received: by 2002:a05:6214:c65:b0:66d:43be:7e45 with SMTP id t5-20020a0562140c6500b0066d43be7e45mr2793381qvj.43.1698412624428;
        Fri, 27 Oct 2023 06:17:04 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id mi2-20020a056214558200b0066d15e2b73fsm581245qvb.145.2023.10.27.06.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 06:17:04 -0700 (PDT)
Message-ID: <d00b02e9-fb05-44bc-90ee-1851ef98dd26@gmail.com>
Date: Fri, 27 Oct 2023 14:17:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <cover.1698305961.git.ps@pks.im> <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <ZTuYjzOfG0y27Sho@ugly>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZTuYjzOfG0y27Sho@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/2023 12:01, Oswald Buddenhagen wrote:
> On Fri, Oct 27, 2023 at 11:25:41AM +0200, Patrick Steinhardt wrote:
>> +    export GIT_PROVE_OPTS="--timer --jobs $(nproc)"
>> +    export GIT_TEST_OPTS="--verbose-log -x"
>>
> fwiw (as this is again only copied), export with assignment is a 
> bash-ism

Not according to 
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#export

     SYNOPSIS

         export name[=word]...

     DESCRIPTION

         The shell shall give the export attribute to the variables
         corresponding to the specified names, which shall cause them
         to be in the environment of subsequently executed commands. If
         the name of a variable is followed by = word, then the value
         of that variable shall be set to word.

It is true that in our test suite we separate a variable assignment when 
exporting. Presumably that is because someone reported that their shell 
did not support the "export name=WORD" syntax in the past. As we're 
already using this syntax with the same docker images in Github Actions 
I think we can assume it is safe here.

Best Wishes

Phillip
