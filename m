Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC9747A
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+aTBYHy"
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE18876;
	Thu,  9 Nov 2023 23:59:37 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso23846091fa.0;
        Thu, 09 Nov 2023 23:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699603175; x=1700207975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZnd9rtJC7oJHra3183L8rdKMjFgCfCXavMi/0UQjRs=;
        b=c+aTBYHykuXy+k1C308dHt8by3KYzC8g2LTcO4jmgZLifFj9IItR0YHAb/JqlEBN82
         1M8DGtF27/DTtNxqX/D3dqxgWPv6NjBjEKD5EFSe2ywCwUEk2OepTdcFrOaqPpui3sKD
         z2A8yEjoNoZ7SrommVY/mRxcZxjjcFUlJUIuYplUS9vWtTm8hf6/pBoQuxj8G1dsKBG6
         o9r68dRJvkHoCJV9qBs/nHBv7QRRTAZ9d8iUl62H/onUURWa6Kz7b2QloZKnvRSzKNj/
         NLRpugHuKkMXC64c31ltbc8aaOQ+mDUUc93ID+zuWoOKL888oIj5BklokqChFBxX8KD+
         j+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699603175; x=1700207975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZnd9rtJC7oJHra3183L8rdKMjFgCfCXavMi/0UQjRs=;
        b=uSJJb6Pob2AtbLoT3lNKkgsMRXjq9ALztvo/SYkQoeG3iFDXpUEVsyYhKrjop/16c3
         tkrRWp7AtpW4DcBwZhdSzXHDj8Vq52PNdNxX7H9Qvui+54DzYrStfZun8vVk6nVzv7Qj
         YzPDI+hOAMRAaozdmCtEVw8GC5t2xM+edIy0ni4568KYdqptMDlAzbWMTD+k6yAvHbaI
         I4ZsVfn8M3k0pXb23UA2v+zYIs1NNDro+woLWEHgbdKBHzS8cDXQzgwObIO0A5Bc0TIp
         C2n08XYrMUsz3m3Pnkw8g/GuaZ3N5qXNJORZ0e52HOc0tQI+JKqKHXvUp3tkEqzbMEHZ
         eInw==
X-Gm-Message-State: AOJu0YxIFFNfhtit0W7Y1BKcW0kQHJGgVroaUteUKaONKgUcvVS85ppn
	blAj1IfzUSImkUnKOj0KTA8=
X-Google-Smtp-Source: AGHT+IEeHWucNEkLxmEMeIakdb20T0w5pWyuNG97VmaomXrUzYsF+fhxPoO6/Ef8KsHISaTLulRTtw==
X-Received: by 2002:a2e:8e21:0:b0:2c5:1900:47a4 with SMTP id r1-20020a2e8e21000000b002c5190047a4mr5347976ljk.0.1699603175065;
        Thu, 09 Nov 2023 23:59:35 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d4d51000000b0032f78feb826sm1343742wru.104.2023.11.09.23.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 23:59:34 -0800 (PST)
Message-ID: <8d5af6f6-3d4e-41bc-bc91-039db5628f26@gmail.com>
Date: Fri, 10 Nov 2023 07:59:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Git v2.43.0-rc1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 git-packagers@googlegroups.com
References: <xmqq8r785ev1.fsf@gitster.g>
Content-Language: en-GB
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqq8r785ev1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2023 17:33, Junio C Hamano wrote:
>   * "git log --format" has been taught the %(decorate) placeholder.

* "git log --format" has been taught the %(decorate) placeholder for
   customizing the symbols used in ref decorations.
?

Regards,
Andy
