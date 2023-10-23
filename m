Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961492376D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP3MkVi5"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3B9B
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:15:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083cd39188so29609905e9.2
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099340; x=1698704140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDUB3ZS92UOY5bgixox5wMjKOl5PF/tUqkLfhGKFKVk=;
        b=ZP3MkVi5asCU4U6LkQHc5sLShGv5vNvuqgnSSM1r3XvzkQdr/pQLT15V27wgrRGlLQ
         4UNU4sTcRhFhjbJ+s98PDzNPXdUYLBxSQutaSLSHGgm8ECajo+xVodW/WYyjkB9ohI6y
         CxjSC5VyPjsVxWIMm/GjxbeiRQ3J2hbxgF5xplI1p9dJJh4YcdQk8oPQLnSe3BuOOfU7
         /JuG8fbLOXZ2fOusm2pbejnqUW8NWAdym/ctuEc5PKmnMAwK9n//8552sFeS2iYZeD/C
         UfWn9Dt7o5QSwz20JQ8BOdmrabecmiEvmptIwlKBtrlDHyoA2FCCAEBVWfp7cinv6S3t
         7rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099340; x=1698704140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDUB3ZS92UOY5bgixox5wMjKOl5PF/tUqkLfhGKFKVk=;
        b=Z1VF8nt2opChWnayJ6FjGQxjVIyH3PpZDRDzEfpT3zwutvNvtK4S8lT/bhgSGCRJF6
         CrselUBGletMoBjyTHHVZeVp/rEihvIPLHZzSed8rYRkffMDRp53a24Hf9p/CMAkKK91
         HwootJz5RgGRxaBbDjh4729YkTca/0QYMqcJ2rlGp9dfb4dYiVBX+NJLA3zhZtUYL2Zd
         8UQ6ETLeHiwQpGQ+/yRhzOymh0XzEBSoxOjJkeqolSEb1jjJAbyRdvPJgrL8oAmxDRvi
         zDlvuWIruxK4y68A1YQ4RGvvMuH//yN9gfjSoVNZEa+FhkiWlYEhseaep5t2T2PY3bZV
         XNvw==
X-Gm-Message-State: AOJu0YxV4vsaO4W7n26qDWfp31+6OOQyN1CxSAbRzUt2aaPSN2Jsnq50
	wBGh13uxczebBRp4ZIqYB/I=
X-Google-Smtp-Source: AGHT+IFCjClYL8lZO9eIdHXmWXmUVnRdg+MMdziQDCIqbWGkchAn02SNk1+cSm0TPNY5bEn9q+N1cw==
X-Received: by 2002:a05:600c:1f94:b0:405:3455:d603 with SMTP id je20-20020a05600c1f9400b004053455d603mr7883862wmb.17.1698099339614;
        Mon, 23 Oct 2023 15:15:39 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b004053e9276easm15293446wms.32.2023.10.23.15.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 15:15:39 -0700 (PDT)
Message-ID: <50a646f6-730d-4d79-84b6-c0ee8be748e7@gmail.com>
Date: Mon, 23 Oct 2023 23:15:36 +0100
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
Cc: git@vger.kernel.org, stolee@gmail.com
References: <20231003205442.22963-1-andy.koppe@gmail.com>
 <20231019193911.1669705-1-andy.koppe@gmail.com> <xmqq1qdnseed.fsf@gitster.g>
 <fe3abed8-6be0-4d77-9057-79c9b7c0795c@gmail.com> <xmqqpm16p4t3.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqqpm16p4t3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2023 01:20, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> 
>>>    [2/7] is a trivial readability improvement.  It obviously should be
>>>          left outside the scope of this series, but we should notice
>>>          the same pattern in similar color tables (e.g., wt-status.c
>>>          has one, diff.c has another) and perform the same clean-up as
>>>          a #leftoverbits item.
>>
>> Okay, I've removed that commit in v2. (I should have mentioned in the
>> commit message that it was triggered by the inconsistency with the
>> immediately following color_decorate_slots array, which uses
>> designated initializers.)
> 
> Sorry, that is not what I meant.  [2/7] as a preliminary clean-up to
> work in the same area does make very much sense.  What I meant to be
> "outside the scope" was to make similar fixes to other color tables
> that this series does not care about.

Ah, sorry for misreading. Commit reinstated in v3.


>> Fair enough, although the array already contains HEAD and refs/stash
>> as singletons.
> 
> But these deserve to be singletons, don't they?  There is no other
> thing that behaves like HEAD; there is no other thing that behaves
> like stash; and they do not behave like each other.

They do indeed, but arguably the pseudorefs are singletons rather than a 
namespace like refs/heads as well, as there is a defined and documented 
set of them.


>> I've rewritten things to not touch the ref_namespace array.
> 
> Well, the namespace_info mechanism still may be a good place to have
> the necessary information; it may be that the current implementation
> detail of how a given ref is classified to one of the namespaces is
> too limiting---it essentially allows the string match with the .ref
> member.  But we can imagine that it could be extended a bit, e.g.
> 
> 	struct ref_namespace_info {
> 		char *ref;
> 		int (*membership)(const char *, const struct ref_namespace_info *);
> 		... other members ...;
> 	};
> 
> where the .membership member is used in add_ref_decoration() to
> determine the membership of a given "refname" to the namespace "i"
> perhaps like so:
> 
> 	struct ref_namespace_info *info = &ref_namespace[i];
> 
> 	if (!info->decoration)
> 		continue;
> +	if (info->membership) {
> +		if (info->membership(refname, info)) {
> +			deco_type = info->decoration;
> +			break;
> +		}
> +	} else if (info->exact) {
> -	if (info->exact) {
> 		if (!strcmp(refname, info->ref)) {
> 			deco_type = info_decoration;
> 			break;
> 	}
> 
> Then you can arrange the pseudoref class to use .membership function
> perhaps like this:
> 
> 	static int pseudoref_namespace_membership(
> 		const char *refname, const struct ref_namespace_info *info UNUSED
> 	)
> 	{
> 		return is_pseudoref(refname);
> 	}
> 
> and make them all into a single class.

That's an interesting idea, but I'm not convinced it would buy us much, 
while also potentially complicating things for any other uses of the 
ref_namespace array.

My premise here is that we do need a list of the documented pseudorefs, 
so that we can iterate through them and add the ones that do exist to 
the decorations, whereby I admit that shoe-horning that list into the 
ref_namespace array wasn't a good idea. If that premise is wrong, and 
there's a better way to discover the pseudorefs, the following might be 
moot.

Sending each found pseudoref through add_ref_decoration() and its lookup 
of ref_namespace would just confirm what we already know: it's a 
pseudoref. Which is why both my initial attempt and the current one 
don't actually invoke add_ref_decoration() for them.

Could you have a closer look at the current design? It handles the 
pseudorefs separately from proper refs, with their own iteration and 
callback functions, which I think makes for simpler more self-contained 
changes than v1 or the approach suggested above.


> Having said that, I do not think it makes much sense to decorate a
> commit off of refs/stash, as the true richeness of the stash is not
> in its history but in its reflog, which the decoration code does not
> dig into.  But obviously it is not a part of the topic we are
> discussing (unless, of course, we are not "adding" new decoration
> sources and colors, but we are improving the decoration sources and
> colors by adding new useful ones while retiring existing useless
> ones).

I agree refs/stash is a weird one, and that it could be subsumed into 
the color.decoration.ref setting for 'refs/*' that I'm adding here, 
which is also why I chose the same default color for it. I'd be happy to 
drop color.decoration.stash if the minor break in compatibility for 
anyone who has customized it is acceptable. The setting would be quietly 
ignored.

Another related thought: the '--clear-decorations' option of git-log 
seems unfortunately named as it suggests the opposite of what it 
actually does, which is to enable all decorations (unless subsequently 
constrained with '--decorate-refs{,--exclude}=...').

Regards,
Andy
