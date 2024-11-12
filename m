Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058721642F
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436130; cv=none; b=cCZ4tLsEZZFMfp8tmuHn7SJkIcmfm+uqu59gVZG4+Y8tTLWHUo7tWcgVIwfLKVTj4+OUfk7qJ0fHRFJAiVrBSLlps4OZ9bqzvN6/MU5fQ7M6TIJVoST+P8Nz2chgBCQq5aZdOErdwFTDUbvTuaoV8+eEcUuNtVAqFAuAmLt8Amk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436130; c=relaxed/simple;
	bh=MdbteHJgJn14lbFz0a8pWcpnfqO+F4uqFyqtUisfrrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owWao1HitxF8YbPzmglfpQDeMF1pRlqZSK7zvH4ALpPKfDcRYsc76LcD5IAnJ4u6WNhkq6z/pj6N2nK2Q+hO8euHsI+MYZ87A6O3RnGKRI7FsUkk4Od0AoJYAVKJyrdxLwiYzCptE+4wgGLWAng2EKafU89EWqoydQOPOu9k9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Xnw0N36tXzRpKY;
	Tue, 12 Nov 2024 19:28:34 +0100 (CET)
Message-ID: <45211c3c-e077-4de3-a167-0fc973a78dba@kdbg.org>
Date: Tue, 12 Nov 2024 19:28:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] doc: git-diff: apply new documentation guidelines
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Jean-No=C3=ABl_Avila?=
 <jn.avila@free.fr>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <c104bd50b646646e980905a9294209f381b9e61c.1731343985.git.gitgitgadget@gmail.com>
 <xmqqo72l8egu.fsf@gitster.g> <7b42828a-2cbe-47c6-b21e-b8c1e3a2ad01@free.fr>
 <xmqq34jw6ci7.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq34jw6ci7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 12.11.24 um 10:13 schrieb Junio C Hamano:
> Jean-Noël Avila <jn.avila@free.fr> writes:
>> To clarify, from what I understand, it would be better to fully spell
>> out the way these options are used by using the synopsis syntax:
>>
>> `(-1|--base) | (-2|--ours) | (-3|--theirs)`::
>>
>> Is it how it works?
> 
> Yeah, that may be a more sensible rewrite (regardless of this
> "better mark-up" topic).

I would disagree. IMHO, it is not necessary to copy this sort of
nerdfulness (the syntax annotations) from the synopsis to the
description section.

Does

`-1`, `--base`::
`-2`, `--ours`::
`-3`, `--theirs`::

not work? (I think we agree that grouping synonyms should be done and
not all tokens moved onto a flat line.)

-- Hannes

