Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34ED11185
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoD6IlQj"
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC63E5
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:49:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32ded3eb835so1008339f8f.0
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698011390; x=1698616190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMuiMxuyXUZFqBVpOr15QmANUa57ErnXdDM01ju2GK0=;
        b=SoD6IlQjisXVBPdO1H3rL3GawEeLZ7v/WM93LWCjzpulE5yVGbtoDJOsWOi7unGM74
         E/Q74+v4E6aiCwQMU4GhzIsw3qHNzzVNiERwO8xzUZ7DsJyvYsuZIWF3Q1CfGo2eb6f4
         fAtmmuxKNR/C/qQtJOPqp45TOt2TJBmm5u2/aXJzrhVd+Wrj/HN7ctb+jt7/vG0TtGue
         QD1PaPiMZPh2aULsbZ0dQ6e6CJMDwCNVt+MpAgjty1GzJPehr5rsfSi4bkrtwjdr0Jnx
         3+EjC7a1q3dwytOWW5EUxEmu0aLtLocJfBq5Gtgo477/LScv9WRC/lMaHT5Ipe/WVVxN
         qYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698011390; x=1698616190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMuiMxuyXUZFqBVpOr15QmANUa57ErnXdDM01ju2GK0=;
        b=ANlg2iWq3EfHsSJiMVo8WbrxtCWbmT76537Be9zKB4+i3NILrSRsMHk/M5Anv0yXSc
         5xMKN+WSmgaiJKMW4WzBQ1krM7Q0H8XWETH3z3U0TMcDt+kKG8pHC01mMf/uaqBYDg15
         2dfQCkSGi21hUXHcQo2lFDGzXTmHVPiqld9Tm9kIOdZuq0XrvJ7ZA2d5yAPsmZ+cCKy6
         a5k9oYcEFIyApNj+zszwJcGe5bePi9en699xw6Zs/pXQrNv+W+BwHU0DdLlD1ArYWfz8
         H403rnRLsvcI7H0CnW7s2A98eql3G6LufhjnNLb1yPrKLn3FSB2XOHj2fOQDZ2Ulntt0
         DODg==
X-Gm-Message-State: AOJu0YzUCQbwZj2xtZb3RmObrd36DCcLMhP3H+0Ke6T3OfVtl+8AUR1T
	V1r3VF9ZhAH5qM+hSs084CkdAwPNOlE=
X-Google-Smtp-Source: AGHT+IESNa3Cf/rAq14fb4fKmfJpuwIGgw6QW1iV4iDE0MnLkp3HKVtWA+LAMxHkqGUlCSJGbbKnGQ==
X-Received: by 2002:adf:e584:0:b0:32d:9a26:4d57 with SMTP id l4-20020adfe584000000b0032d9a264d57mr5911325wrm.20.1698011390051;
        Sun, 22 Oct 2023 14:49:50 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b003233b554e6esm6303743wrs.85.2023.10.22.14.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 14:49:49 -0700 (PDT)
Message-ID: <fe3abed8-6be0-4d77-9057-79c9b7c0795c@gmail.com>
Date: Sun, 22 Oct 2023 22:49:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] log: decorate pseudorefs and other refs
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20231003205442.22963-1-andy.koppe@gmail.com>
 <20231019193911.1669705-1-andy.koppe@gmail.com> <xmqq1qdnseed.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqq1qdnseed.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2023 01:13, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
>> This series is to replace the 'decorate: add color.decorate.symbols
>> config option' patch proposed at:
>> https://lore.kernel.org/git/20231003205442.22963-1-andy.koppe@gmail.com
> 
> If that is the case, it probably would have been nicer to mark the
> series as [PATCH v2].

Thanks, I wasn't sure about that due to the change in title and increase 
in scope. I shall err towards version-bumping in any future such cases.

> Also, can you make messages [1/7]..[7/7] replies to [0/7] when you
> send them out?  It seems that all 8 of them (including the cover
> letter) are replies to the previous round, which looked a bit
> unusual.

Not quite sure how that happened, but I think my mistake was passing 
--in-reply-to to git-format-patch instead of git-send-email.

>   [2/7] is a trivial readability improvement.  It obviously should be
>         left outside the scope of this series, but we should notice
>         the same pattern in similar color tables (e.g., wt-status.c
>         has one, diff.c has another) and perform the same clean-up as
>         a #leftoverbits item.

Okay, I've removed that commit in v2. (I should have mentioned in the 
commit message that it was triggered by the inconsistency with the 
immediately following color_decorate_slots array, which uses designated 
initializers.)

>   [4/7] The name of new member .include added to ref_namespace_info
>         will not be understood by anybody unless they are too deeply
>         obsessed by decoration mechansim.  As the namespace_info
>         covers far wider interest, so a name that *shouts* that it is
>         about decoration filter must be used to be understood by
>         readers of the code

Agreed.

>   [5/7] I am not sure if "other refs" should be an item in the
>         namespace_info array.  If it is truly "catch-all", then
>         shouldn't the refs in other namespaces without their own
>         decoration (e.g. ones in refs/notes/ and refs/prefetch/) be
>         colored in the same way as this new class?

They would, because add_ref_decoration() skips ref_namespace entries 
without a decoration type, so they would fall through to "refs/" and 
pick up the DECORATION_REF type.

>         And if so, having
>         it as an independent element that sits next to these other
>         classes smells like a strange design. >
>         Another more worrying thing is that existing .ref members are
>         designed to never overlap with each other, but this one
>         obviously does.  When a caller with a ref (or a pseudoref)
>         asks "which namespace does this one belong to", does the
>         existing code still do the right thing with this new element?
>         Without it, because there was no overlap, an implementation
>         can randomly search in the namespace_info table and stop at
>         the first hit, but now with the overlapping and widely open
>         .ref = "refs/", the implementation of the search must know
>         that it is a fallback position (i.e. if it found a match with
>         the fallback .ref = "refs/" , unless it looked at all other
>         entries that could begin with "refs/" and are more specific,
>         it needs to keep going).

Fair points. I've rewritten things to not touch the ref_namespace array.
>   [6/7] This is pretty straight-forward, assuming that the existing
>         is_pseudoref_syntax() function does the right thing.  I am
>         not sure about that, though.  A refname with '-' is allowed
>         to be called a pseudoref???
> 
>         Also, not a fault of this patch, but the "_syntax" in its
>         name is totally unnecessary, I would think.  At first glance,
>         I suspected that the excuse to append _syntax may have been
>         to signal the fact that the helper function does not check if
>         there actually is such a ref, but examining a few helpers
>         defined nearby tells us that such an excuse does not make
>         sense:

I've dropped the use of that function from the change, checking against 
the actual pseudoref names instead.

>   [7/7] Allowing pseudorefs to optionally used when decorating might
>         be a good idea, but I do not think it is particularly a good
>         design decision to enable it by default.

Okay!

>         Each of them forming a separate "namespace" also looks like a
>         poor design, as being able to group multiple things into one
>         family and treat them the same way is the primary point of
>         "namespace", I would think.

Fair enough, although the array already contains HEAD and refs/stash as 
singletons. I had vacillated about shoe-horning the pseudorefs in there, 
and was swayed by having a single place to define which (pseudo)refs 
should be included in decorations by default. That motivation goes away 
with all the pseudorefs off by default.

I've rewritten things to handle the pseudorefs separately from the 
ref_namespace array, with iteration functions similar to the ones used 
for HEAD and proper refs.

 >         You do not want to say "I want
 >         to decorate off of ORIG_HEAD and FETCH_HEAD"; instead you
 >         would want to say "I want to decorate off of any pseudoref".

They can now all be enabled with --clear-decorations or 
log.initialDecorationSet=all, or be controlled individually with the 
other filter options.

Thank you very much for the review!
Andy
