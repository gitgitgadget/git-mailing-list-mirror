Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C02DF47
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj/hLoBy"
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA191FEC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:49:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32f78dcf036so1043717f8f.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698659391; x=1699264191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/lxV6uhns3TqGV/oG4V7zx7abXtucNK0qOn9i+aEz4I=;
        b=Pj/hLoByxQvlor8nfYWI4ZYqYEjPemAKxDz4U2yN60P3tY0TR5iWzGk7U3L47guOSa
         cUdVSwag0PsXtjCarbTF3xWfOVsxKv4bv7IBcfbCUSuMFo5NNbmrslAXSCvm8uGt3zSX
         jjhgGNWm8sTKMGBwzOirxUFPYzfkoNxGWEJAHpADU5IKgQcV6lDmFeCg+jtqKi/tXOwQ
         aEnBr2dKxzLTsQyimznpXkz+zryLA/tizFKuWnVkYegSua4735g9oL9tntolj23Dhd19
         m2VD5m0YfYxrOl81YsrWbmuv+5VjwNHMrKbcJq+/qVXkZ03bf9TEQrYx+cBrs+7S8ClI
         WeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659391; x=1699264191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lxV6uhns3TqGV/oG4V7zx7abXtucNK0qOn9i+aEz4I=;
        b=P12C+Ds4Sp/yInPAJXhAth0A+jPmDmHPTr9WILQxoAuY5K/vhW48GPr93Spy5GxUGb
         u5cGNS9TtpeoNKOtWaoDa/o8iLWN3ymHL2u2F0MbD4RbkfmyHxzReteMbiRcEfdU4oVh
         oOs+NlnsV6cO/QZJlyfq1wgCRVOlgStyQcES70/GAJdZzdWu4YNb2YhOZtCWTaGiQn1R
         uDeTKMW9GJEKmPqXcBdSxsKgL+RWLuLHGKQUfH+pD0WVRF7cc79Qpp8fNcVxmWmz61QU
         sO5QR/dI2zgJQ9J5NM3vBQCScEonepnXzE/Z2047d2OoGO6IARRHyR4drDyXjS8L+txi
         2SkQ==
X-Gm-Message-State: AOJu0YxHCWfS3Wp0yggFYLxJgOwRB/OO0AxcXPj5vtFJQCZCiX8ZcdNM
	rGfZh0xr8a3l0qqVP7kpaTk=
X-Google-Smtp-Source: AGHT+IEVbMk99BCHP7WLPg9IqzG8rF7C39/BT6E04XAQnz5NYl1o9/Y3d9PGODCWom4Sxrq+lX96ww==
X-Received: by 2002:a5d:47cd:0:b0:32f:6d91:989f with SMTP id o13-20020a5d47cd000000b0032f6d91989fmr10986442wrc.15.1698659391404;
        Mon, 30 Oct 2023 02:49:51 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id y20-20020a1c4b14000000b0040588d85b3asm11952912wma.15.2023.10.30.02.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 02:49:51 -0700 (PDT)
Message-ID: <68c4684b-0ab0-427a-90e5-fca602c9d993@gmail.com>
Date: Mon, 30 Oct 2023 09:49:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly> <ZTtyHScKkMg4qnMH@tanuki>
 <d62b2e38-6e24-4661-b51d-2ecc59eae256@crinan.ddns.net>
 <ZTuUa5bA8dh29cyv@ugly>
 <b6ef74b7-2c77-4621-9969-d911c34561d5@crinan.ddns.net>
 <ZTv3to98QT8Ma+ag@ugly>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZTv3to98QT8Ma+ag@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/2023 18:47, Oswald Buddenhagen wrote:
> On Fri, Oct 27, 2023 at 03:32:48PM +0100, Phillip Wood wrote:
>> On 27/10/2023 11:43, Oswald Buddenhagen wrote:
>>> On Fri, Oct 27, 2023 at 11:22:35AM +0100, Phillip Wood wrote:
>>>>>>> +    CI_BRANCH="$CI_COMMIT_REF_NAME"
>>>>>>> +    CI_COMMIT="$CI_COMMIT_SHA"
>>>>>>>
>>>>>> assignments need no quoting to prevent word splitting.
>>>>>> repeats below.
>>>>>>
>>>> I think it is quite common for us to quote variables when it isn't 
>>>> strictly necessary as it makes it clear to anyone reading the script 
>>>> that there is no word splitting going on
>>>
>>>> and ensures that we don't start splitting the variable if the 
>>>> contents changes in the future.
>>>>
>>> the point was that it *isn't* content-dependent; it's simply the 
>>> shell rules.
>>
>> Oh, I'd misunderstood what you were saying which was that assignment 
>> and case statements are not subject to field splitting.
>>
>>> of course, many people (apparently you included) don't know these 
>>> subtleties
>>
>> I find this comment to be condescending, needlessly antagonistic and 
>> completely at odds with the norms of constructive discussion on this 
>> list.
>>
> the observation was necessary for the point i subsequently made (which 
> was basically agreeing with the first part of your response).

It was not necessary to phrase it as you did though. Before replying on 
Friday I showed your comment to someone else and their reaction was 
"That's rude". You could have made your point by saying something like

     It is hard to remember all the shell's word splitting rules so
     quoting everywhere is not a bad idea.

This is not the first time I've found your comments unnecessarily 
adversarial and at odds with the norms of constructive discussion and 
respectful disagreement on this list. I don't think I'm the only one 
either - in [1] Junio points out an ad-hominem remark and in [2] Marc 
comments on the unreceptive tone of you review responses.

I would urge you to try and strike a more conciliatory tone in your 
messages - it is perfectly possible to correct or disagree with someone 
without alienating them in the process.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/xmqqleeihok5.fsf@gitster.g/
[2] 
https://lore.kernel.org/git/e33f919d-1b6a-4944-ab5d-93ad0d323b68@xiplink.com/
