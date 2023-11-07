Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F231FA6
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3kccO3D"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F3116
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:49:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40850b244beso42197785e9.2
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 03:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699357764; x=1699962564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nCapDl5XA0uH1gabl593HnCr7W6JW5iEMI3x0Bfojuw=;
        b=g3kccO3DX7lutdy6q6LL4JejWpfxDr564CicVebNZJxIBxC+TMCGwDVSgSNHT9NUcQ
         BNyGvyF5E0a2Ev7sTDGr/AtO21SLFlsAHd3il+9O5wj2cYb1zJ4K6iDrQDaqJ4K0ekHY
         hGhTdy5WzY/5jcMux+eYMCWFxAURadH0O8A6H/bi2iWzgoEoFc2aasObqW88bhlKXETM
         J/sDPQyNY3VfF6RpYxmNQ8s7Uv7WenTBrfbq2JMWO0Vi3aiWXrriX8BsY0bYkIxy0L2O
         rDM6C47D8LwRYDUX/eUEwOXXMqdMZ5btn2tIR71/8uFXEvdlwpboONX9jiM0wuA9dmVq
         hg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699357764; x=1699962564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCapDl5XA0uH1gabl593HnCr7W6JW5iEMI3x0Bfojuw=;
        b=vWpZGocgRKP2mInlm6QeamUTwh9+4Rt0HJryvFFmfyyel62hnCENoRqYxJ6lGpBADk
         U1Ozhdk43dKiQ2OYj/XjamS1PetQTkT5qfXSCpdZg2fHTvcGhxo6wB41qWr4D2mxkS58
         S+TuHFTciifm5ZIgZsijlKC1DTfbmspjy9wQ/vVviMiuj5p2TucPN9kRTeWuX92MJPBs
         DclTFyyWty7aqld13jjO7SSNtR0ZKfrBj3mWuzbSNctcZe3005S2X3xDH1YM+sGdVMRD
         x0OaPHbDbe5O+JNnXCoQ0jBX8sTBKj+BNsi01+N9I/YLhGo4s1FNh7FAa9T2HQiSeHpH
         5mtw==
X-Gm-Message-State: AOJu0YzTnwE+1f4KwKmc9pSHmKyILG4rWWkOhnJH2ZSPZPJceiX6BuLP
	xj2DV38jVvpf/vwhg2Q6RNc=
X-Google-Smtp-Source: AGHT+IGEyWxHxJsxMfDxVnZrvIPmUVmRzbWsfvHQ/UFWChnOvi9ptHla1rbm8pzYz5nk/Dtke/lBYA==
X-Received: by 2002:a05:600c:3144:b0:408:4266:12db with SMTP id h4-20020a05600c314400b00408426612dbmr2317356wmo.13.1699357764477;
        Tue, 07 Nov 2023 03:49:24 -0800 (PST)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id t14-20020a05600c198e00b00405d9a950a2sm15631710wmq.28.2023.11.07.03.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 03:49:24 -0800 (PST)
Message-ID: <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com>
Date: Tue, 7 Nov 2023 11:49:23 +0000
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
To: Elijah Newren <newren@gmail.com>,
 Sandra Snan <sandra.snan@idiomdrottning.org>
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@google.com>,
 "Randall S. Becker" <rsbecker@nexbridge.com>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
 <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah

[I've cc'd Martin to see if he has anything to add about how "jj" 
manages the issues around storing conflicts.]

On 07/11/2023 08:16, Elijah Newren wrote:
> On Mon, Nov 6, 2023 at 1:26 PM Sandra Snan
> <sandra.snan@idiomdrottning.org> wrote:
>>
>> Is this feature from jj also a good idea for git?
>> https://martinvonz.github.io/jj/v0.11.0/conflicts/
> 
> Martin talked about this and other features at Git Merge 2022, a
> little over a year ago.  I talked to him in more depth about these
> while there.  I personally think he has some really interesting
> features here, though at the time, I thought that the additional
> object type might be too much to ask for in a Git change, and it was
> an intrinsic part of the implementation back then.
> 
> Martin also gave us an update at the 2023 Git Contributors summit, and
> in particular noted a significant implementation change to not have
> per-file storage of conflicts, but rather storing at the commit level
> the multiple conflicting trees involved.  That model might be
> something we could implement in Git.  And if we did, it'd solve
> various issues such as people wanting to be able to stash conflicts,
> or wanting to be able to partially resolve conflicts and fix it up
> later, or be able to collaboratively resolve conflicts without having
> everyone have access to the same checkout.

One thing to think about if we ever want to implement this is what other 
data we need to store along with the conflict trees to preserve the 
context in which the conflict was created. For example the files that 
are read by "git commit" when it commits a conflict resolution. For a 
single cherry-pick/revert it would probably be fairly straight forward 
to store CHERRY_PICK_HEAD/REVERT_HEAD and add it as a parent so it gets 
transferred along with the conflicts. For a sequence of cherry-picks or 
a rebase it is more complicated to preserve the context of the conflict. 
Even "git merge" can create several files in addition to MERGE_HEAD 
which are read when the conflict resolution is committed.

> But we'd also have to be careful and think through usecases, including
> in the surrounding community.  People would probably want to ensure
> that e.g. "Protected" or "Integration" branches don't get accept
> fetches or pushes of conflicted commits,

I think this is a really important point, while it can be useful to 
share conflicts so they can be collaboratively resolved we don't want to 
propagate them into "stable" or production branches. I wonder how 'jj' 
handles this.

> git status would probably
> need some special warnings or notices, git checkout would probably
> benefit from additional warnings/notices checks for those cases, git
> log should probably display conflicted commits differently, we'd need
> to add special handling for higher order conflicts (e.g. a merge with
> conflicts is itself involved in a merge) probably similar to what jj
> has done, and audit a lot of other code paths to see what would be
> needed.

As you point out there is a lot more to this than just being able to 
store the conflict data in a commit - in many ways I think that is the 
easiest part of the solution to sharing conflicts.

Best Wishes

Phillip

