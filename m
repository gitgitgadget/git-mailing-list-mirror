Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376013;
	b=FFQKOwu7pVJl9wS4yhHviP5wf6ZwQgL70ayPzkGqfjy1dVY4aczoNVrjQWJiPJOCTtZ/
	 TMDQ5tBNMRu5cZPc5dta2lb8Kq+4Lop8doeDSmK+ecLFtGAVO55nU5/ovmhhnh4hzcMty
	 I/yR7VBcaVApGvzCM7NPX+UrgIVX2dS6CXclJTFFzmdEz3VlPF0RqcsPhlLvpPqSYlbcU
	 c+d9m8qg8k+0mLiz27vBFvi+mthf0o0wYsqqlA18K9SKc/JdNloeUEa+34cnmYqUeLW4b
	 xlQA9ITRD/XLMATYIaZtgb10RA419UQILDmO9YFJu9jliu4uUmp3bojwgo00RVArw3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376013;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=g4pvFZhIm/3G+0IzsZFDcB17Fz5uQmV0y532WevwR5U=;
	b=zWEXwKw41UqkzXS3sD2Rt1UQFZVLr6jBudps9a+eWSwkcSviVS/zGpQHpTVtgwnMTEIh
	 QPAeXtQ173UdRtDhHk264MVMs39oZm8hqdAAzriB6DrNCXOMfGrqKP0XVHZT3j34/ZO/p
	 HWh9dA61mvQVF+94OSa06jh8CGJ5PRgC0/KQp4VtodAG4zw4q/nLVFh0bEoP5IIcb0QAB
	 pjwS1U2is8yCiIh3JHEEn1L0Yz8LP4Nqhq+uLMssUsYVnpYcZEJBxJTMZgW6z2mNheg5p
	 57b2Ulz6wMLofs5YSMcLYiDAbRbyalIeRS8H/AZk1ibbTdBSzms+vIYMq8y1s8KSTZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=YYjad+PR;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD75606A31A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 19:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD75606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=YYjad+PR
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMJXQaL2248255
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 20:33:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795376006; bh=g4pvFZhIm/3G+0IzsZFDcB17Fz5uQmV0y532WevwR5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YYjad+PRpLmpZ1OAyAoPooWc5KDyBsLsFCW/j8vjD6KYoZcdh6OtZP7/+VUB1rJYw
	 CdQoVJF+h0/Y0wRFPKfkYQ79ygTn+E1N0ffxUoIK0Bs49JU3L0MeyXt4BVAVJVPymX
	 BteAyaQ8TQyr3WuMMKpR01ILo0DcWzUZ/e8i6ouY=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] doc/gitcli: minor fixes
In-Reply-To: <xmqqv75ok78k.fsf@gitster.g>
References: <20261114201632.103400-1-dirk@gouders.net>
	<20261115070357.113875-1-dirk@gouders.net>
	<CAHWeT-ZvrBXJTJWuLNsw3S_Do-NCF_MxVf80mWbbuoKtxdF_7Q@mail.gmail.com>
	<xmqqv75ok78k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Nov 2026 20:33:25 +0100
Message-ID: <gh5wxomzju.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 22 2026, Junio C Hamano wrote:

> Andy Koppe <andy.koppe@gmail.com> writes:
>
>> On 15 Nov 2026, Dirk Gouders wrote:
>>> Fix three details in the gitcli documentation:
>>>
>>> Use plural/singular where appropriate and imperative form when rules
>>> are listed.
>>
>> The introduction promises a list of three, but only as single point
>> follows. The message should mention the change to the '--' rule.
>
> I somehow thought that "three" was a count of patch hunks, i.e.,
> locations that needed fixes were (1) the introductory text in the
> DESCRIPTION text, (2) a bullet point on argument disambiguation, and
> (3) another bullet point on not bundling multiple short options.
>
> Or perhaps I misunderstood your comment, specifically the "only as
> single point follows" part.  I assumed that the single thing is that
> the patch corrects number agreement and uses imperative for rules,
> and I didn't think the issue you had with it was that there are not
> three grammatical things (they are two).

As far as I can tell, the "three" stands as is:

1. plural
2. singular
3. imperative

>>> - * Splitting short options to separate words (prefer `git foo -a -b`
>>> -   to `git foo -ab`, the latter may not even work).
>>> + * Split short options to separate words: prefer `git foo -a -b`
>>> +   to `git foo -ab` (the latter may not even work).
>>
>> Nit: "into separate words" reads more naturally, although "to" was
>> already there before.
>
> Yes, that does read better.
>
> Shall we mark the topic as ready for 'next' as is, or do you want to
> do v4 with a (hopefully final) small revision, Dirk?

If it is OK to put it in, I can fix the "to", as well (increments to
four, then ;-)).

It would help me to improve on my workflow, so I will send a v4.

Dirk
