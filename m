Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIl5JJHQ"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1F19D
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 07:05:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f78dcf036so1311554f8f.0
        for <git@vger.kernel.org>; Thu, 16 Nov 2023 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700147122; x=1700751922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LfqNC+OD21KMb+qmibQ3nwyX/pZPCxczZxX7BAiCOdk=;
        b=dIl5JJHQYA3kASGXhyamBel16XIdGzX3kTibdL/nbodyDBDMlIkQThVK0wUkTByixB
         iKGDYcyJMBrfLfSQewwpwaQ8hD4Vp67ytMhPD24LykyOc4NiDI2IAqrhlNUKcTyaZXs2
         FXPH5xBtXHNwi2+Myk0BjfYj/3DoGwFIwcVEHuqejzsRzCbk6taFXdvMKvn99KOGmRzc
         KjKEOkEHuQ9F89wn19qpbOsiA0QsmTi7Gk7rgJmxuj8NpZWWee4vMJFpAvyQoYdUqFGU
         E25YFC3hFQ7k5RIibSQCHvNMdm3Pwh4Vjl7kn9d0KFMCGIbSoAOFzcvRKvu1ITkoLMHc
         I96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700147122; x=1700751922;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfqNC+OD21KMb+qmibQ3nwyX/pZPCxczZxX7BAiCOdk=;
        b=WMivX/xMpvLgTI3RP8Fx/3yMqEg78MPL9TtYGUhlKASXfthER3MaWaleHdyzxKh1wS
         1tS/5rBiJLmBR53n9yeQktdt+gjDk4ipX8TRYChPzl8YgrhdkC8ppzF6R0H3D2ILW9Ux
         UkrWGJC3iW2mmz/KbCvvkKWPnftdr8j5ojbrDrlEzRvJIGXI8MFvfJGlb9yyV3H976Ud
         ruy9F5X1IS4XE/2Go1ypX5xcS6+xLxNWVNM8IdhVdcgmGBbCKuzMxlopwhfgTUTHoZ6z
         roMlqyf0Nzm+2XQ8qil1cmCWhyXU56B+J7/05IromUr0s7woLUG60b5gwN0XcVDA7l7k
         3yJw==
X-Gm-Message-State: AOJu0Yyt+Gl8flLS6sSeMf7SojfuoJ4Lm/yRTu6mGNIRMYehwjbIpfuw
	HcVyFM5/NLAxulqKPMzmY14=
X-Google-Smtp-Source: AGHT+IE7aqj1dh6FqvcFs088RPXE1swgnyMFJs2dPnErHqX7aSuQRL5jm+Rswx/iiJ3GOCyxSEydWw==
X-Received: by 2002:a05:6000:2ce:b0:32f:811c:dfc4 with SMTP id o14-20020a05600002ce00b0032f811cdfc4mr2507027wry.4.1700147121888;
        Thu, 16 Nov 2023 07:05:21 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id j16-20020a056000125000b0032f983f7306sm13846613wrx.78.2023.11.16.07.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:05:21 -0800 (PST)
Message-ID: <4d5f5b5f-d30e-4edc-976e-f11e837545f6@gmail.com>
Date: Thu, 16 Nov 2023 15:05:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Feasibility of folding `unit-tests` into `make test`, was Re:
 [PATCH] ci: avoid running the test suite _twice_
Content-Language: en-US
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Josh Steadmon <steadmon@google.com>
Cc: Jeff King <peff@peff.net>,
 Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
 <20231113184909.GB3838361@coredump.intra.peff.net>
 <ZVU4EVcj0MDrSNcG@google.com> <850ea42c-f103-68d5-896b-9120e2628686@gmx.de>
In-Reply-To: <850ea42c-f103-68d5-896b-9120e2628686@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/11/2023 08:42, Johannes Schindelin wrote:
> On Wed, 15 Nov 2023, Josh Steadmon wrote:
>> On 2023.11.13 13:49, Jeff King wrote:
>> We could bundle all the unit tests into a single shell script, but then
>> we lose parallelization and add hoops to jump through to determine what
>> breaks. Or we could autogenerate a corresponding shell script to run
>> each individual unit test, but that seems gross. Of course, these are
>> hypothetical concerns for now, since we only have a single unit test at
>> the moment.
> 
> I totally agree with you, Josh, that it makes little sense to
> try to contort the unit tests to be run in the same `prove` run as the
> regression tests that need to be invoked so totally differently.

FWIW that's my feeling too. It makes sense for "make test" to run the 
unit tests, but wrapping the unit tests in one or more shell scripts 
adds unnecessary complexity.

Best Wishes

Phillip
