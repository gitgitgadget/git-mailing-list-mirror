Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08D20296E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960612; cv=none; b=MjSFbvdPPfpuBUJqQhyOc2qaWLrbd4iUzddWm+/EJb8qCckpxQrknmpPH2ntO/Yf0u9bVhBy4itdbWwp3CPU9f6dDgaWic9icDCL0GdbulrORLOVGkYKsWOiA5ClrnT6fj2Gt3K6Hv19bPm+wD/dbY/CKhhDjPt/BJ/j8nZijxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960612; c=relaxed/simple;
	bh=9dsCqLtyEyFH6tO/cyo0FbCkkYI189s3N8VnQ3IbK5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bP3uj2/bdESmQ3Byzf8AZJlLkqtX56R7A8osDapMqgmarndm1asdv7WbnnInT48ZO6gUygDdBlzuj9gE9DyQmbjawTS6qaNhFjpTh1AP8tU7CwMtUETayQ3Cvxh8f+zmV6YfSMDaoUIr0o/d+RENXPuHrluoRLIUA7KUoNVyTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=qOVmllMt; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="qOVmllMt"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 6c9NvheGrIjCT6c9Ov9H4K; Wed, 08 Oct 2025 22:56:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759960606; bh=eclV0xZ30b7j6hkLhHaEAX4DbGqev9A7/vawRXkM9lE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qOVmllMtQtEsUaHSJKNyqlN3pRPMYUApUOnJH8X6QfTw2akzYIB68lpPUJqvjLm9B
	 htgdIJK+5Tjb/dpJlguGomQCoSGRn6Xku7znS4XFbXkDMGz88dgvQVMQWkM+91cPbn
	 34trdJtlqOcRHVY5E+mUzmGQJo5nkkpLeay8OTHbGvtyCRPR7+h/wmBznvbiQMfZ7U
	 0RsD7DkTw+6/l9E/YvIiQZfA8bQl6Jlx1WfyS8bL5ksa8oa/ysqFhW6iVVVkBZTNnn
	 REZHFACEoXeYTYIMoqqiUvmr+sNp0aTjO/INMTHe5CHp2Ub2njlHKxVA1jj39vRKqF
	 dZ5dr3ai61uug==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VvaAAP2n c=1 sm=1 tr=0 ts=68e6de1e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=-TWQbYnkkKoubXSScKsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <8e3aba11-90d7-4336-9cd4-b1fb4144bf69@ramsayjones.plus.com>
Date: Wed, 8 Oct 2025 22:56:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] doc: add some missing technical documents
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
 <20251002221233.541844-2-ramsay@ramsayjones.plus.com>
 <aOYImjMXcFkdwar5@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aOYImjMXcFkdwar5@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMPVw6a/EcJ8HD1cDungtJD9ZuDs+jgq7dVFl8RapCj4xNFqvuxCrxeRXfg0AVPld5pq5BQxFA6T2UYp7WKa7AecooyecHJ28/ObX6+iv2nnl/f4wUJS
 IDyKrz9eb/HFbOJzr/n5Z51e8dsiuK0eLP6xKnZhJnycgxDjw2p3hWgk+1L9ihx2o3ZflBKCJ7GX+Rlh5XOEcKt5k+YMq332210=



On 08/10/2025 7:45 am, Patrick Steinhardt wrote:
> On Thu, Oct 02, 2025 at 11:12:13PM +0100, Ramsay Jones wrote:
[snip]

> This builds on our existing linting rule and would catch any discrepancy
> in man pages that we have in "Documentation/technical/" that isn't
> listed in Meson.
> 
> This check isn't quite complete, there's two things missing:
> 
>   - We have an equivalent check in "Documentation/meson.build" that we
>     might want to extend to also cover articles.
> 
>   - We don't have a check to ensure that our Makefile and Meson are in
>     sync.
> 
> But regardless of that, the above check surfaces one more missing
> article:
> 
>     $ make lint-docs-meson
>         GEN doc.dep
>     make: *** Deleting file 'doc.dep'
>     tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc differ: byte 3877, line 206
>     Meson man pages differ from actual man pages:
>     --- tmp-meson-diff/meson.adoc	2025-10-08 08:42:49.864991169 +0200
>     +++ tmp-meson-diff/actual.adoc	2025-10-08 08:42:50.072988794 +0200
>     @@ -203,6 +203,7 @@
>      git-worktree.adoc
>      git-write-tree.adoc
>      hash-function-transition.adoc
>     +large-object-promisors.adoc
>      long-running-process-protocol.adoc
>      multi-pack-index.adoc
>      packfile-uri.adoc
>     make: *** [Makefile:526: lint-docs-meson] Error 1

So, it has already paid for itself!

Thanks.

ATB,
Ramsay Jones


