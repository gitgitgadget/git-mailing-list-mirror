Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5813FFE
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv6Cgdc7"
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759151BF
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 03:27:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1183926f8f.0
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697884057; x=1698488857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jReL+OYsCTFRBB/Z0F7x1v9aOxxTXd1/K93iY1moOX4=;
        b=Qv6Cgdc7H8gbxCyBefmt3qg/nrwosiWvneDWVig+E3XZbnMcA894x4G7f0UTc8F2SL
         Iq8ZyaCGNDb7RWgKhFaxECHkmGknhFT9NXTMNobcQdsLY6dppUbRCwrWJs6u9L9t3Bak
         eiEchXi3FiwYTpjyX43170zaxUgJ0nsrdKCIVWsTquKF5vydkcmuNHNH9FMNC36IrbtD
         RsyPMC4vkbBHEIEjKYE9LAcw9wCRWHc3osLKd6Buresso8FlBW/HAO6jpYsWnRn/Kv1L
         nM2jQWv+6Ott9jwdsmPoNEnpOq23OQ1sjuPX9WqGOBH7WD0dGkIl0T9opfc2kxtkoTK7
         XxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697884057; x=1698488857;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jReL+OYsCTFRBB/Z0F7x1v9aOxxTXd1/K93iY1moOX4=;
        b=w2ccaFFs1vIFolTqScdV4RjG+GFWldtUInHnuygsGynkRE8uBpC1PWB+k1Df231c23
         q7TIZTW5qXWLZ9771a5fzO1RUlRhCpW9VGA0cPhB5alTH/LeuJZ8fBDVWhKax5rmgMN5
         cnrdPuBCdJwILXnCYIXzTI2Tqc9c6EMAhF5yNdw2BslGjSGQUvSz6dvkmX4NLVNiakee
         gFSLyiQ2CatamHIdUcz/oErw66tDI7MrponOp+typ3hDZVgvjiVlK+Wt+SowgwPipizr
         YkOZYyi+l/r6c4u5wyW3MPLisj8g+cTAH6uUTFioRSB55rfYZiyf9J1j36eOoveEfU/d
         tkWw==
X-Gm-Message-State: AOJu0YwkoZ7wvNtWMJDY1a20bKyVXAjh4a4v20QrKX1XhWt+5DMjcf7F
	cX71l9OdvnGi1rErmAJuHUAQKh02vHc=
X-Google-Smtp-Source: AGHT+IFWv4mGmVDqbpV5tKDTK3OOQOzMbKJUnBsXxOcFSCUTRDNMxOW1CkLUJAVxQh7lIYiEVT6PvQ==
X-Received: by 2002:a5d:5352:0:b0:32d:b051:9a27 with SMTP id t18-20020a5d5352000000b0032db0519a27mr3169541wrv.20.1697884056516;
        Sat, 21 Oct 2023 03:27:36 -0700 (PDT)
Received: from [192.168.2.52] (150.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.150])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b003258934a4bcsm3454742wrt.42.2023.10.21.03.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 03:27:35 -0700 (PDT)
Message-ID: <c0d92716-2add-43c2-945a-cb0c9cb6b6a6@gmail.com>
Date: Sat, 21 Oct 2023 12:27:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] builtin/branch.c: adjust error messages to coding
 guidelines
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Isoken June Ibizugbe <isokenjune@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, gitster@pobox.com
References: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
 <20231019084052.567922-1-isokenjune@gmail.com>
 <331e1ab3-2e8c-497d-a05d-ef197d664188@gmail.com>
In-Reply-To: <331e1ab3-2e8c-497d-a05d-ef197d664188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19-oct-2023 21:20:24, Rubén Justo wrote:

> So, aside from the confusing message, this iteration looks good to me.

Reviewing again the messages in builtin/branch.c, if you finally
re-roll, maybe you want to add: 

diff --git a/builtin/branch.c b/builtin/branch.c
index e7ee9bd0f1..31da889e95 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -777,7 +777,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
        if (!strcmp(head, "HEAD"))
                filter.detached = 1;
        else if (!skip_prefix(head, "refs/heads/", &head))
-               die(_("HEAD not found below refs/heads!"));
+               die(_("HEAD not found below refs/heads"));
 
But if you don't include this nit, that's fine with me.  I still think
the changes you've already made are correct.

Thank you.
