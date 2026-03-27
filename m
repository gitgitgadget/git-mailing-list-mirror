Received: from mailout-006.p.bluenet.ch (mailout-006.p.bluenet.ch [138.188.174.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD9819B5A3
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.188.174.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630830; cv=none; b=ObIQnA0jbct9mCafX3DmoPRmd9rfpFWwfRG+9neMScDBRBXtgRRZH+BWd/LAcOyO2jEFDyhgkr+fE/cC1iGd+z3GuDE7/MaNtDLfQ38+9LFPx3kl2+qEEgAyyKVoeDsXlcZNqDaJN/r5Qn/vCBpSLe6PEQKoaN60l0MJroCgWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630830; c=relaxed/simple;
	bh=R4hD/F28BOnE+toio/ySMk2xUuyIYDkHISZahE2RIvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFZzYjWx6TAq19aaKR9caFLcy2XoxvSrb2uZbUCx2jRGjcVfalmWNxK/8ChDJa3DkN3dUTjLmWxBd0iJumnl+KRnnCBjXr7X2nV1z4tBq30KOqqsQxwD1F0hHTkICk9GRVc7acxxWaRTtYTQ9lmzumaRQ53gtjuB44KcwyygStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch; spf=pass smtp.mailfrom=bluewin.ch; dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b=WSMqKi3W; arc=none smtp.client-ip=138.188.174.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b="WSMqKi3W"
Received: from [192.168.21.108] ([79.154.91.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by mailout-006.p.bluenet.ch Swisscom AG with ESMTPSA
	id 6AVow5BBotv3m6AVowKDZe; Fri, 27 Mar 2026 16:58:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluewin.ch;
	s=fxzs-2048-20230414; t=1774630700;
	bh=XO/NstI4xIA0OIpp3jEUQl85186R/1IEIRXDPJpY93w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From;
	b=WSMqKi3WZUP5BzWCuzXZAhHG74EhJQxWKMDscxiWEz3RdlbQYb2bUO7J5jnJgX01o
	 kTOTIw0viZY0be1GztzUeYpyKJxWxs/rvWcPGv6yk2D/++fuHfiEV5lwJQKzgAwcTS
	 Do4vxXOPhC9JbACGrU9b6LAidktp+KrgUPasLsuNGSy3f1J/K/teZ57DTFVyzU/bbK
	 GurTxxE6kAVNcdlk8UU06JLWnLWi87R6Wiy0kPM6VSPG93yPaCH8q2PkUkikc0sjjQ
	 xBMCZIt159SCIDKPy938Z6zUv7WrFFv22Y9URFf3MurOaWCR1S/yHHAklkVnSXti7J
	 Ev/gcnRVSYn/Q==
X-Bluewin-Spam-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=69c6b72c
 a=WY6/0jjk7zsOyTa5/3SlqA==:117 a=WY6/0jjk7zsOyTa5/3SlqA==:17
 a=IkcTkHD0fZMA:10 a=2cTOc3AzRvBP1PVPd8AA:9 a=QEXdDO2ut3YA:10
X-Bluewin-Spam-Score: 0.00
Message-ID: <9d0befb7-4f2b-4b47-bf9c-784fcacfe418@bluewin.ch>
Date: Fri, 27 Mar 2026 17:58:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix git stash grammar
To: Junio C Hamano <gitster@pobox.com>
Cc: Mirko Faina <mroik@delayed.space>, "D. Ben Knoble"
 <ben.knoble@gmail.com>,
 Quentin Bernet via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
 <CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
 <acXIl2cuBv0ifiK6@exploit> <xmqqqzp5mfh5.fsf@gitster.g>
 <fbe531eb-b742-4cd1-ab6a-2eaaf8d236c5@bluewin.ch>
 <xmqq7bqxkyd5.fsf@gitster.g>
Content-Language: en-US
From: Quentin Bernet <quentin.bernet@bluewin.ch>
In-Reply-To: <xmqq7bqxkyd5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCyPKycL5rBN9/wM4NOtrzMie6CpjU9JUUGOwycElU10N0hI2GVgViZwbp41FGdEGJA6e0htqINnzwhl/konGglLpVToKcDGPZXKzO6tZUIGv9wOwri6
 T7fOSYQnouOcOjao7NbuBV3RzCAOu2mYu28kZVCxKRtkGP75NIEHzVnsh987KEce1m6yny4rqUS58/6QdkuIgTaouj5zrPqUbMrKdSKL9YXOgpUMM53a/DkJ
 SBtmWe3QfMcZuhW4PFSmD6udgNQCisB6sEiqWLzoj2cb7dwbYxNkXqs7NzrzWikxZRA7Qm5i8iasq/sTbjBMTvhOEBSenaXwJNECfA8eApM=

Just so we're clear: my previous grammar did allow "git stash path1 
path2" (no "push", no "--"), which is not allowed
Do you still think it is good enough ?

"the command line description needs to mention that." that is already 
the case, no ?

On 3/27/26 17:53, Junio C Hamano wrote:
> Quentin Bernet <quentin.bernet@bluewin.ch> writes:
>
>> My previous, simpler, grammar included "git stash <pathspec>" even
>> though it is not valid.
> "git stash -- path1 path2 ..." is valid and is taken as elliding the
> subcommand name 'push'.  So I think your previous one is good enough
> but the command line description needs to mention that.  Double dash
> is used to signal the start of pathspec when ambiguous, and it is a
> good example to highlight when it is useful.  Without disambiguating
> "--", "path1" might be misspelt subcommand name but we cannot tell
> which one.  You may even have a file whose name is "pop", and "git
> stash -- pop" would be a way to save away the changes to the file
> without having to say "push" explicitly ;-)
>
