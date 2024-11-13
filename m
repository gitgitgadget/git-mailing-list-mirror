Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20C17C22E
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485548; cv=none; b=Cz6N5xrtdtqYhDpc5Zv1DcPWlt7QqpbeFQrlrDmg9w6F8Ayw/Jk6SYBIg3DQjveh6IM17j0Q6FCs1ek/xKU9epsWCOXqonBI01oWj6KoYb2SZ0k4Ta+sgcUDmfCrIHqIC40TxSb8jvN5AamIfEfceiltKYKYvX5kUkebsQ81X/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485548; c=relaxed/simple;
	bh=SPMZchbDKIld4rTfXObXZEEMB6pZluIocsuC9xHumpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK+bjnBkA1H/9AU1D+f6nsNs7/iVzIJm5tAwp3nS/c57Yu9YTz5gzI6UoVZvItS0MzkC7Ols98lOj8A4CYtrf2fykDSvGnd7LzBCNQCiVvsdRM4krH59hKTssjZGb0kCS4ZrBQkFoPJHJEwGAyNcvVAlcq6MuEwsDpSrE/0a3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=d0jrEkxR; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="d0jrEkxR"
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 0AC1B6012F;
	Wed, 13 Nov 2024 09:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1731485544;
	bh=SPMZchbDKIld4rTfXObXZEEMB6pZluIocsuC9xHumpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d0jrEkxRS/Vkb6LNYa8NYCLzdnqZveuK8GqcGWLWW3Hd8iL4O71lyRt/3hvs5JRFG
	 H0Fv83NVmrOlG5I+FgeswOo//aX0ezMpwyhEFIDDcb1U6qqbChxqZ070qAVYMdAWFY
	 PbWz2M0N/mMeJRpk6QQhLYfFvUgNGDk+1zUz4EAqeA+D3/aBFgGG3NkdknOZiUZNsy
	 JA0fDFrZ/WzSmFr/rOU5Tn7M/n/v6kqI/ZMEgrhMPilcD1wCRQJolnKAK6j3Pr3+3g
	 DYitEGHQl9eFi3xURZHWhNltO1Q6Qlb3SX/tjq1WNmaLY+LkcNyPX0PEO5h9Cgz65r
	 aJB4WDyZ3ul/A==
Message-ID: <56d27d4d-d1d1-4341-92c0-f12e60ee083e@free.fr>
Date: Wed, 13 Nov 2024 09:12:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] doc: git-diff: apply format changes to config part
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <17a2f028d59a0097e92229c2b934a69974691e79.1731343985.git.gitgitgadget@gmail.com>
 <baeb6c64-eb6f-45ab-ac11-0896dd0adcae@kdbg.org>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <baeb6c64-eb6f-45ab-ac11-0896dd0adcae@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/11/2024 à 19:51, Johannes Sixt a écrit :
> Am 11.11.24 um 17:53 schrieb Jean-Noël Avila via GitGitGadget:
>> @@ -1,18 +1,18 @@
>> -diff.autoRefreshIndex::
>> -	When using 'git diff' to compare with work tree
>> +`diff.autoRefreshIndex`::
>> +	When using `git diff` to compare with work tree
>>  	files, do not consider stat-only changes as changed.
>>  	Instead, silently run `git update-index --refresh` to
>>  	update the cached stat information for paths whose
>>  	contents in the work tree match the contents in the
>>  	index.  This option defaults to true.  Note that this
>> -	affects only 'git diff' Porcelain, and not lower level
>> -	'diff' commands such as 'git diff-files'.
>> +	affects only `git diff` Porcelain, and not lower level
>> +	`diff` commands such as '`git diff-files`.
> 
> A stray ' remained on this line.
> 
>> -diff.srcPrefix::
>> -	If set, 'git diff' uses this source prefix. Defaults to "a/".
>> +`diff.srcPrefix`::
>> +	If set, `git diff` uses this source prefix. Defaults to "a/".
>>  
>> -diff.dstPrefix::
>> -	If set, 'git diff' uses this destination prefix. Defaults to "b/".
>> +`diff.dstPrefix`::
>> +	If set, `git diff` uses this destination prefix. Defaults to "b/".
> 
> You are applying `backticks` to possible values such as `true` and
> `false` later. Then these `a/` and `b/` should also be set in this way.
> 
> -- Hannes
> 

Thank you for your review. Will fix.
