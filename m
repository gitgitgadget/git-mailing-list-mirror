Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+oTejO9"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A519E
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 08:10:02 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c72e275d96so12727781fa.2
        for <git@vger.kernel.org>; Thu, 16 Nov 2023 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700151000; x=1700755800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc2DuOuIyS6jZM7iReYVzX5y0hyHH48xCFpZ5mtdE6I=;
        b=K+oTejO9Rq1BHhQ8QFyzlv6zRBcv/mYem7he5RoyKufiBOZ/ArsB2DbWF2RflUBpGg
         tmJ1dvsTllkkb5c92uYq51DQa6OZHbwgL7U1XKv0KOxXYx1Dv2bGILI6fceG/ZL1ubIb
         xeyH2PU0vR+yVgloC2pDAduBDetqawGtGO28KWuf98hCL2g3CS50s6ltkBNcFa4LQid/
         hbMZipqltdJpzD/JpTNCzYN91VQQnF65OklKnDq6qnCSOuWbofpYz+5jFvO4PipMmgGT
         vDa53aTfSpZSFGa6Xe4XajJu7j7MCTnJOWLMhu9+NYG7BQg4ohAuIycF1quXVwazRHzr
         fFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700151000; x=1700755800;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uc2DuOuIyS6jZM7iReYVzX5y0hyHH48xCFpZ5mtdE6I=;
        b=Bs0suw4S8IO3FxApajscYMLAPDbXd5b4YN75ZoCdL9YwxpKFPLvhJwq66icv0RUglo
         CxL6ZobYa+XFDp38b49q8MEAyMYWO6aqBvEw6gyF9OjIzW8CDiN4G8ByesVTJsP9HRA+
         H+mFZHTsJLd+aG8EpWxKnnIAPrvKeTqI5L26DnqkwEATnswZXo9lYQ/Oyv2Fu+l7coQn
         zmGQp3QE8b+VjsFyW8Zwn4vaKe1ssvxaqA5AJQYP8kOfNvqWfJnOG2D12lVMs+MVpSBY
         +cXQFvS1BbZ/faT28A2j8nXp4vRdeYCUD0KmE3a7/MmGsHz5U5ViH8Si4b0T+Cz5VBKT
         zwlQ==
X-Gm-Message-State: AOJu0Yxh9utGtgNHM68kgaNV5ifri4+ZGaIYJEau7+1B5dfHfOKUo8BX
	h59mpbLXWiJGMBaloStxKfQ=
X-Google-Smtp-Source: AGHT+IEf+ZL3lWgIKLAjQGRvIMj2vbqxr5zYN4L5dI+kUC/XL246k6VpMn3LAnpYgT2X5ukYsp1swA==
X-Received: by 2002:a2e:8614:0:b0:2c7:1ae6:e6ac with SMTP id a20-20020a2e8614000000b002c71ae6e6acmr7044723lji.6.1700151000279;
        Thu, 16 Nov 2023 08:10:00 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003fe61c33df5sm4204390wms.3.2023.11.16.08.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 08:10:00 -0800 (PST)
Message-ID: <7b4c76c3-4a1c-4d78-85bf-7a160a286dc5@gmail.com>
Date: Thu, 16 Nov 2023 16:09:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Feature request: git status --branch-only
Content-Language: en-US
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Ondra Medek <xmedeko@gmail.com>, git@vger.kernel.org
References: <CAJsoDaFX7YdncsTy7UsjxaM1GCKs36-H5RhJ6kzgBUFBJyoGZQ@mail.gmail.com>
 <47fa8400-1e5f-437f-84b8-50bb09580325@gmail.com>
 <CAJsoDaHX3t9bViq0F7gmJPD+PoE-ZqmJS5h=u-W900x9KEMmYA@mail.gmail.com>
 <00033c86-dbd7-4c88-bfbd-8f6766cd66c9@gmail.com>
 <20231114201808.GE2092538@coredump.intra.peff.net>
In-Reply-To: <20231114201808.GE2092538@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 14/11/2023 20:18, Jeff King wrote:
> On Tue, Nov 14, 2023 at 03:02:04PM +0000, Phillip Wood wrote:
> 
>> Hi Ondra
>>
>> On 14/11/2023 12:40, Ondra Medek wrote:
>>> Hi Phillip,
>>>
>>> it does not work for a fresh clone of an empty repository
>>>
>>>       git for-each-ref --format="%(upstream:short)" refs/heads/master
>>>
>>> outputs nothing, while
>>
>> Oh dear, that's a shame. I wonder if it is a bug because the documentation
>> says that
>>
>> 	--format="%(upstream:track)"
>>
>> should print "[gone]" whenever an unknown upstream ref is encountered but
>> trying that on a clone of an empty repository gives no output.
> 
> I think it would print "gone" if the upstream branch went missing. But
> in this case the actual local branch is missing. And for-each-ref will
> not show an entry at all for a ref that does not exist. The
> "refs/heads/master" on your command line is not a ref, but a pattern,
> and that pattern does not match anything. So it's working as intended.

Oh of course, I'd somehow forgotten that "refs/heads/master" did not 
exist so it makes sense that for-each-ref does not print anything.

> I think a more direct tool would be:
> 
>    git rev-parse --symbolic-full-name master@{upstream}
> 
> That convinces branch_get_upstream() to return the value we want, but
> sadly it seems to get lost somewhere in the resolution process, and we
> spit out an error. Arguably that is a bug (with --symbolic or
> --symbolic-full-name, I think it would be OK to resolve names even if
> they don't point to something, but it's possible that would have other
> unexpected side effects).

Yeah, maybe we should look at fixing that - I didn't suggest it because 
I knew it did not work on an unborn branch but as you say there is no 
obvious reason why it shouldn't

Best Wishes

Phillip

> -Peff
