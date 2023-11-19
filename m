Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj49uqRF"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754C3C2
	for <git@vger.kernel.org>; Sun, 19 Nov 2023 08:43:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507975d34e8so5040361e87.1
        for <git@vger.kernel.org>; Sun, 19 Nov 2023 08:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700412201; x=1701017001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hYBGJ/qs0l4u1syDkuOSBLOOkTKosVgX/f813QCVtFc=;
        b=Bj49uqRF0aqHhuHFgtRu8/gy15Coij/iVtXyBTVBc9zNbRhC4tkwmjpXlO2ft3HWd9
         HZ38RtPGY0xV8t8UJ9Y4NEOiS+MEJ1ayWnNsKzTQUhvL0Ryw3Sqdo/JvHk9ZyDyaxcAs
         vQBhZki4VnGMTaLVnetwLhC5lkPxdafGYCDqc8KOQ6sv1C+5JZC4B0UFpVoAy/bZzsuB
         HBMjbZhNCsjajIkPK+Y+5h0bF7PQ8AGBJ1s2EaiM2aImHJKtuzro7cha92Y+uYLBw+X5
         Rt5by6oDeP/hQJm97iyeY8HbN/pnlXZF0yO2fM4cphPwewMCkmMpCgGoy2Qa5A2Ik5ws
         PvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700412201; x=1701017001;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYBGJ/qs0l4u1syDkuOSBLOOkTKosVgX/f813QCVtFc=;
        b=bknR4viaL+W83SNOx5g7yUI4G4Oc1+pjaPcaqOWqhmvBEzGDXyl0gu0YrWYohj7Ppo
         Bg7bZN2YRtcmybRIYtJURDIarASPR/C+5povUeldhfEpPSNF5MwZr6bpm0YyLWf+dkeA
         gYDwp6tw41bQsFu6CiY33Y9QiGmPkbdBR8QNiFOswuJztbAlOmoLpaDwWiu4rwAVJep5
         tD7TepI8fi3HrTFo+meHY0sbXFPlN2or5Qyy2MlUVWeCF9MXtvb97ftQeXkYHhLOFmYa
         DLbNxoy16oenX5euvNeQAAFFEqc1i+eHvtpLJcG4M+JXY8OmxqFRB2EqqG2EPthUP/Kq
         zL9w==
X-Gm-Message-State: AOJu0YzKjOhFGt5R/BJnMPgMnTru5iwwYZw56rKSMQZf/B4uu/N/Q2qE
	37XgVRf0zNESJg/iV2FuhqmurEqn0OY=
X-Google-Smtp-Source: AGHT+IHifshMg2tPoJQ5184Njqk80C+8v8SVxSyiqtcvPczcF64D6eL4ASgzrgTpFIFj4kVz4/hwkw==
X-Received: by 2002:ac2:4a7c:0:b0:50a:93f9:d09f with SMTP id q28-20020ac24a7c000000b0050a93f9d09fmr4317651lfp.62.1700412200392;
        Sun, 19 Nov 2023 08:43:20 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b00331a55d3875sm4397122wrb.38.2023.11.19.08.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 08:43:20 -0800 (PST)
Message-ID: <de04aec0-a195-45da-8951-bb30f2a629a3@gmail.com>
Date: Sun, 19 Nov 2023 16:43:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] merge-file: add --diff-algorithm option
Content-Language: en-US
To: Antonin Delpeuch <antonin@delpeuch.eu>, git@vger.kernel.org
References: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
 <653b08fd-2df3-4a7a-8082-fdb809e87784@delpeuch.eu>
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
In-Reply-To: <653b08fd-2df3-4a7a-8082-fdb809e87784@delpeuch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 17/11/2023 21:42, Antonin Delpeuch wrote:
> Hi all,
> 
> Here a few more thoughts about this patch, to explain what brought me to 
> needing that. If this need is misguided, perhaps you could redirect me 
> to a better solution.
> 
> I am writing a custom merge driver for Java files. This merge driver 
> internally calls git-merge-file and then solves the merge conflicts 
> which only consist of import statements (there might be cases where it 
> gets it wrong, but I can then use other tools to cleanup those import 
> statements). When testing this, I noticed that the merge driver 
> performed more poorly on other sorts of conflicts, compared to the 
> standard "ort" merge strategy. This is because "ort" uses the 
> "histogram" diff algorithm, which gives better results than the "myers" 
> diff algorithm that merge-file uses.

I cannot comment on this particular use but I think in general calling 
"git merge-file" from a custom merge driver is perfectly sensible. Have 
you tested your driver with this patch to see if you get better results 
with the histogram diff algorithm?

> Intuitively, if "histogram" is the default diff algorithm used by "git 
> merge", then it would also make sense to have the same default for "git 
> merge-file", but I assume that changing this default could be considered 
> a bad breaking change. So I thought that making this diff algorithm 
> configurable would be an acceptable move, hence my patch.

I can see there's an argument for changing the default algorithm of "git 
merge-file" to match what "ort" uses. I know Elijah found the histogram 
algorithm gave better results in his testing when he was developing 
"ort". While it would be a breaking change if on the average the new 
default gives better conflicts it might be worth it. This patch would 
mean that someone wanting to use the "myers" algorithm could still do so.

> Of course, the diffing could be configured in other ways, for instance 
> with its handling of whitespace or EOL (similarly to what the "git-diff" 
> command offers). I think those options would definitely be worth 
> exposing in merge-file as well. If you think this makes sense, then I 
> would be happy to work on a new version of this patch which would 
> attempt to include all the relevant options. I could also try to add the 
> corresponding tests.

It would be nice to see some tests for this patch, ideally using a test 
case that gives different conflicts for "myers" and "histogram". We 
could add the other options later if there is a demand.

Best Wishes

Phillip

> But perhaps my need is misguided? Could it be that I should not be 
> writing a custom merge driver, but instead use another extension point 
> to only process the conflicting hunks after execution of the existing 
> merge driver? I couldn't find such an extension point, but it can well 
> be that I missed it.
> 
> Thank you,
> 
> Antonin
> 
> 
