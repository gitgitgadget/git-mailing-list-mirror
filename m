Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9818AE2
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875543; cv=none; b=OFpdugbk5Y37X7DgSvxDu0ODOSn5U3eEbEUPRvmuhDsSxujhSmR88nUuU0d6+Fo2ReeoBqWSCRfqPVe3hLM70LyywKBTKyCtn1BveguEeTrKxdhVObUIq/act/QVKd1MJJmX8ElOLw16z+owLEwHFOPEiOBGyRuqBvvr6xpur28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875543; c=relaxed/simple;
	bh=MOgjaDpvHzCAZa89qdUwq9ey1Barlq+fosW8mAScqF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhmnqdOZqptWYNOh6JBTqOfc+wFLkvFTWrDa8xO6H1UVdT0vr5FbbSt1xmLdbRzZGVKVxy6nv6p9++BgIaxqz8ty6MZ1nSwXayF0ZOzQBofnDzDGVrZwJpGot4ua4gBsrrIu2mnIIJ22uDNgmJqTuPMbESt8NEGjutwzF1x0bIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Mr1Q3o47; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GNrbmmqJ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Mr1Q3o47";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="GNrbmmqJ"
DKIM-Signature: a=rsa-sha256; b=Mr1Q3o474DlUXSyuluN/4OQGhK+V0gdM+P18+zocxtXevzuy4n6PQw99b4c9MvF3W/6Nm1UqVKwqC+2oMztvp+JYrvJSLGPCevsG+cXQRe0UiaWt/nml5sCns3OJbJ9Ok1jf012GFW0+z+1tGUECKFczrLLJ/li+jMNxPHEjegdp+tdgFtOH8mH6E30fyzbm3ATluzW1fPT2CIdrpiBGdHbIGD6C9rLb8iSwuw1s/By76w6PyUnzMew23ROK9O0hLU6Ie7noexs8mtHqHY0BSSErlEVe8p8mqpp7iv6hQgp8wnRtfBLJbmsFQIeYN5QYabRi2vsW8UgNeYD6Ckznfw==; s=purelymail1; d=malon.dev; v=1; bh=MOgjaDpvHzCAZa89qdUwq9ey1Barlq+fosW8mAScqF0=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=GNrbmmqJzJeVTLeMik9n6K7yavk8oHCciK3PHAYF6DWtkcQ7xAhJ1USJWfqQj4vJlXrTwIhP6r4/xsZ0NLDBlzymD0PwRx8kyWQynzLenGaDdew+y9mEBu+E3gkQ/3JlZO2GmE1yzc43FB1SmJwdBBxHCM7wTeGbqqPfzPAf6+OcgzBIQwJ1adWzOACzGbi7lRPdwDrQGvZ+tLcMrsOZAbQO6+Z+B/tL2xsmNb2ZSzMHW3Dca6nfqBA/mrbxBtTX/blbmTC+ZEAnTFjW2pN8uz2IQ6FJChhXdKefucTvKLHvIcXkxE68a1UuVwnCUztC2LxdxpCxAmNF3Sm5YlFRFw==; s=purelymail1; d=purelymail.com; v=1; bh=MOgjaDpvHzCAZa89qdUwq9ey1Barlq+fosW8mAScqF0=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1845410889;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 16:58:58 +0000 (UTC)
Message-ID: <2a39cee9-1082-48aa-b42e-e12c34fa0e29@malon.dev>
Date: Mon, 13 Jul 2026 00:58:51 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/9] environment: move pager_program into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, pabloosabaterr@gmail.com, cirnovskyv@gmail.com,
 szeder.dev@gmail.com, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260709161145.13349-1-cat@malon.dev>
 <20260712111734.1073514-1-cat@malon.dev>
 <20260712111734.1073514-5-cat@malon.dev> <xmqqy0fg43vf.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqy0fg43vf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/26 23:36, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> The 'pager_program' variable is currently defined as a file-scoped
>> static string in pager.c. Move it into 'struct repo_config_values'.
>>
>> The configuration parsing logic remains strictly within pager.c to
>> respect subsystem boundaries. The read/write operations are simply
>> redirected to the repository-specific structure using
>> 'repo_config_values()'.
> 
> By redirecting to repo_config_values(r), we now enforce that the
> passed repository must be 'the_repository' (due to the assertion in
> repo_config_values()).  All current callers of git_pager() and
> check_pager_config() indeed pass 'the_repository', so this new
> enforcement does not harm them.  However, it paves the way to later
> lift the assertion and allow us to configure different pagers for
> different repositories, which is a welcome improvement.
> 

Exactly.

>>   static int core_pager_config(const char *var, const char *value,
>>   			     const struct config_context *ctx UNUSED,
>> -			     void *data UNUSED)
>> +			     void *data)
>>   {
>> -	if (!strcmp(var, "core.pager"))
>> -		return git_config_string(&pager_program, var, value);
>> +	struct repository *r = data;
>> +
>> +	if (!strcmp(var, "core.pager")) {
>> +		FREE_AND_NULL(repo_config_values(r)->pager_program);
>> +		return git_config_string(&repo_config_values(r)->pager_program, var, value);
>> +	}
> 
> It may be just me, but I would have preferred to see this written
> more like
> 
> 
> 	if (!strcmp(var, "core.pager")) {
> 		struct repo_config_values *values = repo_config_values(r);
> 
> 		FREE_AND_NULL(values->pager_program);
> 		return git_config_string(&values->pager_program, var, value);
> 	}
> 

I see. I think it's better to name the struct 'cfg' so that it is 
consistent with what we did before.

> which will make it easier to see that we are freeing the same thing
> immediately before we overwrite it.  It also shortens the lines.
> For a temporary variable with a very short scope like this one that
> is introduced solely for readability, it is OK to use even shorter
> name like 'v' if you want to ('r' certainly has a much longer
> lifespan that it, and I would probably have preferred to see it
> called 'repo').
> 
>      Side note: we might want to give a hint in the coding guidelines
>      document that a variable with larger lifespan should get longer
>      names, or something.
> 
>>   	return 0;
>>   }
>>   
>> @@ -91,10 +97,10 @@ const char *git_pager(struct repository *r, int stdout_is_tty)
>>   
>>   	pager = getenv("GIT_PAGER");
>>   	if (!pager) {
>> -		if (!pager_program)
>> +		if (!repo_config_values(r)->pager_program)
>>   			read_early_config(r,
>> -					  core_pager_config, NULL);
>> -		pager = pager_program;
>> +					  core_pager_config, r);
>> +		pager = repo_config_values(r)->pager_program;
>>   	}
> 
> Same here.
> 
>>   	if (!pager)
>>   		pager = getenv("PAGER");
>> @@ -302,7 +308,9 @@ int check_pager_config(struct repository *r, const char *cmd)
>>   
>>   	read_early_config(r, pager_command_config, &data);
>>   
>> -	if (data.value)
>> -		pager_program = data.value;
>> +	if (data.value) {
>> +		free(repo_config_values(r)->pager_program);
>> +		repo_config_values(r)->pager_program = data.value;
>> +	}
> 
> Same here.

Thanks, will change all these parts.

Regard, yuchen
