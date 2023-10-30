Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EFD29B0
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9Qy9I3v"
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266F1732
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:55:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507d7b73b74so5881555e87.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698659749; x=1699264549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=smiSRxPw1NAUgb7EoLqJ1zcQ7i2huLA+2edoNMtNaBA=;
        b=i9Qy9I3vf7Kh1U6eVdn2OJDYiY/hO7QROq1IT1F48XhNBJAez/MzHeZO8max3j968C
         cTV7au7px6E/i4p1ToqxHb76Vfe1xnkeXZd7NPinNfp9xpq0R1v0p+w+E2UH1CPMHWQf
         PkTH5IG5+XiCFsxS/sZqHzy0mwPfLjaJt4VGZMgUANV0PXcd/nBtiPUsSsrFpbLKhcKN
         V/MjzzcgFAQqDDPkLducZtIFhqrkgv92tzkBkJ5X+Nz9Ogqp1Y1KDNKsf13fvhZPxVEm
         VD/t/YTsQdVpkftV1UG3BcoLwnZtEhrtiE838JOXDA/ScfgSaYaQjrfbEyOD/H5jI6Az
         lElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659749; x=1699264549;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smiSRxPw1NAUgb7EoLqJ1zcQ7i2huLA+2edoNMtNaBA=;
        b=jdBMIC4OJ3ppEchEp+iEtdXAuMZviUPCvrPpwfjSwSka/GUBdB3i0FKqo0qAKwlTna
         fNvZmafCQ2Pfc1Dx900VUaG292bRMGUpQ8sjnGBZ0OYxfftKWCE5xawgK+AGoM0gOnZH
         Tid12Cnqv92foTrZ0nh3MdqA0x1XpHK8lP+jggRdHu4t77DlQ/K7eMtepE+TkmOSsWXI
         paReW48hoIvDSdN15TW41tMCgxWw/LREPGcysimkHJ9wXLB5ixLX+6hmU2//GersGaML
         e6uB+mU7HPAOFDhDCzhAriv3PoR0Pd8McST/6uJqGbTytny4td3IBLkMt5oniivVciSi
         OF3g==
X-Gm-Message-State: AOJu0YxR729Z58VVuyqtoeRtrHf0sJB0V3bbZntS6G0ug5W9aESfFrzq
	4s0Nnc/kRJMMBrDkDjAyhgM=
X-Google-Smtp-Source: AGHT+IEmlSjPi/eZdTPXS9lMp8OuokOQwOQSDywXHIrteUcxJjoIOTNfWeu7XUc2v13t2EJzN5liwA==
X-Received: by 2002:a05:6512:1cf:b0:505:7113:1d0f with SMTP id f15-20020a05651201cf00b0050571131d0fmr6271809lfp.13.1698659748355;
        Mon, 30 Oct 2023 02:55:48 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id u7-20020adff887000000b0032d9523de65sm7817308wrp.48.2023.10.30.02.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 02:55:48 -0700 (PDT)
Message-ID: <2daced1b-574e-442c-9cca-fa5050946f2f@gmail.com>
Date: Mon, 30 Oct 2023 09:55:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] git-rebase.txt: rewrite docu for fixup/squash (again)
Content-Language: en-US
To: Marc Branchaud <marcnarc@xiplink.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <20231025102932.1202299-1-oswald.buddenhagen@gmx.de>
 <56e3e974-a027-439f-871d-c7fbae65a04e@xiplink.com>
In-Reply-To: <56e3e974-a027-439f-871d-c7fbae65a04e@xiplink.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/2023 14:14, Marc Branchaud wrote:
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index e7b39ad244..578d1d34a6 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -890,20 +890,22 @@ command "pick" with the command "reword".
>>   To drop a commit, replace the command "pick" with "drop", or just
>>   delete the matching line.
>> -If you want to fold two or more commits into one, replace the command
>> -"pick" for the second and subsequent commits with "squash" or "fixup".
>> -If the commits had different authors, the folded commit will be
>> -attributed to the author of the first commit.  The suggested commit
>> -message for the folded commit is the concatenation of the first
>> -commit's message with those identified by "squash" commands, omitting 
>> the
>> -messages of commits identified by "fixup" commands, unless "fixup -c"
>> -is used.  In that case the suggested commit message is only the message
>> -of the "fixup -c" commit, and an editor is opened allowing you to edit
>> -the message.  The contents (patch) of the "fixup -c" commit are still
>> -incorporated into the folded commit. If there is more than one "fixup 
>> -c"
>> -commit, the message from the final one is used.  You can also use
>> -"fixup -C" to get the same behavior as "fixup -c" except without opening
>> -an editor.
>> +If you want to fold two or more commits into one (that is, to combine
>> +their contents/patches), replace the command "pick" for the second and
>> +subsequent commits with "squash" or "fixup".
>> +The commit message for the folded commit is the concatenation of the
>> +message of the first commit with those of commits identified by "squash"
>> +commands, omitting those of commits identified by "fixup" commands,
>> +unless "fixup -c" is used. In the latter case, the message is obtained
>> +only from the "fixup -c" commit (if multiple are present, the last one
>> +takes precedence, but this should not be relied upon).
> 
> I like the overall phrasing here.
> 
> But I think you should remove the "but this should not be relied upon" 
> phrase.  This reads as if Git's current behaviour is undefined, which 
> most definitely is not true.

I agree it would be better to remove that phrase, as you say it makes it 
sounds like the behaviour cannot be relied on.

> Even changing this to something like "but this might change in the 
> future" is unhelpful.  Everything in Git is subject to change over a 
> long-enough time span, so the same could be said about every aspect of Git.
> 
> Until the behaviour actually changes, it's perfectly fine for people to 
> use multiple "fixup -c" commands.  There's no reason to scare them off 
> of it.

Indeed

Best Wishes

Phillip
