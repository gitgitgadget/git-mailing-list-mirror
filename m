Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3182D05E
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyH0Fmtr"
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF810F0
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:23:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32fb190bf9bso2975139f8f.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699356199; x=1699960999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko928KfOYW3EE1Yt818/EBswb9VQHz+p1u5rKS5vTy8=;
        b=kyH0FmtrVm7vnkvi2IHZb2pVSvNIMMWqr/sMsf4oeBIMI+8xuq+boPx0jX2KTjy3Lh
         Rhn0dSp1cXww+ZsnWDW01gbzarR1qR2xFtfm/cMKNVHPdaznqm8yhWN2zH6gGWg5uNg7
         GSS1IkI26L4aV+J66721V4lNMzmSmq7VzDw1owbQ6Pi/M5HGhghTUVhpHEGlxPHEKvuj
         OLBY/LT36u0UaBt8h0lM03lj/hj/NNp/0443IuI/fNiIboH4rjmb10zLp2HzWZJEFl/S
         o+bKDdcfLSS6ecdPcA8VdOy0F0cdDjorvIuAEWSeTowjbH8jnxFQ3cmlA5A+xvr45CG1
         k0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699356199; x=1699960999;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ko928KfOYW3EE1Yt818/EBswb9VQHz+p1u5rKS5vTy8=;
        b=PdNBHqucWMOd+Wkvpe51xxtECJHIcOXY2pVLsqMfmNavOXaI2N6tZuta86bHtjLGQI
         qF1yMubvuc6lDCt5jID/Iz7J6nQ8f2jO0usSpuMvZGRFmF0FQsVjI4yVQVhquZc/Abg5
         crjJii7tM3RJqniSUtReW0N7MuIHVuDV7PCUrEELH737hWH4+Vgma1RrK8ENWNFdDnqU
         WmN/izJem3zzVbVTLzHuMoatPRJXjM0YT7ZphZU3TKa6b/fB9Gb0XGrinvb2bNWmTVti
         4M7HSrQhV17PfVBUUN2o2Ihh4QUUJO2Ed3PKL36TFwxc/VpedGFPn4rrwiWpnrz8nOUK
         aY9w==
X-Gm-Message-State: AOJu0YyLo5KCgo3XUOnmMW7grTfqi0e+Wz+ART3yH0p0JIMnvGXghPn1
	8SH7aV/DVDJ3JupVLhE3Qt2k37wbgIE=
X-Google-Smtp-Source: AGHT+IHzDBP+WkraUPj2h1Bsholo1w00iYyb8CSSLLCRV51PVF+ePMuuuQmwyB/5Uz0I2ZpLiLtexw==
X-Received: by 2002:a5d:5847:0:b0:32f:88f9:ba44 with SMTP id i7-20020a5d5847000000b0032f88f9ba44mr2527019wrf.25.1699356198828;
        Tue, 07 Nov 2023 03:23:18 -0800 (PST)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id s12-20020a5d6a8c000000b0032db8f7f378sm2087046wru.71.2023.11.07.03.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 03:23:18 -0800 (PST)
Message-ID: <86e6b392-5a61-4864-89b0-42023e1804a6@gmail.com>
Date: Tue, 7 Nov 2023 11:23:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: first-class conflicts?
Content-Language: en-US
To: Sandra Snan <sandra.snan@idiomdrottning.org>, git@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
 <002901da1101$7d39a420$77acec60$@nexbridge.com>
 <Gr..Y5kkszDx87g@idiomdrottning.org>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Gr..Y5kkszDx87g@idiomdrottning.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sandra

On 06/11/2023 22:45, Sandra Snan wrote:
> Randall, thank you for that.
> 
> I did mean of the first type, pure content conflicts (just like the 
> examples on that jj page).
> 
> I just have sometimes wish git could be a little more aware of them 
> beyond just storing them with ASCII art in the files themselves (and 
> alerting / warning when they happen but I often can't properly see those 
> warnings flash by so I end up having to search for the conflict markers 
> manually). So if conflicts are a thing that *can* happen, it'd be better 
> if vc could know about them which would make some of the rebases simpler 
> as in jj. That doesn't mean we wanna adopt the jj workflow of 
> deliberately checking in conflicts (not even locally), just be able to 
> deal with them better if it does happen.
> 
> I dunno… and I've really appreciated the naysayers so far, helps me sort 
> out my thoughts in this. I personally really prefer the vanilla 
> "explicit staging" workflow (with magit) over jj, got, gitless etc. I'm 
> more scared of overcommitting by mistake than undercommitting. But this 
> one feature seemed to me that it might be really good: just having the 
> vc be aware of the conflicts it has created.

If you run "git status" it will list the files that have conflicts as 
"unmerged". To prevent "git commit" from creating a commit that contains 
conflict markers you can use a pre-commit hook that runs "git diff 
--cached--check". The sample hook that is created by default does this, 
to activate it run

	mv .git/hooks/pre-commit.sample .git/hooks/pre-commit

in the main worktree. You can also run "git config commit.verbose true" 
to make "git commit" show the diff of the changes that will be committed 
below the commit message when you're editing the message.

Best Wishes

Phillip
