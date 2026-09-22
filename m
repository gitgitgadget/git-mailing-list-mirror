Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242C284B37
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083565; cv=none; b=UYedkqPrp2zJ5GPjN54E8OpjRAu7eirF9EPHJr+u9Gjg/Jaz2Spo2JlJ7Iu1sjl5ANi/CHkpdeQccIvgPrgNzL9Kf3svTmkxlbmAMQ/uSdKbvprv2oHjaVs3dfzMCyIh4CTmp5wrm+cYsc7EnIpaoXp+O7xihlst/qweYITubas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083565; c=relaxed/simple;
	bh=SCq5zguWSWp3ClDRGPIVQ0TdS1tFdKjDdcaWFaTfNe4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=agA/zfgotBgK0y/2dsGF4tcIHxE+8VxYLzE2UkQb1oO4Vos+TJpncP3kA9XgFehYix0UNcIWRrJOUVtbYtiZkn9bEK4eTDr4R3qvbLjo4LtsbSY8oMfF0ZvqXnJp/crgv9WdtmDquBPcV2ZMlX/YjaLFJF5N18X1o62s+owYqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=HLRwQ7me; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="HLRwQ7me"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790083558; x=1790688358;
	i=johannes.schindelin@gmx.de;
	bh=L92PUprcXwJtmbtOZ9/FBuTTmeu++DYFjiA7Z2iWhT0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HLRwQ7meWJ6/F/NDBvm2iygX9Pjc408RBZ9tjZZRItvOJpKoWb3nzVa5gjPOBkKt
	 ChM01Xbo3m4wwp4WAXuVOJ843WAOyvnrpzsImhscOy2USwpzF2iY8KwK6mMRtoamC
	 mD3tS323bX3c+BhFFlYDAISNbgC1msq74/emybYLTfRFa2ZSWCQ0nq/yGOOuW3J/9
	 5WCz/1sSEf93gHphPnH5Ru1zFN/0CgYkFbYzOCsQ12DHLyvXtoGFB1PYncJQ94d7n
	 umwFSWlGLr4vA/bPlK6oODcP4LumHiD4GEOfUO4bnCAx5aDKRjgusMhJtpgkL/t34
	 qA2/EwHyx6r/9zUv9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1wekPA0gYI-0181bc; Tue, 22
 Sep 2026 15:25:58 +0200
Date: Tue, 22 Sep 2026 15:25:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Git v3.0 timeline, was Re: What's cooking in git.git (Sep 2026,
 #08)
In-Reply-To: <xmqqwlsei1pv.fsf@gitster.g>
Message-ID: <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
References: <xmqqwlsei1pv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:isZDgRiwpPLXrenQpkZ47y7vThKjXTEW2Z2dDW4K4zvPMTuRGnr
 xPjN6KVeR6WVfJnNS4Tyq1wEmlBNaLTFQ82eW6k94MZ/YypsPz5CXh54NoC+97OJuONyH84
 vEj2tygXkRCg9/VA+TIb/s/sgWG70oQr9hA1D2kyxQcHLqk9TKofvTRShDYXz5KlEGZKs6Z
 OkxqN+hVqyAAiv6+LlqDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4igMyj8q0ts=;hHRZPS1nNey3OmH1CQvtrFfzA+j
 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
 A=

Hi Junio,

On Mon, 21 Sep 2026, Junio C Hamano wrote:

> Git 2.56-rc1 has been tagged.  We may merge last-minute fixes before
> the final Git 2.56 release, but otherwise I do not expect any new
> feature topics to be ready before the final, so most of the
> in-flight topics will stay cooking in 'next' until then.  As
> discussed at the Git Contributors' Summit, the version after the
> upcoming Git 2.56 will be Git 2.98, scheduled near the end of this
> year.

Would you say that the following is an accurate characterization of the
timeline, so that people who need to plan dependent projects can rely on
it?

The participants of the Git Contributor Summit agreed on a certain release
shape, rather than timing: release v2.99.1 and v3.0 simultaneously,
differing only in the breaking-change defaults. The timeline discussed was
v2.56 in September, v2.98 in December, then v2.99/v3.0 around March 2027;
April also came up. Dropping v2.57 in favor of v2.98 was an explicit
decision. This would make v3.0 principally a deliberate compatibility
transition, rather than a separate batch of features.

Rust was treated as mandatory for v3.0, and the explicit check for
objections drew none from anyone in the room. Compared with the
contentious portability discussion on the Git mailing list, that is a
notable signal. It does not establish that the portability problems
themselves are solved.

One of Git v3.0's bigger-impact challenges is SHA-256 interoperability,
which is purportedly done, but not on the Git mailing list yet, and there
was affirmation that it will handle historical tags too. While GitLab
already has support for SHA-256, GitHub has it only in private preview
with general availablility likely before the end of the year. JGit does
_not_ have SHA-256 support, and no participant knew of anyone funding it.
The ecosystem transition therefore remains uneven.

Is this a fair summary of the "Git v3.0" breakout session at the Git
Contributor Summit, from your point of view?

Ciao,
Johannes

