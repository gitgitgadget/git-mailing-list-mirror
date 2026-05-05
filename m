Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEE3F7A97
	for <git@vger.kernel.org>; Tue,  5 May 2026 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975866; cv=none; b=YkUypPZVzKah5f13OGgwikP1Dv10wKBdeoMjHtwPUnVe5HUnRoibSus2C83phEvRMIO26FjFzL9bNwQINdF3mpBWgoEL53I+480PTlQOX4M5krfAjl2vUUmwEB8i4izSKhJLxCP/2D+vaJ0WlP9EtKE7qEOorO1WIGSrV9HSDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975866; c=relaxed/simple;
	bh=gByaOQJvskuBnJoufiDxICAuSdbAEoj10ziIaAzdeDQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=TUu2OYH8AlKJc9pcnibGJjYjdZfznI0NhMk9SWPIis0Dt+pl8vn/TrIRfq9R6kSdeEq6LjSyy4lJgHZ4Ro9zBePlQPNAB4kDLBbZgE81I75up02BBsOfo9/pz7bxuo0P9gO4vtmRJvrtURtbQZwMlx0n4nGUhCgWwYJZuvwGZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1N2VKr-1vJcqN0vjb-00zzc1; Tue, 05
 May 2026 12:05:36 +0200
Message-ID: <0076773f-85c5-475b-96c7-bd85c9e5699a@anselmschueler.com>
Date: Tue, 5 May 2026 12:05:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Re: Git maintenance fails without meaningful error message if any
 remote is no longer available
To: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <0f3ef394-d96a-42f2-825d-53cb475a2363@anselmschueler.com>
 <5e3bcfdb-d3aa-4494-81d6-15b0dfd43af1@gmail.com>
Content-Language: en-US, de-DE
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
In-Reply-To: <5e3bcfdb-d3aa-4494-81d6-15b0dfd43af1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yjqJLHQKKY77wvADgZNSeQ9uHv5Elw+1/2RWqypRNy29WOQ3bcv
 8tOvOZSJqDwxwUYuAbDyI9ea89o1tXpO/7lS3kAyL3pkXI2sAnR4xA6ba4FYWGEg4972Br8
 kayVN6SlDGzueiExWIx3MYPOjSYCF7UsIdcgwleZV2rJTNZRRlnTZY2H/Pb3c3fChdczFKj
 k/F7ccVgQgjoNq6cOW9Og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:klSnxIbDz0g=;SKxkwWd8ARHBHo2jutyhnO4ISte
 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
 =

[ This is a duplicate message because I forgot to hit Reply All the last 
time ]

Hi Phillip,

I think there may be a misunderstanding. My current systemd timers do 
use --keep-going. The issue is that on the individual repo, 
git-maintenance won’t fetch other remotes if one remote fails. 
--keep-going will ensure that the other repos get processed, but the 
repo with the failing remote won’t fetch any remotes after the failing one.

At least, that’s what appears to be happening from the output of the 
command.

On 05/05/2026 11:59, Phillip Wood wrote:
> Hi Anselm
>
> On 30/04/2026 00:13, Anselm Schüler wrote:
>> I have a repo with multiple remotes, one of which no longer exists. 
>> When git-maintenance runs on it, it fails during the prefetch stage 
>> because that remote doesn’t exist anymore, and gives a mostly 
>> unhelpful error message:
>>
>> $ git maintenance run --schedule=daily
>> ERROR: Repository not found.
>> fatal: Could not read from remote repository.
>>
>> Please make sure you have the correct access rights
>> and the repository exists.
>> error: failed to prefetch remotes
>> error: task 'prefetch' failed
>>
>> I think that
>> 1. git-maintenance should report which remote it’s encountering an 
>> error on
>> 2. git-maintenance should continue fetching other remotes even if one 
>> fails
>
> Since c75662bfc9 (maintenance: running maintenance should not stop on 
> errors, 2024-04-24) which is in git 2.45.3 the systemd timer files 
> installed by "git maintenance start" use "git for-each-repo 
> --keep-going --config=..." to avoid this problem. Unfortunately we 
> don't have a way to automatically upgrade the timer files for users 
> who ran "git maintenance start" before that. I think if you run
>
>     git maintenance stop
>     git maintenance start
>
> It will delete the old timer files and install the new ones. If that 
> does not work you'll need to manually edit the files and add 
> "--keep-going" to "git for-each-repo".
>
> Thanks
>
> Phillip
>
>> Now, on my system, the systemd timers for git-maintenance use 
>> git-for- each-repo. Not sure if that’s upstream behaviour or 
>> something Nix/home- manager does. But if it is upstream behaviour, it 
>> would also be great to report the repo the error comes from, since I 
>> basically had to guess right now which repo was erroring. Luckily I 
>> have only three repos under maintenance so that was fine.
>>
>> Let me know if you agree that this should be done. I would be open to 
>> writing a patch (no promises though)
>>
>> Anselm
>>
>>
>
