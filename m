Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81067C4D
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446587; cv=none; b=TreIUkSiAZ8Y/phyUc23aQyYjDEo69WG1nPPUfM/7tJSAqb3iqT2ToicH4CLoHEOnPidehXN7CVHG7ibvZYeV2dA9kqpF2H22YFdGuHVwXUQYMhWqc3vJJKbq+UQGLrB7tq2tRLva+jRqnm96WdvlrWf9v8oWmHkcidPjU9ipu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446587; c=relaxed/simple;
	bh=6XtqfnBF4B8pQUD1o70SVgF/FpaadOutD1c3ZVD13Zg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NyglXxADxn+w2F0BHcJilsox92BzaxihS7IracWehghsxXNUwcbm2eHVwgwJ0MLdJ6Vi5SEJh8LullH3CuBWCeU5DvVNNch6YbnyaAs8XfG3bddrp7kbYythhZLxlAYF7tVq4xsj1nWquHQW3eGNjOEMcxZs2yu5FavPD1kvkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BR0a8rt1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BR0a8rt1"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708446582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp/4XzEIkgoFEF3t9PF7I0H63esSQMpTgfU2e4AOEfE=;
	b=BR0a8rt10hvBeOvhY36l3dmGZlKrUx6rkBHqER9/kn9cvCw+LujdPJntzqWeJfkevDpRSp
	oZHLKAopJPF8c1pvtMQvBS4zxwYfxO2iSFCXH2nT+kJG3qZUX0fgAkYvNDqE+tkznNvUZR
	OJY6ERp4wLKzt3V9tsVMySgxX119zx/gqvovZyQKVH8lfbgMU00z7l6Nkk3/ozICc/oIQ0
	9Gqt2Wajgq+EjWnvIIqDM5IWCE/5vr/dUO952EZSzuHyWz5KKWZh6Pqsg2tn5f32Ozc3LH
	6cEJkajJ5lpufp/GFLDMJGK8cTnj6ejITtMfCyfeGF4MQV/KctyBa6SjpgaaoQ==
Date: Tue, 20 Feb 2024 17:29:42 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
In-Reply-To: <xmqqo7cbt8a0.fsf@gitster.g>
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
 <xmqqv86kx8h0.fsf@gitster.g> <33abb630c1d089e39ff48f04e586b1c0@manjaro.org>
 <xmqqo7cbt8a0.fsf@gitster.g>
Message-ID: <9d0022ba5666223af94bbf450909b1ba@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 17:22, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Though, "CC" should remain written as "Cc", because it's the way email
>> headers are capitalized, which "Cc" refers to.
> 
> E-mail headers are case insensitive, though.  See above ;-).

I've never ever seen anyone referring to email headers as "TO", "CC" or
"BCC".  It's always referred to as "To", "Cc" and "Bcc".

Moreover, RFC2076 [1] refers to them as "To", "cc" and "bcc".  This
makes it debatable whether "Cc" and "Bcc" are formally the right forms
to use in regular conversations, but also makes it clear they aren't
to be treated as abbreviations.

[1] https://datatracker.ietf.org/doc/html/rfc2076
