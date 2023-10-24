Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B92749A
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl4Y2TG8"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394F8E
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 02:22:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3226cc3e324so3308867f8f.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698139338; x=1698744138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2BbbLETEFNRpdlzm/kObZKv8X0DYrrUfG1l2OyjCHiU=;
        b=nl4Y2TG8XAnWPe33I+Sc6FhStQJL9L/URM3gBNzoCQepSJCcBdPNPMbzRtsAFaw9Iq
         pUDqpJrzYwIj4bljQXoq1RwWt9PxK+mNtIwnYG+ss8dvoqjsbgM/JAeDrg3q867geg+P
         c5T0OSRD+rlB+PZIqmvOoiJx3K/BkCxjjqBTOkHwW0ol2nz0tzFxTSeCLtSmFf9qtul6
         rek4tnc5sLdAcCU6+4yxWFyFjKr8/ZilIjrnlFdGr9x6xlL0RbDzxRw3czPlklIOYMkg
         UPcf2UMIRaq+vHHrnpMss8swpU55rIaVWf1jC2SvDWMAnrwL5p/9SR3khZ3i3xA47qnr
         sFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139338; x=1698744138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BbbLETEFNRpdlzm/kObZKv8X0DYrrUfG1l2OyjCHiU=;
        b=XRa211g+g4ZvJKtsSQgOEEeMDawpLwnkLnnXU/4M9tFq3rm0xd/rs7bktrrRRIZYk6
         iAstybT6aq9zbgHHKiJq+gLJWWV8Z4genu2eM0zjrRzU17LUKw7Z1YKie3LXQp6eOqRx
         P650AvduidG+Gjjn51vQWcno7TTrYrJGlFp4jxkTUsi4QMUbdSvCd9XrhB0ijbZqMZ6I
         0qaWPhxrLLNOfThczbSbgdB3ZJWrQnE320RX8FmiLedywEo2DIgs36Qur7y8rdhT/DCp
         aRwo5GQ4Rf0wF9ugIPa81BDxBdNtcvWBkABBnA5Ftw68kewlHU2boEx4Rr8lCKYQxl3m
         Tegw==
X-Gm-Message-State: AOJu0YwiM2hxflO+MTy3Hgj734c0+nXlgALSCmd9wlW3yQRd3k7RrAIg
	5sMSYL2NuaqByYYowEadxY2Bg28qXYU=
X-Google-Smtp-Source: AGHT+IEFFLby+6XInNqVSuHCoEY16V5BoLAQTJKOP1U5mDTDGps1Ahfy9GISkyB/FBM2F0LkDWgbEw==
X-Received: by 2002:a5d:504b:0:b0:32d:ae31:458b with SMTP id h11-20020a5d504b000000b0032dae31458bmr9570872wrt.52.1698139338237;
        Tue, 24 Oct 2023 02:22:18 -0700 (PDT)
Received: from [192.168.1.12] (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d6841000000b0031ad5fb5a0fsm9539073wrw.58.2023.10.24.02.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 02:22:17 -0700 (PDT)
Message-ID: <b2b76344-11b7-4f21-8658-f18ffcca2dea@gmail.com>
Date: Tue, 24 Oct 2023 10:22:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>,
 Marc Branchaud <marcnarc@xiplink.com>, Johannes Sixt <j6t@kdbg.org>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <a85c80eb-65ab-4b8c-ba94-de71516da5ef@gmail.com> <ZTayxB0Nm7AEyafp@ugly>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZTayxB0Nm7AEyafp@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oswald

On 23/10/2023 18:52, Oswald Buddenhagen wrote:
> On Mon, Oct 23, 2023 at 05:01:02PM +0100, Phillip Wood wrote:
>> On 23/10/2023 14:00, Oswald Buddenhagen wrote:
>>> +unless "fixup -c" is used. In the latter case, the message is obtained
>>> +only from the "fixup -c" commit (having more than one of these is
>>> +incorrect).
>>
>> This change is incorrect - it is perfectly fine to have more than one 
>> "fixup -c" command. In that case we use the message of the commit of 
>> the final "fixup -c" command.
>>
> i know that this is the case, see the previous thread (which i failed to 
> link by header, cf. 
> https://lore.kernel.org/all/20231020092707.917514-1-oswald.buddenhagen@gmx.de/T/#u ).

Ah, I see Marc has already raised this point.

>> One case where there can be multiple "fixup -c" commands is  when a 
>> commit has been reworded several times via "git commit 
>> --fixup=reword:<commit>" and the user runs "git rebase --autosquash"
>>
> a cleaner solution would be recognizing the situation and not generating 
> these contradicting commands in the first place. of course that would be 
> more complexity, but it would also allow catching accidental use.
> 
> of course i can go back to documenting the status quo, but it seems kind 
> of wrong.

I agree there is an argument for improving the implementation of 
--autosquash but until we do I think it is counterproductive to change 
the documentation like this as it will cause users to wonder why "rebase 
--autosquash" generates a todo list that is incorrect according to the 
documentation.

>> In the case of
>>
>> pick A
>> fixup -C B
>>
>> don't we keep the authorship from A and just use the commit message 
>> from B?
>>
> uhm. we clearly do. that means i was given incorrect advice in 
> https://lore.kernel.org/all/YjXRM5HiRizZ035p@ugly/T/#u (and so the 
> thread is still looking for a resolution) ...

I'll take a look at that thread and comment there.

I do think it is a good idea to document where the authorship of a 
rebased commit comes from.

Best Wishes

Phillip
