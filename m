Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E38441A
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI8cixJc"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3973E3
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 00:02:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5082a932bdeso1858436e87.3
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698476569; x=1699081369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maOo6z5T1/HhoeYWaJubP2lrOVdoRShGNpF4bQZGC/M=;
        b=lI8cixJclel80sqUMAgRCc91UtUxcHU16BXUU5GRrgp2tA5jl2wfYpzriVbk5pOjb5
         O3cYngdMOWj4FqArKMXdSOeNQ372uEgAzsbjCY85n18G9GWT1M9momk0CE93FIfxemw2
         iQ6BO5Srlp9ZevwgaE20tz7ZYYyCXV1UcHBTQjy+f+p9D+fXkfFfatWKg7JYQi5ZWDps
         cCSLng9T+OdauSeL5NNq2HJzTxXHDqzODHelSPVTsMN3TRrEZuKKddRnj/vukWgmHbPC
         bnOymJQfro9gGeqpap1spMqvVDWXh5BgaRSnhHFtc8QN9Y2r6VlXbTpEpdlIoIt9zvq2
         Lj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698476569; x=1699081369;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maOo6z5T1/HhoeYWaJubP2lrOVdoRShGNpF4bQZGC/M=;
        b=UfWtgvpwJ2/+IaA7NNqlMgONY4AmppOeaXTIys7t1nnCbmfHj3nmF2t8T2VCffRUh3
         b54xVpgHBl+G1LNMFACpNPB5VIXW2/mUUveXCbqSVIDXuZkek6HHEuMes3ZiGaqzKxGM
         dUGid17Ov4ZEIUI47nitIA2LxSwlCU6A2gc5I1Q6vEeVLNFKuTV4A2TlRCJaEWYwqYRZ
         IcGX0+oXKMbp9regshNpkLHLy/R7IIiALQnGiOPXm1F21xFzKOgYCQzsf0rhsGt7CO/d
         fXZ8O98Sn4Y78frcJ0+qjuBR/L6IzAwjB1zKKd0iNQt5EGlJKa9715jtbSsn77Ly2fZ/
         waOQ==
X-Gm-Message-State: AOJu0YzGZ1mdViKaBWdoK2vhiNmgrL3QgiP6aO5+RFKlIoWkaVskaNkS
	+z+amBJ8oVXqKJ/x1FngfkY=
X-Google-Smtp-Source: AGHT+IFW46oBkrK4YcN+9cLu1V4Qh1TIfLR/qb7SwUcMvno+xUibTSCGvoVflSBYRzamVifbwEzi1A==
X-Received: by 2002:a05:6512:3e08:b0:503:99d:5a97 with SMTP id i8-20020a0565123e0800b00503099d5a97mr4066018lfv.20.1698476568744;
        Sat, 28 Oct 2023 00:02:48 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d6ac9000000b0032d687fd9d0sm3221633wrw.19.2023.10.28.00.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 00:02:48 -0700 (PDT)
Message-ID: <fe58af57-e84d-4872-ab88-0b228699e5b5@gmail.com>
Date: Sat, 28 Oct 2023 08:02:47 +0100
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
From: Andy Koppe <andy.koppe@gmail.com>
To: Liam Beguin <liambeguin@gmail.com>, Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com> <xmqq7cn7obah.fsf@gitster.g>
 <20231028021301.GA35796@coredump.intra.peff.net>
 <20231028032221.GB1784118@shaak>
 <9a1e3e90-3e94-41fa-897d-5c64c4a42871@gmail.com>
In-Reply-To: <9a1e3e90-3e94-41fa-897d-5c64c4a42871@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/2023 07:58, Andy Koppe wrote:
> On 28/10/2023 04:22, Liam Beguin wrote:
>> On Fri, Oct 27, 2023 at 10:13:01PM -0400, Jeff King wrote:
>>> One way you could directly use this is in shortlog, which these days
>>> lets you group by specific formats. So:
>>>
>>>    git shortlog -ns --group=format:%aA
>>
>> That's exactly what I implemented this for :-)
> 
> Another potential use case is custom log formats where one might want to 
> color the local-part separately from the domain part.
> 
>>> It also feels like a symmetric match to "%al", which already exists.
> 
> Speaking of symmetry, I think it would need "%c" counterparts for the 
> coloring use case.

D'oh, it always helps to read the actual patches, which do have the %c 
variants.

Thanks,
Andy
