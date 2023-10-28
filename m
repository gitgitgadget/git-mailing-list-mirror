Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640210EA
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNhKGEtV"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D613FE3
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 23:58:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c594196344so41645751fa.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698476314; x=1699081114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGYJdCZ0sd6bPAwpUlWWCwMfL1g3X5jDw0TxQKSMDaw=;
        b=FNhKGEtVzeVcILl4IrT+a9/SZVoy+ktGznaudxla/JOf1Rfm6OXJ5U0EJYihSSdGiP
         fyQcbFbnL9N39+HNd+lKxBh4SkK0bW5ql6DDeqlrh1q6X8OCKWUB/zy7oIfUTu4d3NOu
         8SnSbffRityp1ZhTX+zMa3b10qb0cK/lWzm+mjYrhQbMKqX4AANT5DM8Sd2wREaBc+Jx
         inJWaXpBTWoGkWel0uV2gb06CWGaAkv81+JUEHro+9HqpmV9DCwmYXKOVO3M6ScuD7nP
         lxGpsd2/72HG+g+PV4qtE2b0W4tyK+VLeuGyhiA4HjwnbujEudfs/LA0WAPLeqnQnAhj
         V/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698476314; x=1699081114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGYJdCZ0sd6bPAwpUlWWCwMfL1g3X5jDw0TxQKSMDaw=;
        b=g5SgKu3b2GM3oxaK2GM8N8M/nowGXfLgMDSCRCmwb8achZai7BsB3Tq9mLn6dhsWP5
         VxryUcBBFPltjWz3AOZr/76pmmJzlQTMjS0yEi19o9xloBvKPc26ThXCFGoGQjHSoel8
         kT3pRQYNoFLAAjsWebiUgxSeuthuopWbylpRk/MY/fHMchESJJsl8dMmc7pR+cBXUZUl
         dr5je42hj1pCZFTZuNay8UZP2xb3YPVHbo/PixaU7LT3uE5VuzqOYN2lkwu2XYgCV2BQ
         4x8mk1hsfK0n+7WkEm0s22WUzQGnWQypKEk6CEI24OmnPk31ZsBlDrntw5zGrv68eDoO
         bDqQ==
X-Gm-Message-State: AOJu0YyQM7O3zTby4xrYxTE0VVRrwOBP7mGo0PGTcAdByN++tirmZE2U
	8qF+rRVS8dhsgNp8uWidaxg=
X-Google-Smtp-Source: AGHT+IFDFBa6s0GGKHPmrdgMlD8MrbWaSIv6WazmKHy7o6AU/3aqCilRfeNOKmB+FuJowDfmOA/FFw==
X-Received: by 2002:a2e:a791:0:b0:2c1:375a:b37c with SMTP id c17-20020a2ea791000000b002c1375ab37cmr3674796ljf.40.1698476313724;
        Fri, 27 Oct 2023 23:58:33 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b0032d09f7a713sm3254076wro.18.2023.10.27.23.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 23:58:33 -0700 (PDT)
Message-ID: <9a1e3e90-3e94-41fa-897d-5c64c4a42871@gmail.com>
Date: Sat, 28 Oct 2023 07:58:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Content-Language: en-GB
To: Liam Beguin <liambeguin@gmail.com>, Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com> <xmqq7cn7obah.fsf@gitster.g>
 <20231028021301.GA35796@coredump.intra.peff.net>
 <20231028032221.GB1784118@shaak>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <20231028032221.GB1784118@shaak>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2023 04:22, Liam Beguin wrote:
> On Fri, Oct 27, 2023 at 10:13:01PM -0400, Jeff King wrote:
>> One way you could directly use this is in shortlog, which these days
>> lets you group by specific formats. So:
>>
>>    git shortlog -ns --group=format:%aA
> 
> That's exactly what I implemented this for :-)

Another potential use case is custom log formats where one might want to 
color the local-part separately from the domain part.

>> It also feels like a symmetric match to "%al", which already exists.

Speaking of symmetry, I think it would need "%c" counterparts for the 
coloring use case.

> I chose the "a" for "address", but I'm not sold on %aa either.
> I just couldn't find anything better that wasn't already taken.
> 
> What about "a@"?

Makes sense, and I suppose there's "%G?" as precedent for using a symbol 
rather than letter in these.

If that's not suitable though, how about "m" for "mail domain"? It also 
immediately follows "l" for "local-part" in the alphabet.

Regards,
Andy
