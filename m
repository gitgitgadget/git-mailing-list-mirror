Received: from 2.mo575.mail-out.ovh.net (2.mo575.mail-out.ovh.net [46.105.52.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B603D390999
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.52.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357707; cv=none; b=CVEwvKjp7D22gXLViuEJX288fnG03J1Bq027d711tL1ZwXkjNKhVFUqPn1cnskpvI6A0wVCYwJk1l/UozXi72elJ1qKw8cPY6Lrqge8Y45fiTJQyVruykjbrn94Ogzdyr9aMRueiVXckasVQJ+6ZWugqg7sLPccrN8IY8k0T4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357707; c=relaxed/simple;
	bh=HLBAwoLYcaVPHAdUxcd227hdSjfT7WOcepQMZxrGNk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHZDYviOhdERvzvMmC7odnbkAI6eoLD+aE8Qb6Hvm8vUreN57PGTR+WLRbf2Uaho2rz9oYq3r+L+5PnZsQT+0fnrYPvQTjMs8I4uDX1tZbMBdYv3q4eXNq/wOZFx5q0mQDfMAu0W1ygK5jsj1kmJ440fRRIC13CMbfIVj9tug98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=46.105.52.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.249.109])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4fg8XH6GXqz5wwx
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:30:55 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-vcd69 (unknown [10.110.178.91])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 39EB5C1A7B;
	Tue, 24 Mar 2026 12:30:55 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.109])
	by ghost-submission-7d8d68f679-vcd69 with ESMTPSA
	id hmAFO/6DwmkUAC0ArTSWTA
	(envelope-from <kernel@schlaraffenlan.de>); Tue, 24 Mar 2026 12:30:55 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-109S003ed53ded7-96ff-45f7-8c67-28a18facea0a,
                    CD5E8EA95EDA92FEB9CD9D0381FAFF9B3BEAAE73) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
Message-ID: <888f8670-856a-4ce7-8177-da78ba4f0c8a@schlaraffenlan.de>
Date: Tue, 24 Mar 2026 13:30:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rev-parse: use selected alternate terms too look
 up refs
To: phillip.wood@dunelm.org.uk, Jonas Rebmann <kernel@schlaraffenlan.de>,
 git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>
References: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
 <20260323-bisect-terms-v2-2-8d6bdb2c9c7e@schlaraffenlan.de>
 <d366fc82-efcc-46cb-9536-cd38b1fd18d4@gmail.com>
Content-Language: en-US
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Autocrypt: addr=mail@schlaraffenlan.de; keydata=
 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
In-Reply-To: <d366fc82-efcc-46cb-9536-cd38b1fd18d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 9511320940039603132
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFgsDU+OLy76f54KrhO2KPSj7isArS1RXD3V2eS58mdDB9B6/IV3Y//CZKBrMFE43xexpeAZdMZ2RaYN1uKwHE/tCavzMjBPHh0JAmAnwPou3v5I2kC8Ubk8wC5pItoGJes6BM/hl5DllHaB53GNawdc1Bz794f4SNEjcM6i8pS6Xp5OYThUYryXtzP2/p54FrGo9CQIhxq4MfPBlKdp5VfySsTS10jnMdRRrzYZL7ot7BiE1GkvOw8sOEUcuS1jpVbajP7zue0hTzPSLXl4YJ7TrpMzYya0ij6MKCqFe0tRc54yaWZlOLxoL5GxzeLvzycj50rK2AP6GyLdzjov+CQiguPuy2F6tO8yY5RNC+agjDHmvdox+XOBTVmPRxLDC3wbMwsYGcE9TPZcmtql+hvwTjYlpQYXZaiWUalKFGMaq7zz5wG4Gxfg/NGBGc6SHxvzfrxgXIAUihRPqHNW262O7T5wImwp53KVRObhrixJ+eiUB+U+lnUCCRSoBC56ymPhc2EqwuHVl8uk6iGOqf+K3jikyLV2i7fz7KkDDn1QK3cd105vS5LlGEL5VBgCJUWtFGmwc5XZVoO4ek03KMDn0KN7jbtlq+j1X/HS/wZ2PIW/NgAbZUEgWvwyGAEVnJkjauxFeErLU2l72DzbwOx2DoFUP1mTrSOT8YuxaiYCQ

Hi Phillip,

Thank you for your feedback, it will be addressed in v3.

On 24/03/2026 11.49, Phillip Wood wrote:
> If we fail to read the terms because there is no bisect in progress
> then term_bad and term_good will be NULL and so the next line will
> segfault.

My understanding of read_bisect_terms() was that it never sets the terms
to NULL, that if no bisect is in progress, .git/BISECT_TERMS does not
exist, and the terms default to "good"/"bad" here in bisect.c:

	if (errno == ENOENT) {
		free(*read_bad);
		*read_bad = xstrdup("bad");
		free(*read_good);
		*read_good = xstrdup("good");
		return;
	} else {
		die_errno(_("could not read file '%s'"), filename);
	}

So is a NULL-check really needed on caller end?

Regards,
Jonas
