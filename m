Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69A1F7075
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496810; cv=none; b=fcQmVuI1jvoayb1Sjn56YWV/wbNHjysp9hqfV/LLJ4TDRy8sb+Rc6snBDilXUenpIhS7R32aej4WsmEC15ftcltkg6wq5b9VavVo4IlYOxwNoMdOHv+kp2tig9J1A+l7pnn++coBbiFTGXFxHxpoxtQh6US3UN8KcjuNlh0AhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496810; c=relaxed/simple;
	bh=u9Bu7RCNW1806mzuKxy498E84w1Sq8zhOvpGsAP04qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3ko57BSc7/lnlCOtGb8L7lQ2T4PPsn1IYPnnu1yu8sVg+FCRgn/WDbtO64fPPPFvGyAaRLqiz7czNJjFwO7OYKda1wE8t+tcLinMFBOMihSigMjJD86n08i7bESQLpRFyVOih9kqweuCkGknQ1vx+9kLKM4xevZFIaA1AjWVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=aEEOvVdj; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="aEEOvVdj"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id DA01842D80A
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 22:59:57 +0100 (CET)
Received: from [192.168.3.122] (unknown [87.149.32.105])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 3B6AA13FA38;
	Tue, 21 Jan 2025 22:59:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1737496790;
	bh=u9Bu7RCNW1806mzuKxy498E84w1Sq8zhOvpGsAP04qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aEEOvVdjYouvWMH2s5tba86WR4v+9W+7YlBMWnr1WP7xx1Fe6fdZEz3XGpYBB6zGX
	 I8N4Twm4g2QLgMGjPjMYvcVhxgsm7H1OrA0nEJtpH/spNtPyRv2/uR6OlvRFmhBPHH
	 jgAYK8zyvm9BtvfIo9l2FpU8I4537+Whjvk5rDEetv8b1o6KOp8RLphiWFCek1PUis
	 yZQZ06juNG6oBfbUuAYaYa/hB8REkaWJB/Y+0Nj9fWkz/qnrEcvXpZ64zw3mFqoRWP
	 2ENmuz0MkumZo9OluNEuT045rfnI9D+RJMdVQeXpLQ5A7PY5+uJnX2LooSj0ZZSI/B
	 96CiDG7h/j1IQ==
Message-ID: <012b67af-ede4-46e9-a30f-ef3b60ce1e80@free.fr>
Date: Tue, 21 Jan 2025 22:59:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, git@vger.kernel.org,
 M Hickford <mirth.hickford@gmail.com>
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
 <20250120015603.1980991-5-sandals@crustytoothpaste.net>
 <46cec27d-ee66-4dfb-8271-953b032d0b2f@free.fr>
 <Z47JUbdzMtz1CTMg@tapette.crustytoothpaste.net> <xmqqmsfl2gro.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <xmqqmsfl2gro.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 21/01/2025 à 00:43, Junio C Hamano a écrit :
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> On 2025-01-20 at 20:37:10, Jean-Noël Avila wrote:
>>> Maybe for users of the end product of the documentations compiled here,
>>> but there are other users who use the source files and this change
>>> breaks their workflow pretty bad. I am one of those users for the
>>> git-scm.com website and the manpage translation projects.
>>
>> I appreciate that this is a big change, but we do also sometimes make
>> those and contributors and downstreams need to change over eventually.
> 
> Yup.  FWIW, this change would break my private toolings by renaming
> things under Documentation/RelNotes/, which I did not think we even
> pass through AsciiDoc, even though by inertia I write something akin
> to AsciiDoc in these release note files.

That's what I had in mind when advocating a bit of caution on this
change. I'm not opposed to the change, because indeed, the original file
extension pushed me to change the editor's configuration, which is
cumbersome and may hinder newcomers on helping with the documentation.
But to be honest, it's only because I'm monitoring the list these days
that I stumbled upon this patch series. Some other consumers of the
documentation source files may miss it and just discover the change
after the fact.


> 
> In this particular case, I would imagine that the use cases of
> myself and Jean-Noël would _eventually_ want to be adjusted to deal
> with anything the upstream picks as the file extension that may or
> may not be ".txt" (to put it differently, they are written to expect
> that these files end with ".txt", but the _ONLY_ reason why they are
> is because those files in my tree _happen_ to have such names).  We
> certainly do not want to make a change like this unnecessarily and
> unannounced.  But with sufficient advance warning and enough time to
> prepare transition, it shouldn't too bad.

Agreed.

> 
> Perhaps it may be enough keep the topic cooking a lot longer in
> 'next' than usual one calendar week.  This of course requires that
> those on the creator side echosystem are paying attention to 'next',
> are capable of writing necessary adjustment (in my case, I would
> tweak my tooling so that it uses "$filename.$suffix" instead of
> hardcoded "txt" in the rest of the script, checks the presence of
> Documention/git.adoc to tweak suffix from default "txt") for their
> tooling, and can arrange to test their tooling with 'next'.

For git-scm, IIRC, present and previous versions of the manpages are
processed, so the import script must manage both extensions. Fair
enough, not an impossible task.


