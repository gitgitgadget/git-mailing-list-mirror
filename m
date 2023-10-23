Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09311CA96
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd1urwxO"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E7101
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:01:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083f61322fso27274965e9.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698076863; x=1698681663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TuG2ryZ5StMG/9fs58GWh29uhcal0q7R4SoXK2QmbH4=;
        b=Zd1urwxOtY3i2IovGF/Zn7vegPl96Rv/v5miD1sLw7hh5f4ughLCLbKM4LLOXjoWhi
         YrkPAnAobL3r7VX+HS6AJ7BuEbDsqbL8xUpFXCLmu48psgHjro3CuXRBRoRj1qfeQRT7
         FpFRWuAybd2HKHLEA3KkeqjTQrnvHCkHBIKRtLPHGCj9S0BzjVXRQ4ErraqM4Wwms1jt
         bVii0x3ew3OBSCvmkCFlC5hIe/ufb8oVRuwUte8wzLcFQ3Ji7H7Gwo3GEoGxNHHdODai
         rGiI9gEZP8RrD/yYXQkT/hs8csB0lSfhhN05WmPPtZQFtXOf0iCU19QzDr1aRgkqmZGJ
         AKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698076863; x=1698681663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuG2ryZ5StMG/9fs58GWh29uhcal0q7R4SoXK2QmbH4=;
        b=PFhBf28u2WibQAJk3TGDYpx9SNvEvcjQuXOoDbGbBGvW0ossOMRUpF29w792I6x7Un
         RwMvhSqx3euGNXBlbPe7pRYXq2EBQv7vSHcq3ReC4q1pKwThmK7JltqEK5nQ7d4aGAll
         GacTGa1JapcpPdq3FCzpO+o0chf81YrY345vSlcRwzPv3hRKJdo8L2f4YsZsdixURjbL
         vKPn+E/w+7/Jzu7kqFvz8cRjHTfPgeS27sc5sPWteTp8aOHx/EJxKOUIiWsbHzOFb8h8
         oYOHlNXRBcYubCQQwzBUI9PrwKTvfttDMdxUc0uryD4RYDlOPx+YEF4OJcxfYYKBd6Qr
         U94g==
X-Gm-Message-State: AOJu0YyybWLZrWIu0S5gwQfdTlc4XPNA2QC2yAt3/fCkVJyZGmylae5B
	Jl+lK+z0/g0RjUiCIqpl+M0=
X-Google-Smtp-Source: AGHT+IFVBWtEuWC6JdRjO1MAfvKXn7269124a9SdO+GI0FfOO0Ps5b0C5+B8+hN8mh+75m9eRf2kxg==
X-Received: by 2002:a05:600c:1910:b0:401:b2c7:34a8 with SMTP id j16-20020a05600c191000b00401b2c734a8mr7476569wmq.7.1698076863205;
        Mon, 23 Oct 2023 09:01:03 -0700 (PDT)
Received: from [192.168.1.12] (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id az15-20020a05600c600f00b00406447b798bsm14672763wmb.37.2023.10.23.09.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 09:01:02 -0700 (PDT)
Message-ID: <a85c80eb-65ab-4b8c-ba94-de71516da5ef@gmail.com>
Date: Mon, 23 Oct 2023 17:01:02 +0100
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
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>,
 Marc Branchaud <marcnarc@xiplink.com>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oswald

On 23/10/2023 14:00, Oswald Buddenhagen wrote:
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e7b39ad244..337df9ef2f 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -890,20 +890,21 @@ command "pick" with the command "reword".
>   To drop a commit, replace the command "pick" with "drop", or just
>   delete the matching line.
>   
> -If you want to fold two or more commits into one, replace the command
> -"pick" for the second and subsequent commits with "squash" or "fixup".
> -If the commits had different authors, the folded commit will be
> -attributed to the author of the first commit.  The suggested commit
> -message for the folded commit is the concatenation of the first
> -commit's message with those identified by "squash" commands, omitting the
> -messages of commits identified by "fixup" commands, unless "fixup -c"
> -is used.  In that case the suggested commit message is only the message
> -of the "fixup -c" commit, and an editor is opened allowing you to edit
> -the message.  The contents (patch) of the "fixup -c" commit are still
> -incorporated into the folded commit. If there is more than one "fixup -c"
> -commit, the message from the final one is used.  You can also use
> -"fixup -C" to get the same behavior as "fixup -c" except without opening
> -an editor.
> +If you want to fold two or more commits into one (that is, to combine
> +their contents/patches), replace the command "pick" for the second and
> +subsequent commits with "squash" or "fixup".
> +The commit message for the folded commit is the concatenation of the
> +message of the first commit with those of commits identified by "squash"
> +commands, omitting those of commits identified by "fixup" commands,
> +unless "fixup -c" is used. In the latter case, the message is obtained
> +only from the "fixup -c" commit (having more than one of these is
> +incorrect).

This change is incorrect - it is perfectly fine to have more than one 
"fixup -c" command. In that case we use the message of the commit of the 
final "fixup -c" command. One case where there can be multiple "fixup 
-c" commands is  when a commit has been reworded several times via "git 
commit --fixup=reword:<commit>" and the user runs "git rebase --autosquash"

> +If the resulting commit message is a concatenation of multiple messages,
> +an editor is opened allowing you to edit it. This is also the case for a
> +message obtained via "fixup -c", while using "fixup -C" instead skips
> +the editor; this is analogous to the behavior of `git commit`.
> +The first commit which contributes to the suggested commit message also
> +determines the author, along with the date/timestamp.

In the case of

pick A
fixup -C B

don't we keep the authorship from A and just use the commit message from B?

Best Wishes

Phillip

