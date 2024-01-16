Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F541B7F3
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcmWtBrY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e78238db9so17857335e9.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705404644; x=1706009444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pwzaLcguOcWOqdsItaujkX+5Q/0vntMh8Bcbz8RwSA=;
        b=WcmWtBrYdg7KyIk/H+Ptnl3YjAefXx6cfO0BXAg7kIWgHnebzuAuxhTbDhfmdmmyV/
         waGjQmFOSmBuiAIdjTVI4E1RAXWWR7xexoqKxE5jMmPZsN+z8HzBiQBYcj+p6xJStrnP
         YWgxQ9qdv/SktUvdR5qYn5K3ElyENhrHWkUifDv1gB2wJwp5UL9FGyvQyz8Jv1MlE8co
         1p9B/nB5weS4wr3/hLgdrvV+dwNWaCVFJSZmr5/ohn6SFmTI8rwDD51Q2Yzfb3c+4Ng3
         h59Dqo/CMKJfF//t9GPs0WNY3aUeK/LURRJaRZt+x5QLrv03YNCMwSvlbx5RnV5aKUE2
         kYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705404644; x=1706009444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pwzaLcguOcWOqdsItaujkX+5Q/0vntMh8Bcbz8RwSA=;
        b=xJUYy1W2H5tZGnqROxqfolKBxk2ERVLxV/qDg8UzZ+zWggt48cgeJbTlPOP8yGi7gV
         IRWgAYwtx621BEhYc+9zAxlGDWJaZMbz0isePGQnPcEYwMqLpgThMM6nk/LBTIAXZ3Y9
         drRvch0M9neGTnojb5LP0CRKsRf10/2y+N4D2W2yAElVWfhrwzmyeOcUooamJrLZBIhV
         U1Jeo6lZyuQ4FOetVSddHy8LvArjf0PSlaZ1Red/XVPyyq/oGSJuXanmUPQCd7VfceEn
         9StktTGVih5HFW4bTNsiJ8LPrdiKQdiIBLtYz9+3A1ea8bsJBkld+CXpd+4vmbSlkHQW
         OZmg==
X-Gm-Message-State: AOJu0YyGm/j3wEhi5WnECvGykrU+OZ5Sh+3ZKB5jcGJCoc975T8/vJvz
	Xdd8jAmD6IUp8hmfY7gfei7F4SE8KwM=
X-Google-Smtp-Source: AGHT+IETd3Xoem/R/5VdgIpIc2dJEPstamIgiqch4/evdDGc+2ZZwhAFr2d7/4N4ZPwvVTNcqZZY9g==
X-Received: by 2002:a05:600c:4f14:b0:40e:5cf9:d5cf with SMTP id l20-20020a05600c4f1400b0040e5cf9d5cfmr3810478wmq.124.1705404644091;
        Tue, 16 Jan 2024 03:30:44 -0800 (PST)
Received: from gmail.com (195.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.195])
        by smtp.gmail.com with ESMTPSA id jg1-20020a05600ca00100b0040d4e1393dcsm22621797wmb.20.2024.01.16.03.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 03:30:43 -0800 (PST)
Message-ID: <8774e3a1-3362-4ba4-9eb9-012bd9665d83@gmail.com>
Date: Tue, 16 Jan 2024 12:30:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH] Port helper/test-advise.c to
 unit-tests/t-advise.c
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
 christian.couder@gmail.com, Christian Couder <chriscool@tuxfamily.org>
References: <20240112102122.1422-1-ach.lumap@gmail.com>
 <xmqqmsta6uju.fsf@gitster.g> <93468f5c-5f62-4f22-85ce-b60621852430@gmail.com>
 <xmqqy1cq4ide.fsf@gitster.g> <6b6b455e-26b8-442e-828e-506f9a152407@gmail.com>
Content-Language: en-US
In-Reply-To: <6b6b455e-26b8-442e-828e-506f9a152407@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15-ene-2024 20:24:47, Rubén Justo wrote:

> -	check_str(actual.buf, expect);
> +	check_str_len(actual.buf, expect, strlen(expect));
> +	if (!conf_val && skip_prefix(actual.buf, expect, &hint))
> +		check_str_len(hint, expect_hint_msg, strlen(expect_hint_msg));
>  	strbuf_release(&actual);
>  
>  	if (!check(remove(out_file) == 0))
> 
> This implies a new check_str_len() helper, which I'm not including here
> but it's a trivial copy of check_str() but using strncmp().
> 
> Maybe we can turn the screw a little more.
> 
> I'm still not sure of the value in the changes in this series, though.

I hope, no one has wasted time with the code above.  It is not testing
correctly the conditions being probed in t-advice.c.

Take it as a way to see if this is how we want to avoid multiple
instances of similar literals that might be tempting to refactor.
