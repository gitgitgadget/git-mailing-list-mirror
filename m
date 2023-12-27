Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72C45014
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEEkDfza"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so1937094f8f.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2023 06:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688009; x=1704292809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uMD1FiBG3YfvcEYCquMNNKUogZSRo3OBvWHWY39vGxY=;
        b=GEEkDfzazEF3N4W9zRbRr1vVxDRx27lW0wkMUZ2ADelr/UT/IIEA4pxAJ2/44Qp+y/
         rqarhgzF9om1PF2TawFvKNBD2RORnPXwYbUx3Z2jg0DX9690Q3kNxE0TTNEeSDm++sdd
         Lqyih5Xp8/IWJUM7o6IY7boFKye5imnlPm6XufROJI6PmViHRvxru84aFyjtB55MaZ6n
         YScJ53fe9S1KngjBxcOXQNuQNbxVmDP6dZi9JqNfboe3K9xXF03lQVFn3t3o+zjhEp0Y
         FeuurgqMSdsdSaV4wBsApGkN0GW3I8Xz7uKp52iAeJgTvO+xCbY+rxHIvsWQD9sGc9sP
         7nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688009; x=1704292809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMD1FiBG3YfvcEYCquMNNKUogZSRo3OBvWHWY39vGxY=;
        b=diWlydNIa92vax+awwj1Mh4YE/VbwV9WJo+RVTY7R5PuBetVImMTEwoUhv9e7/Vp1D
         CNN+CGZHy93wWtacwrEMnYNznc7lX9OMJ8l0JTBXdA9pM+et35YlqkxhSjs8dtdtpDtv
         KOQ+hgTv5gW3B3XChJCjcdSVnK79VtYHEwTG1ybCnUh6ePmsT/nGH8dOYEbmBcffc1Ss
         U6b7b3Q0Q7ZVFvW39j4mTVVl4sPSyYswnoBhgzHHezxd/pOnwaURXQAhckgS5olpBRc3
         BiC8AdtSByDMjeCiGdZhvg6n7Ke+jFgeWPntfABWHag0kw4snV6vgY7ZS0WMXskQvBIT
         rpTA==
X-Gm-Message-State: AOJu0YyQsl8P1yE1q7Yv47Vj/Dw/zlS1ZHPcVqM+sYV3hTZGmVCOQXTi
	Bl4LHDFV0DhYSeKshPBsJ6E=
X-Google-Smtp-Source: AGHT+IHoqhFxytxoZL70r6+fjxqJmz8FFbQMku+btZZJjWTOJVWO+SgrsYgHWQMoN0JadCuroYN68w==
X-Received: by 2002:a5d:4d0e:0:b0:333:2fd2:5d2e with SMTP id z14-20020a5d4d0e000000b003332fd25d2emr4518566wrt.96.1703688008450;
        Wed, 27 Dec 2023 06:40:08 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0033672971fabsm14924098wrn.115.2023.12.27.06.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:40:08 -0800 (PST)
Message-ID: <e1e9290f-755a-457c-911b-769a311c47fb@gmail.com>
Date: Wed, 27 Dec 2023 14:40:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Port helper/test-ctype.c to unit-tests/t-ctype.c
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Christian Couder <christian.couder@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
 Christian Couder <chriscool@tuxfamily.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <20231221231527.8130-1-ach.lumap@gmail.com>
 <xmqqsf3ohkew.fsf@gitster.g>
 <CAP8UFD1vC6=7ESx1w7S9Q9P0Bsc+c03wgHToNBaP+ivvm9BKBg@mail.gmail.com>
 <f743b473-40f8-423d-bf5b-d42b92e5aa1b@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <f743b473-40f8-423d-bf5b-d42b92e5aa1b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/12/2023 11:57, René Scharfe wrote:
> Am 27.12.23 um 11:57 schrieb Christian Couder:
>> On Tue, Dec 26, 2023 at 7:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Achu Luma <ach.lumap@gmail.com> writes:
>>
>>>> +/* Macro to test a character type */
>>>> +#define TEST_CTYPE_FUNC(func, string)                        \
>>>> +static void test_ctype_##func(void)                          \
>>>> +{                                                            \
>>>> +     int i;                                                  \
>>>> +     for (i = 0; i < 256; i++)                               \
>>>> +             check_int(func(i), ==, is_in(string, i));       \
>>>> +}
>>>
>>> Now, we let check_int() to do the checking for each and every byte
>>> value for the class.  check_int() uses different reporting and shows
>>> the problematic value in a way that is more verbose and at the same
>>> time is a less specific and harder to understand:
>>>
>>>                  test_msg("   left: %"PRIdMAX, a);
>>>                  test_msg("  right: %"PRIdMAX, b);
>>>
>>> But that is probably the price to pay to use a more generic
>>> framework, I guess.
>>
>> I have added Phillip and Josh in Cc: as they might have ideas about this.
> 
> You can write custom messages for custom tests using test_assert().

Another possibility is to do

	for (int i = 0; i < 256; i++) {
		if (!check_int(func(i), ==, is_in(string, i))
			test_msg("       i: %02x", i);
	}

To print the character code as well as the actual and expected return 
values of check_int(). The funny spacing is intended to keep the output 
aligned. I did wonder if we should be using

	check(func(i) == is_in(string, i))

instead of check_int() but I think it is useful to have the return value 
printed on error in case we start returning "53" instead of "1" for 
"true" [1]. With the extra test_msg() above we can now see if the test 
fails because of a mis-categorization or because func() returned a 
different non-zero value when we were expecting "1".

>> Also it might not be a big issue here, but when the new unit test
>> framework was proposed, I commented on the fact that "left" and
>> "right" were perhaps a bit less explicit than "actual" and "expected".

If people are worried about this then it would be possible to change the 
check_xxx() macros pass the stringified relational operator into the 
various check_xxx_loc() functions and then print "expected" and "actual" 
when the operator is "==" and "left" and "right" otherwise.

Best Wishes

Phillip

[1] As an aside I wonder if the ctype functions would make good test 
balloons for using _Bool by changing sane_istest() to be

#define sane_istest(x,mask) ((bool)(sane_ctype[(unsigned char)(x)] & 
(mask)))

so that we check casting to _Bool coerces non-zero values to "1"
