Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4E28FFE7
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770350152; cv=none; b=QFgWX84idCfQ53OVaf52R4ysbpX3SawqtGSl/8uwze0Y6W3lk2G73RH11HqpgB2Q1Fa178Pojl2ozo/QhztzKGrDNl42+qhFtWqvdX7rgYecZCnBqWCRrEa/sRqd9tbg1bO38DsEp7F09Hjvi4r7KIGAjXXzMefXsgCKci09EmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770350152; c=relaxed/simple;
	bh=SP7jFATppIdwjgW6w1Rimj0h2KxUBDl85wp+lUf2q2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kd0XGwepJQLV5XAU77xJ+n7dVOQSqsAsLonV8bFVWxMU63/r15VTRE7I5wj4CzId6gsTZNQK7DBCAVCMufhp3c+ZoYTGfEsXo9wdKV3ylB8wUBAewE/ucUrnAMC9bigiZ2FFVCICjs2mxupogBpTVDR0g7dElvIZZ2+RJV++8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=d2Gk0OsT; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="d2Gk0OsT"
Received: from [192.168.43.16] (unknown [37.168.1.79])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 98582B00539;
	Fri,  6 Feb 2026 04:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770350144;
	bh=SP7jFATppIdwjgW6w1Rimj0h2KxUBDl85wp+lUf2q2Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=d2Gk0OsTHz18wvtxvTV9wW8vs9kpNQmssmWIR1Rhxuqs++A+WODkfADuDYsUhOUpa
	 tZz6Z226A4Wdt3SmibG9n5gXG9AJQ2UIXqjW0av47EHRNWn9wUaeSekz/9AwHKn0Dm
	 QpBBh//zCuJkDCrMr7C9mU1dYCFWPYsomFvlmra2bzTkgSfajV4VNnO1WjARTbUYvB
	 3NcMYExQDK//cCjQDAQo3LbTm+C+WqqI0Ig6O0jP8YCQkjOXcUXLua+IlYkyDU+A18
	 cH9wHy1Xs7p9soo77iei6EuJ5Zv6/XwdDMCccB0hG6QUq5iqDPVKO2R62OV4NhG1ZP
	 zBwnBNZSQADsQ==
Message-ID: <4e15eb56-a6d6-42da-97ba-86367eb9102b@free.fr>
Date: Fri, 6 Feb 2026 04:55:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] doc: convert git-submodule to synopsis style
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
 <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
 <8d22e6952a3c0e20d9cc797e2dcc216591b10e6b.1770138215.git.gitgitgadget@gmail.com>
 <bd07e62d-b185-4d1a-9bb5-7c075d6508c2@app.fastmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <bd07e62d-b185-4d1a-9bb5-7c075d6508c2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/02/2026 à 22:45, Kristoffer Haugsbakk a écrit :
> On Tue, Feb 3, 2026, at 18:03, Jean-Noël Avila via GitGitGadget wrote:
>> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>>
>>  * convert commands to synopsis style
>>  * use _<placeholder>_ for arguments
>>  * convert inline lists into proper definition lists
>>  * minor formatting fixes
>>
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> 
> `Reviewed-by` is a special case. It’s the only trailer that has to be
> given explicitly by the person.
> 
> (trailers that credit other people should also come before the signoff)
> 
> Thanks for the credit, of course. :)
> 
>> ---
>>  Documentation/git-submodule.adoc | 389 ++++++++++++++++---------------
>>  1 file changed, 196 insertions(+), 193 deletions(-)
>>
>> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
>> index 95beaee561..e581b0c7aa 100644
>> --- a/Documentation/git-submodule.adoc
>> +++ b/Documentation/git-submodule.adoc
>> @@ -8,19 +8,19 @@ git-submodule - Initialize, update or inspect submodules
>> [snip]
>>  DESCRIPTION
>> @@ -34,16 +34,16 @@ COMMANDS
>>  With no arguments, shows the status of existing submodules.  Several
>>  subcommands are available to perform operations on the submodules.
>>
>> -add [-b <branch>] [-f|--force] [--name <name>] [--reference
>> <repository>] [--ref-format <format>] [--depth <depth>] [--]
>> <repository> [<path>]::
>> +`add [-b <branch>] [-f | --force] [--name <name>] [--reference
>> <repository>] [--ref-format <format>] [--depth <depth>] [--]
>> <repository> [<path>]`::
>>  	Add the given repository as a submodule at the given path
>>  	to the changeset to be committed next to the current
>>  	project: the current project is termed the "superproject".
>>  +
>> -<repository> is the URL of the new submodule's origin repository.
>> -This may be either an absolute URL, or (if it begins with ./
>> -or ../), the location relative to the superproject's default remote
>> -repository (Please note that to specify a repository 'foo.git'
>> -which is located right next to a superproject 'bar.git', you'll
>> +_<repository>_ is the URL of the new submodule's `origin` repository.
> 
> This (`origin`) is new. I have never used git-submodule(1). Is this
> *code* or is it jargon for something like “original” repository? It came
> in commit ec05df35 (git-submodule - make "submodule add" more strict,
> and document it, 2008-07-09):
> 
>     With this patch, the URL locating the submodule's origin repository can be
>     either an absolute URL, or (if it begins with ./ or ../) can express the
>     submodule's repository location relative to the superproject's origin.
> 
> The "origin" that I referred to in the previous round was this sentence
> a little way down:
> 
>     If no such remote-tracking branch exists or the HEAD is detached,
>     "origin" is assumed to be the default remote.
> 
> And here I read “origin” as a real, concrete name. Which is why I
> thought `origin` would fit instead.
> 

I think both `origin` refer to the name of the remote used when you
first clone the submodule. So, it is a "reserved" word and needs to be
typefaced as a keyword.

>> +This may be either an absolute URL, or (if it begins with `./`
>> +or `../`), the location relative to the superproject's default remote
>> +repository (Please note that to specify a repository `foo.git`
>> +which is located right next to a superproject `bar.git`, you'll
>> [snip]
>>
>> -status [--cached] [--recursive] [--] [<path>...]::
>> +`status [--cached] [--recursive] [--] [<path>...]`::
>>  	Show the status of the submodules. This will print the SHA-1 of the
>>  	currently checked out commit for each submodule, along with the
>> -	submodule path and the output of 'git describe' for the
>> +	submodule path and the output of linkgit:git-describe[1] for the
>>  	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule
>> is
>>  	not initialized, `+` if the currently checked out submodule commit
>>  	does not match the SHA-1 found in the index of the containing
>> @@ -95,7 +95,7 @@ submodules with respect to the commit recorded in the
>> index or the HEAD,
> 
> Nit: There are some remaining “HEAD” without backticks.
> 
> The phrasing “the HEAD” does also keep recurring. Might be worth
> replacing with just `HEAD` at this point?

Yes, will do, for the sake of consistency.


Thanks again for the sharp eyes.
