Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54D6AA7
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un3RHZy9"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E98FDF
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:18:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40859c466efso42847425e9.3
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698751091; x=1699355891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MYKR1kD/3NnONZ7dbDAOGBoOfh9prPZwpMd1/d8aRTs=;
        b=Un3RHZy9TcpKEbdsyLgu79Bf7T9JbVHbC96FTXvWRgMUbcZDiSM0zfCatmhAHo6HBg
         YZQxwlhicnVXwsPSaWhD+wUk+8Yby3apdJYhx9LNsDfxxYeR5TPyc8GD1bgwv2aspvqy
         7a9kyB2vl6aCqdC3yx4h+dVTLmrlUNgEWiH+hG9FolWRVxnyFMRvHu1SfejjpIy8Tovw
         Zfq79OMOuXk4Ydt/S/xOljbHX4odSo0ldnc8nccevdukZNaenWegfH+8UrlvYadXqXY8
         COHfjtvwoqf0aw6mhOxMrrD7mo/xIEv459/X/GXDZBlr3bWyU6goftPLtnEGVFtUdE66
         XTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751091; x=1699355891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYKR1kD/3NnONZ7dbDAOGBoOfh9prPZwpMd1/d8aRTs=;
        b=f8FjZ/okBVCTGwXlxtXePM/pCPHpWhGoQbU9wxamxd+E4RVyd6EOZ4lJbbBXS6y52f
         Dwieq1o+n2jfUi23OgSTFc7VlY1SkohDYIT0OXzabD1uonXh6cP/8pMaRUS8nhO9PqSy
         YOatlBOzbgyBv/7zS/x8gLj73Rb2NzFIuuyyGva7gCuhNKDFVROiUiHUSpmx7QeeLqQC
         K8pZG6S9G1rz3AyFJTyWuuKoC6ZT6Jc/Wua0gKlwiVaADBDbhX2KbP/t06gRK0q+BPdu
         MZ0k1fxT+CkSNkpGOp6i9u8zu3H0E6lUVJ/J5/yzk6zos1ZVibl0n8kWYfym7wB6KWkv
         pEiQ==
X-Gm-Message-State: AOJu0YztmsoT5vxGrkzLndVjUC2QQPuhckHD0PUysY3Pb9/PKBzi8u8M
	Y6d+QHsaLyagGPuWEQKqymMJJkTRqMw=
X-Google-Smtp-Source: AGHT+IGUs8xHSV6aaJPHiGze8V7l7UxT9QP4PmjfPSvruuSDHGnXgzv6K50tvjOfKlJMZ+ajFZAS5w==
X-Received: by 2002:a05:600c:1d0a:b0:408:3696:3d51 with SMTP id l10-20020a05600c1d0a00b0040836963d51mr9871745wms.4.1698751090726;
        Tue, 31 Oct 2023 04:18:10 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id q6-20020a05600c46c600b004063c9f68f2sm1455517wmo.26.2023.10.31.04.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:18:10 -0700 (PDT)
Message-ID: <f59f75cd-1991-456a-9ea6-638b39711bf1@gmail.com>
Date: Tue, 31 Oct 2023 11:18:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] sequencer: remove use of hardcoded comment char
Content-Language: en-US
To: Elijah Newren <newren@gmail.com>,
 Tony Tung via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Tony Tung <tonytung@merly.org>
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
 <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
 <CABPp-BEjV0H=waNQfKNNqibs3g_BU1CCrNjb8G8h_jXrt8kaiw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BEjV0H=waNQfKNNqibs3g_BU1CCrNjb8G8h_jXrt8kaiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah

On 31/10/2023 06:55, Elijah Newren wrote:
> Hi,
> 
> On Mon, Oct 30, 2023 at 10:09 PM Tony Tung via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> Instead of using the hardcoded # , use the user-defined comment_line_char.
>> Adds a test to prevent regressions.
>>
>> Tony Tung (2):
>>    sequencer: remove use of comment character
>>    sequencer: fix remaining hardcoded comment char
> 
> The second commit message seems to suggest that the two commits should
> just be squashed; there's no explicit or even implicit reason provided
> for why the two small patches are logically independent.  After
> reading them carefully, and digging through the particular changes
> being made and what part of the code they touch, I think I can guess
> at a potential reason, but I feel like I'm crossing into the territory
> of mind reading trying to articulate that reason.  (Besides, my
> rationale would argue that the two patches should be split
> differently.)  Perhaps a comment could be added, to either the second
> commit message or the cover letter, to explain that better?
> 
> More importantly, though, I think the second commit message is
> actually wrong.  Before and after applying this series:
> 
> $ git grep -c -e '".*#' -e "'#'" -- sequencer.c
> sequencer.c:16
> 
> $ b4 am c9f4ff34dbdb7ba221e4203bb6551b80948dc71d.1698728953.git.gitgitgadget@gmail.com
> $ git am ./v2_20231031_gitgitgadget_sequencer_remove_use_of_hardcoded_comment_char.mbx
> 
> $ git grep -c -e '".*#' -e "'#'" -- sequencer.c
> sequencer.c:12

As far as I can see those remaining instances are all to do with the '#' 
that separates a merge subject line from its parents. I don't think we 
need to complicate things anymore by respecting core.commentchar there 
as the '#' is not denoting a commented line, it is being used as an 
intra-line separator instead.

> Granted, four of those lines are code comments, but that still leaves
> 8 hard coded references to '#' in the code at the end (i.e. the
> majority are still left), meaning your second patch doesn't do what
> its subject line claims.
> 
> And, most important of all is still the first patch.  As I stated
> elsewhere in this thread (at
> CABPp-BFY7m_g+sT131_Ubxqo5FsHGKOPMng7=90_0-+xCS9NEQ@mail.gmail.com):
> 
> """
> I think supporting comment_line_char for the TODO file provides no
> value, and I think the easier fix would be undoing the uses of
> comment_line_char relative to the TODO file (perhaps also leaving
> in-code comments to the effect that comment_line_char just doesn't
> apply to the TODO file).

I agree that I don't see much point in respecting core.commentchar in 
the TODO file as unlike a commit message a legitimate non-commented line 
will never begin with '#'. Unfortunately I think we're committed to 
respecting it - see 180bad3d10f (rebase -i: respect core.commentchar, 
2013-02-11)

> [...] 
> I feel quite differently about patches that make COMMIT_EDITMSG
> handling use comment_line_char more consistently since that code
> simply writes the file without re-parsing it; although fixing
> everything would be best, even fixing some of them to use
> comment_line_char would be welcome.  I think the first two hunks of
> your second patch happen to fall into this category, so if those were
> split out, then I'd say those are good partial solutions.

I think splitting the changes so that we have one patch that fixes the 
TODO file generation and another that fixes the commit message 
generation for fixup commands would be best.

Best Wishes

Phillip

