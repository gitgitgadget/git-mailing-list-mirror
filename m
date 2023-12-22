Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150F1171B
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjoBafC8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d3bebbf6eso13174935e9.1
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703239561; x=1703844361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mNBu42R18FwHzPjoS31oWW6rq8pzSkSsiLkPSs0cbnk=;
        b=gjoBafC8fV0Rr6K1chu3EQOv7NxCGpNp4Z1UvePBSnZJykxOdUvTNpcOiWCKfGdvjF
         VzpEcP866NBLoL0iSd18MqYU5TLfEWiOiiGoqev+Oo41EvpJ3fUY5VfRxsdD0vqlLDYl
         oOfOJ4Mt3U0iy7E29Bu/J8fGzUxqkiZSKVSU2etfpdcOzokXmff2dJ9rgBZtzckRjsGv
         u50EGGaohOedcd2p0KFDgib0CqHOSHorO5mykckWtSQiG87bn+exSr7I3Cpt0m4/LfRL
         nbKNIjixymdd7sP5vUsj/Mu2PfsQlq9XWh2Wn/eazBt4rKqInfSZKtO/563ndXDh8huw
         zH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239561; x=1703844361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNBu42R18FwHzPjoS31oWW6rq8pzSkSsiLkPSs0cbnk=;
        b=lcdFRCgzzbKJV7uoOlD/SPIxR6RjA+vOFqZUdEOsbzbWtJDHlcgwxjricagCOykxPg
         j3ns5cC2TZ9/FMDPjTuOzklpE2H9a0eNQhQCik7cB/MI7BUomNyO9bm83zdTch3gPwVb
         Ckpg4x6peP7nDCLX5q96Ve7HuxzBB5pR/ZVittesxgo1IZ62vnlrHBPQrisMzhijLcLn
         iQucFdsO+5Ch8fmpuPpKpUdCowXTU/AgofS+3rMp0vXwbIUu5C3bTgSU9/lUrzJn98Y1
         l/Nhwbl9+BOSRkYQkECaYJxzNFhY0kfIDLjpTg7uWK/0ibzSpZHjANiwHS4JV57xb+Tg
         BlJQ==
X-Gm-Message-State: AOJu0YwNkrQgNyEYQaCSLZJoxcbBYpkeAmlvid0TsBnCU9F8KvbOZx8J
	Y9lYgP6CDVoeEzAlO/tDV5Fe9p6M2c8=
X-Google-Smtp-Source: AGHT+IEY2aQ3lPJg/+xOnm7zrCinfZWQpZJwQa1LaRtQq00uU1jNeBW1aVxdhXIG+DWkm1NMpNRyqQ==
X-Received: by 2002:a05:600c:450f:b0:40d:42de:47e with SMTP id t15-20020a05600c450f00b0040d42de047emr684287wmo.48.1703239560619;
        Fri, 22 Dec 2023 02:06:00 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b0033660aabe76sm3913482wrx.39.2023.12.22.02.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 02:06:00 -0800 (PST)
Message-ID: <bf1ce173-50d7-405f-88c1-7edb7ec5a55a@gmail.com>
Date: Fri, 22 Dec 2023 10:05:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: rebase invoking pre-commit
To: Sean Allred <allred.sean@gmail.com>, Git List <git@vger.kernel.org>
References: <m0sf3vi86g.fsf@epic96565.epic.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <m0sf3vi86g.fsf@epic96565.epic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean

On 21/12/2023 20:58, Sean Allred wrote:
> Is there a current reason why pre-commit shouldn't be invoked during
> rebase, or is this just waiting for a reviewable patch?

The reason that we don't run the pre-commit hook is that the commit 
being rebased may have been created with "git commit --no-verify" and so 
running the pre-commit hook would stop it from being rebased - see 
e637122ef2 (rebase -m: do not trigger pre-commit verification, 2008-03-16).

I think that most of the time it would be valuable to run the pre-commit 
hook when committing a conflict resolution but we'd need to add 
something like "git rebase --continue --no-verify" as a way to bypass it 
when resolving conflicts in commits that were created with "git commit 
--no-verify".

Best Wishes

Phillip

> This was brought up before at [1] in 2015, but that thread so old at
> this point that it seemed prudent to double-check before investing time
> in a developing and testing a patch.
> 
> [1]: https://lore.kernel.org/git/1m55i3m.1fum4zo1fpnhncM%25lists@haller-berlin.de/
> 
> --
> Sean Allred
> 
