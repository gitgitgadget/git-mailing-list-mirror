Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E061BA44
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYTEdn2g"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB728AC
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 09:13:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so2809688f8f.1
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698596023; x=1699200823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JQyCNdjP+gWqPrVR9JzLbHPaSRYjvUAMqOMedcAUIHE=;
        b=nYTEdn2glBabV/aQ/5F785f47pmj4V0TeXQdSoypR11uGiRE09czH3J9aoH6BcV0+9
         ofastppLs5+w6r5seTCeDOsIFyNkfOlSw2RnL1vmFoaj5Bggtro54Y+jZkPf0JugIAUB
         te13Sv6TudcpavyuyxBXk7AAKkIcWd8CUxiVorMjQPtXFwdxTnjxvl+DU5pdc7Osd+PY
         JD5oJF3nHXekQe9oAka8xYqu8qt0C1ZXCMrkGqcVRwrJkeWXtmFGtLMMZxoB9RNwCf3b
         +RoXWd893dUcPJshEfO+1jh7nTPFW4uYYqBK0fmaUoDX/h3SW1OOeGGtpq2c8VEihFEs
         Jb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698596023; x=1699200823;
        h=content-transfer-encoding:in-reply-to:reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQyCNdjP+gWqPrVR9JzLbHPaSRYjvUAMqOMedcAUIHE=;
        b=FVJGyKugusuuFb/auFbsfPxzQBAfZAr1Y+8bVCRaRJuqh59YWz2OZA7kkABeGrt3Ku
         u0ZksBuktTGE26LNzbxfonP4eYoggBtTcLkP5GOFI1TKKQ4tfXgm2nH7n4vDx/nbqdoi
         y/Jlq7ARPb0YfmhzEsf8IESo4oNakc4Oa0JAdE9/SiSR09PprLByaEZleJYX9FiyR679
         iZcyt6tnHzHLktjj89ugOVjfUEQOiZiv0JzvoqQIZjwJ0u0Ez8rGsKlZhqu+s8p423/0
         ZvDjS630mAH8eTaONdwRBS+tiS8XWxfZbjFOfhQ1sSq2RMfmXv7k0qMcMh6KyQQmTHZe
         FRFg==
X-Gm-Message-State: AOJu0YxFnxyBe+ytNg0VNyTAkRdC2Vun31rwHqSRy6hAiuK2r8PvKWgt
	BDSpRg1OMdUBS9dNMVriVcw=
X-Google-Smtp-Source: AGHT+IHQo2tPytSPxRPIWAqw6B4CQSps6+eXnDN1uo1DyuO8CDLK5a0HgAxNUY7dzyeLXQUZ07Fzqg==
X-Received: by 2002:a05:6000:144b:b0:32f:8181:7d42 with SMTP id v11-20020a056000144b00b0032f81817d42mr1904744wrx.9.1698596022889;
        Sun, 29 Oct 2023 09:13:42 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c4d0e00b003fef5e76f2csm4046538wmp.0.2023.10.29.09.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 09:13:42 -0700 (PDT)
Message-ID: <8db10489-546d-428d-9b3e-7ecea87e1313@gmail.com>
Date: Sun, 29 Oct 2023 16:13:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com> <ZTucxlBR1VrJPuSK@tanuki>
 <ZTulo_rh_G-lfICQ@tanuki>
 <6ee43015-1abc-4269-b710-0647ce80d7a2@crinan.ddns.net>
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <6ee43015-1abc-4269-b710-0647ce80d7a2@crinan.ddns.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/10/2023 14:02, Phillip Wood wrote:
> On 27/10/2023 12:57, Patrick Steinhardt wrote:
>> Hum. After having a look at `ci/run-docker-build.sh` I don't feel like
>> it's sensible to update it. It's not even used anymore by our CI but
>> only by `ci/run-docker.sh`, which seems to be more of a developer-facing
>> script?
>>
>> As you said, this smells like rotting bits that might rather be removed.
>> But in any case, as they don't relate to our current CI infrastructure
>> except for being in "ci/" I'll leave them be for now.
> 
> I was trying to suggest that we start using these scripts again.

Having taken a closer look I think we'd be better off adding something like

   # Ensure the build and tests run as an unprivileged user
   if test "$(id -u)" -eq 0
   then
       useradd --home-dir "$(pwd)" builder
       chown -R builder .
       exec sudo --preserve-env --set-home --user=builder "$0"
   fi

To the beginning of ci/run-build-and-tests.sh.

Best Wishes

Phillip
