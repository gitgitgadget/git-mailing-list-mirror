Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856D2110F
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1BvY3WB"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204520717b3so212900fac.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 03:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704367872; x=1704972672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeUX3iP1DDWosrvVmRmQHZ8bY9QaP+4UXrEoU0Bdujg=;
        b=J1BvY3WB4r+vhOtHkaBD1pvREfhNP/gS5JYunljpsUA356JTrtyeZ8BDaQEdK0D0NS
         a/9FZSauggcj0aZaIsG0xhO8QOESUj7Z5ZQSrl5b/Agfk2Q5eamJiXC+zlqvQ1DLlFTs
         Xs6i5FC2qbcsNxcDTwL6DFqhFtie5xDDc9tmyQfEZhg2BEe6Ktpsw7o9m7NaHw1yjzoz
         NRI7csG8jrceyKrCacSCMwwlX3itR2/c3/6wSvy0JYom8PvRLjEvXZCH8E9MQPX7E9Hs
         c2CF7AKGPxTvwD5PcPxTEILR8g2ZIIFJvbpPtxSOuu/ne6rlhsQJVdrudc7Ppysqg7fp
         HIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704367872; x=1704972672;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeUX3iP1DDWosrvVmRmQHZ8bY9QaP+4UXrEoU0Bdujg=;
        b=bHAooU3tJDjWYIVVKhgbqK40+OxhVXK0IMmzPx/x8SRV0mecRABylaKAEJ+lsJ4L5H
         PUc3yNr+m/iY9dyFVzoJWY2u7dryb+0m5Oo29/hEdPFqXRpyfP36k4bbpNp1DIQHStGg
         lpXrdiwaiuVPd3/KF58RNXUFCSbUFYDUF1+g4zUQU4N+LoTi4Qi0i5lCXllR1NXidyo3
         +B+SeTUABmU0Et7WUY4jXvabnQVxNfC2dm5rbv9d/YEYP2EQS2d/RHnV/UVlSQG3/7xF
         BX0zB0/AORtOAn/Df0b6d2S/x34MlkuFZkN3jXdXfilL68kfnpBEtQYSQ+FshGh22/lK
         iwwA==
X-Gm-Message-State: AOJu0Yy5AS6ZeTPG8bkXjMbn+SDgiY3LUbd2BT6mvl2XioPPg96JZS10
	4BM8fNquyEFBE/kZ3uq6PmNzIoKts1XeseOl9W4=
X-Google-Smtp-Source: AGHT+IHa8/lkmu8koMr5AOhPP4meW4q32SU8UUxm8Vck+X91KUurmOBVMeq4ZnOzlArd7n4G7xQJ/N7P1Z4vYkHzsPA=
X-Received: by 2002:a05:6870:1b13:b0:204:a85:2580 with SMTP id
 hl19-20020a0568701b1300b002040a852580mr501468oab.34.1704367871864; Thu, 04
 Jan 2024 03:31:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jan 2024 03:31:10 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZZWg5JvjQymy2wcn@tanuki>
References: <ZZRaOhK869S1Sg1h@nand.local> <ZZUgUUlB8A-rhep5@tanuki>
 <CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
 <xmqqwmsqbhyt.fsf@gitster.g> <ZZWCXFghtql4i4YE@tanuki> <xmqqsf3ebe1l.fsf@gitster.g>
 <ZZWIlx-9D2r9AfDW@tanuki> <xmqqil4a9vue.fsf@gitster.g> <ZZWbMekL2URby0qV@tanuki>
 <xmqqedey9u32.fsf@gitster.g> <ZZWg5JvjQymy2wcn@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 4 Jan 2024 03:31:10 -0800
Message-ID: <CAOLa=ZStP6F1njTeoQZwN58k+_0r9LT7z-wg2819FWZPq90wQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, christian.couder@gmail.com
Content-Type: multipart/mixed; boundary="00000000000091d169060e1d117a"

--00000000000091d169060e1d117a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 03, 2024 at 09:59:13AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> >> I think we should tighten things up over time.  First by teaching
>> >> the ref backend that anything that is not a pseudoref, HEAD or a
>> >> proper ref (one item of whose definition is "lives under refs/
>> >> hierarchy) should not resolve_ref() successfully.  That should
>> >> correctly fail things like
>> >>
>> >>     $ git rev-parse worktrees/$name/bisect/bad
>> >>     $ git update-ref foo/bar HEAD
>> > ...
>> > Yeah, agreed, that's something we should do. I do wonder whether this
>> > will break existing usecases, but in any case I'd rather consider it an
>> > accident that it is possible to write (and read) such refs in the first
>> > place.
>>
>> Unfortunately, the worktrees/$name/refs/bisect/bad and its friends
>> are documented in "git worktree" and the refs.c layer is aware of
>> the "main-worktree/" and "worktrees/" hierarchy, so while I still
>> think it is a good long-term direction to make it impossible to
>> create random refs like "foo/bar" and "resf/heads/master" via the
>> commands like "git update-ref", we cannot limit ourselves only to
>> "refs/" hierarchy.
>
> Ah, I first wanted to point this out, but then noticed that you didn't
> include the "refs/" prefix in "worktrees/$name/bisect/bad" and thought
> this was intentional. But yes, per-worktree refs need to stay supported,
> weird as they may be.
>
> Patrick

Thanks all for the discussion, I'll try to summarize the path forward
as per my understanding.

1. We want to introduce a way to output all refs. This includes refs
under "refs/", pseudo refs, HEAD, and any other ref like objects under
$GIT_DIR. The reasoning being that users are allowed currently to create
refs without any directory restrictions. So with the upcoming reftable
backend, it becomes important to provide a utility to print all the refs
held in the reftable. Ideally we want to restrict such ref's from being
created but for the time being, since thats allowed, we should also
provide the utility to print such refs.

2. In the files backend, this would involve iterating through the
$GIT_DIR and finding all ref-like objects and printing them.

3. To expose this to the user, we could do something like

   $ git for-each-ref ""

Which is a natural extension of the current syntax, where the empty
string would imply that we do not filter to the "refs/" directory.
It is still not clear whether we should support "worktrees".

Any corrections here?

--00000000000091d169060e1d117a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9544de5debb526e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XV2x2a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3NzQy85U0l4cmVBWDRrQ1ZTWm16aC9kOG5yTkJLTQp0VmlLM0lENTRz
N2tsSnZEL1RQN1JjZTM3NE1FbXhRQXpYdytNU1A0bXdLdnNvditIQUdJc0tGdWtueUN0ZDA3Cnpt
TUR5NWFrQWtXQ09qQ0VDeVNiUDAwZHRiT0JKU05URUNNVnBkK1BlNkhXUFVxUERvTnlmQnNKMGpI
T1dSbTAKQWRXeGE4T01qYkViTWpBUXptWEJaZHJVWVZUWnhTalA1OHdwTUwzODdwQmM2c0xDZDUr
QTVSankxeUhHWmhoMAppTkpZMk5sbm9PUndDak5SSUhHWUJZZERSZSsrbjF2OUxHNHNFbGtBTlhC
VEVsZlNKeEc5cENPMlJWL2tIWSs1CmovT3NheW5rd2JEY2VuZjF0R0VtZkt3NStMdjhxSmEzdzFL
by9DdEhVRVA2SGJwZ1hrSmQ1a2kxeC96OGZ0dlMKK3kvMjltWEVuYUxON0NOM1IwSkRvalpXZFo1
SVhMYjhBZ3h5YWhXNVRib3NrakY3N2dXRzB6bHp2ZHRISTJxOApaTUdzVzJlN3hlc1Y2RHB6RFQv
SXk5SEtXVG5jOEo4NkZBSzR6NlJEWjl1Skp5R1c1MzY1eE5DRTcxa3Jpa25XCkdVaTZvUEVTUGFx
K2g3a2pFTy9yam1sdkk0Y1kwV0FkbGllYk45az0KPU5uS3UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000091d169060e1d117a--
