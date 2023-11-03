Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927479CF
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNY6D2+l"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C199131
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 01:22:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40859c46447so11529315e9.1
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698999727; x=1699604527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/hmEkKI2boDjI8Hw9423CZG9jxo+MFOL+H/iVY0aS4=;
        b=DNY6D2+lNc+3/zXMqmS4BhVhCvT5iafc79Q1SJRDW9sjXayoWfPzLKPqzOeVJN8Lwj
         +T1PfFrEFQ2VCLBqVMVt0ABB+YJBr+nQfkniIhyn9VDqX+KbV6Yk8+N9GI6VBdq/U7ya
         cDeOuJfny/EWTD6evNi4+CI6pk85cZ3wM52x5rU0EZuNdE/QthJX+mwgtxB5wyrpD94H
         TYANMY7taGDCydHEhV8968Rh69aRvY4yOcR7eKIKp3rezUxg/fUl3lO63HZcCURdlG5R
         3RSws9FL1OuFCKVw4z8pYvMyGhAMseaAy1dkeOJSIpT3n3n3DxWAGaaoXEDqAo48WAK4
         VXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698999727; x=1699604527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/hmEkKI2boDjI8Hw9423CZG9jxo+MFOL+H/iVY0aS4=;
        b=XGb7mqbpK72FtGbPjjsoejT5LB9TsVkGq5ypJE4/Q4dWhLXmfhxNxDqylim/ZcOCVB
         qstP7tlXjwy2uMyj80NyESbkLn+zmkmiWJytV9oIdCDBnlMNhCJmfX1xu9ePLN1ihqHO
         mUpGdMHb35DjQs+0veyax6WhzHM/jiR6Cy1g7KKw/IknUrSSVYWH2mM8ULL0GatYOxJ0
         fgHhvMzYWrj07wUYNImCjOdLYB1wjvyFhPcgOQFxjR7zYqiMGO4+PU9K7+KJx0Pm4fMt
         EbC57t9DhcMj+Nj4q5bU/Mt7feGQn1CQlPLVEAXFgC1oxzNDtqkhT5mHBRKUm5cDE++X
         6GVQ==
X-Gm-Message-State: AOJu0YxwfYGqI88OtOdhASveTKClKGI1hB0JwcNAQtF16WZXM2w/4Yu+
	4xIN76BWXCuhdRWXCg3T8kQ=
X-Google-Smtp-Source: AGHT+IEaTKKoh/8dxvMcqJQuR91q5utevX4I5eTGv3e9yN6zyBf4u12mYEfi3SPeN34h3EwIfq5EEA==
X-Received: by 2002:a5d:6843:0:b0:32f:b17c:65e0 with SMTP id o3-20020a5d6843000000b0032fb17c65e0mr2634709wrw.17.1698999726733;
        Fri, 03 Nov 2023 01:22:06 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id f1-20020a056000128100b0032d88e370basm1252841wrx.34.2023.11.03.01.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 01:22:06 -0700 (PDT)
Message-ID: <4e3a5661-cba0-4849-8340-06d8d4094f48@gmail.com>
Date: Fri, 3 Nov 2023 08:22:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
To: Kousik Sanagavarapu <five231003@gmail.com>,
 Liam Beguin <liambeguin@gmail.com>
Cc: git@vger.kernel.org
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
Content-Language: en-GB
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <20231027184357.21049-1-five231003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/10/2023 19:40, Kousik Sanagavarapu wrote:
> Liam Beguin <liambeguin@gmail.com> wrote:
>> @@ -808,6 +808,17 @@ static size_t format_person_part(struct strbuf *sb, char part,
>>   		strbuf_add(sb, mail, maillen);
>>   		return placeholder_len;
>>   	}
>> +	if (part == 'a' || part == 'A') {	/* domain-part */
>> +		const char *at = memchr(mail, '@', maillen);
>> +		if (at) {
>> +			at += 1;
>> +			maillen -= at - mail;
>> +			strbuf_add(sb, at, maillen);
>> +		} else {
>> +			strbuf_add(sb, mail, maillen);
>> +		}
>> +		return placeholder_len;
>> +	}
>>   
>>   	if (!s.date_begin)
>>   		goto skip;
> 
> So, if we have a domain-name, we grab it, else (the case where we don't
> have '@') we grab it as-is. Looks good.

I'm not sure that this is the right way to handle a missing '@' here 
actually, because %al already returns the whole email field in that 
case, which makes sense as the likes of the 'mail' command would 
interpret it as a local username.

And if someone was going to use %al and the new specifier together to 
format the parts of the email field differently, they probably wouldn't 
want the field to appear twice.

Therefore I think it would be more appropriate to expand to nothing in 
that case. Tools that consume this output would already need to be able 
to deal with the empty case, as it could also happen if there's a single 
'@' at the end of the email field, or if the field is empty.

Regards,
Andy
