Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E4189
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960885; cv=none; b=DgtwVp6Ki03JF3QQBlt6btmQO66TGscFSwA8dVGCQHn/cXophkfl0S2+uU9RKeCqEoRdlTnkTXGylDrJ8UKJPMvpL9RCFk4uhIZ3YFYz+44xB1fwu3sx64E8awU90AXM7l8qVyY4WGiR6hRwCFwGRsqzU4i93htFffmX5BWC+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960885; c=relaxed/simple;
	bh=J661yyTs3ZanyuxrApU8YOzlx1mYh16FiSRFxkNAqyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eY2+uWPLxwMagafk3Z4nlF/DVlkhoGN0IWGy5V7R2yBpGTjKB9f0LEimTA+0T7LVzsaSq0Es5SUI5M/JBAl+B3gGf2DWmYfAsp03nPTJsZ+s1bWoeKdcsujQq1YsV+mPmpQm6dZG/2vWcs5Nt5bs+8ALJfEvmR92pg0nnX7kAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=mUNHRIqQ; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="mUNHRIqQ"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 6cDmvhelbIjCT6cDov9HDL; Wed, 08 Oct 2025 23:01:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759960880; bh=cv0ahaLY/+BZQ0xEfjXPGVbR0mw/HQ93mTZgyxSLkdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mUNHRIqQxsCV9k/U1O6S0E64cJ1QzEGRSuWzaid7bzjBfRbPsyDYJW1GwZFsDFFeA
	 5jCUewzNK3lRKs1/p/b4AAhiyT4u0+sG3AuCKguu8o6RfgqFaMJKq+L/qRLMWMnJtc
	 lYvxr2/6nJgmvuQ/hNE6oYXM1OROXiB0LD6oT8Vm1XcloJE8Cd9fg4gv/ciy2HOHr8
	 PdwXriB3cqgDuQegtmhj1r3jbxdQqwaiQVgxLEV0er4svg/1L7TH5X5UlwMhf5SXYO
	 xtvc6Ix66NvyDFNmCtqIH9ryKENTy3Yk5QD9iW5mBpwYft89/dgEoalexEYEO3z530
	 h2zrp5OnPqRoQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VvaAAP2n c=1 sm=1 tr=0 ts=68e6df30
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=6l1BkdlvHZTo7QUaLvYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <3286707e-8cc0-430e-a2d3-546352d50b6d@ramsayjones.plus.com>
Date: Wed, 8 Oct 2025 23:01:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] doc: add some missing technical documents
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
 <20251002221233.541844-2-ramsay@ramsayjones.plus.com>
 <aOYImjMXcFkdwar5@pks.im> <xmqqfrbtfcbv.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqfrbtfcbv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKgFxkVeln1wPoYB4+8tJdFgXRx+5Z5ShTqLYHlDslSUY70JPJoPWKzTkrTxPsq6sJBwA9dPZvJd/j5QtsC8uHh1QrJ9RQBYqirxXd9XWE2orvL0DjU+
 m3suT13fCaOAXGr7yPuScaA3ZrosB5nKUchKYUfeib1VfyOC5m+F1nvyx42KUa7uB9MoYVZpxp/zDyLamIjWRo/EMiC518AmoJE=



On 08/10/2025 8:00 pm, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> This builds on our existing linting rule and would catch any discrepancy
>> in man pages that we have in "Documentation/technical/" that isn't
>> listed in Meson.
> 
> Yeah, I remember the existing check helping me spot potential issues
> in a series or two.
> 
>> But regardless of that, the above check surfaces one more missing
>> article:
>>
>>     $ make lint-docs-meson
>>         GEN doc.dep
>>     make: *** Deleting file 'doc.dep'
>>     tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc differ: byte 3877, line 206
>>     Meson man pages differ from actual man pages:
>>     --- tmp-meson-diff/meson.adoc	2025-10-08 08:42:49.864991169 +0200
>>     +++ tmp-meson-diff/actual.adoc	2025-10-08 08:42:50.072988794 +0200
>>     @@ -203,6 +203,7 @@
>>      git-worktree.adoc
>>      git-write-tree.adoc
>>      hash-function-transition.adoc
>>     +large-object-promisors.adoc
>>      long-running-process-protocol.adoc
>>      multi-pack-index.adoc
>>      packfile-uri.adoc
>>     make: *** [Makefile:526: lint-docs-meson] Error 1
> 
> Good.  I'll expect Ramsay will handle this one in v3?

OK, will do.

Since patch #1 is already in 'next', do I effectively create a new
patch series out of patches #2->#4, plus this new patch?

ATB,
Ramsay Jones


