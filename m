Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jguk.org header.i=@jguk.org header.b="BbE1/jdi"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E83B181
	for <git@vger.kernel.org>; Tue,  5 Dec 2023 12:42:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c09ba723eso33759595e9.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2023 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google; t=1701808924; x=1702413724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h44yEIy7w5d3GZ64d/D9TVd6KMiJ3RQh1MiBgFtVlj0=;
        b=BbE1/jdiYf+QnCo4jDvJgGsesiXlqpPFJGyBez826YnFmLZW5CmoEn9x74kzwpYkpv
         PTLiyuKXS+ifO9Ifn4veL3rPziGmYxSB9AvWJcR0E/HV+9HH6rLdVTYC9/HdgsFLHoxt
         pkWYR5+u72elxsPK4ekTZ8ja3O/CEgji8X8lbI45ysQHwESKt0IA01/AjgF41fAeB17i
         1Zrr/0IHGMWoYZ5jrxwoSH4crFTErKwFxVkMHhYI1gAiNXptKLUU+CbrFVJ8sAn6Q6yR
         W1cgNyCZUVjRotSJgFCzchFa5z1Kbwavk70PszMQYoz7fmN5ahM6u5vJkg/mafRhzq6B
         77XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701808924; x=1702413724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h44yEIy7w5d3GZ64d/D9TVd6KMiJ3RQh1MiBgFtVlj0=;
        b=oKQ7kmfW0ljnnIbi+tZXpjfdpXX1t1vh7Kkd5kKbhgtALWVB5GwGfcWEBbH3eaqewO
         G01/WhT/6IUfmvJueAuQejtub8BxdZZqht51/o4bhVQppo+bo/L2DE4Kz2NruXNzvLCR
         Ern/B/YhRidFeknT1NOQXFuWANDwkLD+D2FgzMJLye4nZl9iKr2X3i3mOgC1MlmQC0UM
         Hj0gT0vJdwFq2y87OOTMMELtxsul0pgjf4rslD0d20xUQCcxFNuIXcabosoACS+kFg14
         zynP68Z+3ksRXvtpjOaUnj5maGjvNcoQlOyhsWEzQbg3NWfIN2TU5112nHczqjR5Apym
         AtfA==
X-Gm-Message-State: AOJu0YxlNlt8FrScJVIkGFMEW4XnrhxXSYrO99IXIG3uNq27LhYCQMXa
	J4xjOWezrXv8Br4QnC5EQq2KSVhuDR+E/QbtSxk=
X-Google-Smtp-Source: AGHT+IExBWBDy7kkYBRUfyhgwEyq0Qdb9EPOX4JWTSxvgcVJtYDkgjwC+ice5fXnt4FDu0xmHWmoMQ==
X-Received: by 2002:a05:600c:35d2:b0:40b:5e21:bdb9 with SMTP id r18-20020a05600c35d200b0040b5e21bdb9mr792680wmq.72.1701808923828;
        Tue, 05 Dec 2023 12:42:03 -0800 (PST)
Received: from [192.168.0.12] (cpc87345-slou4-2-0-cust172.17-4.cable.virginm.net. [81.101.252.173])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0040c0902dc22sm10266563wmo.31.2023.12.05.12.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 12:42:03 -0800 (PST)
Message-ID: <ac8cf97f-53eb-43df-b95e-2d05753bf056@jguk.org>
Date: Tue, 5 Dec 2023 20:42:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git:// warn as connection not secure
Content-Language: en-GB
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
References: <b6e0f49a-34ff-4e8e-9c3e-b8fd41d59f68@jguk.org>
 <20231201212423.M738201@dcvr>
From: Jonny Grant <jg@jguk.org>
In-Reply-To: <20231201212423.M738201@dcvr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/12/2023 21:24, Eric Wong wrote:
> Jonny Grant <jg@jguk.org> wrote:
>> Hello
>> May I ask if anyone has suggested adding a default warning that git:// is not a secure connection?
>>
>> ie "warning: git:// is not a secure connection. https and ssh are secure."
> 
> To be accurate, that would need an exclusion list of hosts behind
> already-encrypted and trusted networks.  So stuff like .onion hostnames
> for Tor, and a user-configurable list of hosts in a private LAN/VPN.

That sounds good Eric.

Or even just an info message?

"info: git:// itself is an unencrypted connection. https and ssh are secure."

Kind regards
Jonny
