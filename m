Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61473C062A
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085086; cv=none; b=czZo7mz0R3XwQHrojEcXxSpgqIoOrf1Vj4eh5oQqI0lhNB9P65SNLyFcXHdJQezJl1Zj/bzEgoGMZBfq7hvGIfG7pFsititGS9quzq8YiJrw+Ly4KNfTLjixooEb/MNiM6/UjvEm+27EEHsytdh2iqpY5LA4a2/aLcCKw3LQa8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085086; c=relaxed/simple;
	bh=n3k35DU2kuXtwKbZ/nn/LW+JIXhPoEZFFbRyo8w+Fy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzPK0ptScZeJa8XaEGf9Z1I3IDlR1EDVqk1pFXcTMAUkUg59/KvZf7qru0CNpoYe0uesWu2CCkgvRHcD6YxRK4baQ5I7y263Jr3y6w5440zyK1i7FvW04v4YSN3hMy5FjH2QcmvGIEuPDKMTY6U4JVmntkGrSpcEJsVNAsPMZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V63I7c8E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V63I7c8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B691F000E9;
	Fri,  7 Aug 2026 06:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786085085;
	bh=4KwmalpibA2rss7ffax2TuckFlPRi9IT2SsC7qH6RSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V63I7c8E0r2cyABvLft1j4XzZdJAOjjzcJkvQqDpRKfe882iH/UKrFUlm1xg4CQFr
	 1KJui5ZqXngnxy1nekgUiUcYlJYCmT2UjJZ8BAZA5Mtog7gSHCyNPwBvZqRDKj34Gw
	 FaNHzHKsd0q2adiFG9jpuMBDyqNff/slz9Wu0centHfwyQD32m6AesYjKegzCFtGSP
	 FMMR4kNSbgonHbZYEA8nF88UrBJz6VlBF8QA6G2HedgxGr640MAdAzSi/P4aFjmLPh
	 WK6HqyoNWzqicrn37nhq1PMYLy+pwXGSBfIUeYZ5ujXbN1s+5jrKyyU8Q02cATLNOG
	 oy4Twp7Ldj1rg==
Message-ID: <e894cf4e-7df2-489a-a596-96f1d4d95dc0@kernel.org>
Date: Fri, 7 Aug 2026 08:44:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] completion: add 'git history' subcommands
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
 <20260806-history_autocompletion-v2-1-7e60f52a1c20@kernel.org>
 <anV7cHblfmGvbl-e@pks.im>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <anV7cHblfmGvbl-e@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2026 at 08:30, Patrick Steinhardt wrote:
> On Thu, Aug 06, 2026 at 10:27:36PM +0200, Vincent Mailhol wrote:
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index e875787710..7372e2919b 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2137,6 +2137,54 @@ _git_help ()
>>  	fi
>>  }
>>  
>> +__git_history_has_revision ()
>> +{
>> +	local i
>> +
>> +	for ((i = __git_cmd_idx + 2; i < cword; i++)); do
>> +		case "${words[i]}" in
>> +		--empty|--update-refs)
>> +			((i++))
>> +			;;
> 
> This will unfortunately be quite a pain to maintain going forward, as we
> now have to be aware of updating this site every single time we add a
> new option that accepts a parameter.

Do you foreseen such new parameters?

> I don't really have a good idea for how to fix that reliably though, I
> have to admit. Maybe we should just mostly ignore this edge case and
> always complete references, unless we have seen a `--`? That can be
> checked rather easily via `__git_hash_doubledash`.

My toughs are that if such a special case ever surface, we can just
dispatch it earlier before we check for the
__git_history_has_revision, like this:

---8<---
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d313780d8b..786fcb5e16 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2193,6 +2193,15 @@ _git_history ()
 		esac
 	fi
 
+	# Subcommands which takes something else than a revision
+	case "$subcommand" in
+	foo)
+		# 'git history foo' take a file first
+		__git_complete_index_file "--cached"
+		return
+		;;
+	esac
+
 	if ! __git_history_has_revision; then
 		__git_complete_refs
 		return
---8<---

This seems reasonable to me. Once we know what this mysterious new
command would be, maybe we can find a smarter and more tailored
solution, but at the moment, I would not call this a blocker.

> That'd still be a huge win compared to the status quo, and if we really
> care about making this work properly we can still iterate.

Thanks!


Yours sincerely,
Vincent Mailhol
