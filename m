Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57E1C2E
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447846; cv=none; b=Fn3vEZI3ub9pCfgvs87USn59hSLvBIa6jSMlXwqo9RzN7P33hC5+R9nSSIJJLW++Mfu6ViwvGD7Bad6wUkRh30g6PPK6td5ChleUKShQa7lgQsS5gPN0nWiDvdGSjLNj3zJ9DiwaH4X5OkDZBHcbjDWZhH6DLfDx8C00aZ6slV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447846; c=relaxed/simple;
	bh=ZsD/Kk/SNlLJ7d1WdNH7DiOVfXF1QfgwgsGewQ1+yCI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bNgBpOohgHfTOnagjZ2Rd+aSKcxVosao2E4Qi56gOaWUYSfEAOgxGekyEeznQUMAN7kT23eMBiUKO3FCdLqr+eQKAKRIZjG43/vsl+3Y4dDHlL2Q2XRBW54jeEeIrp2RvxloiA08Iorqi8rFYiFw5cD0SJ/CQi9N3bkZUP7fVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=I2keFYWJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="I2keFYWJ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708447841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8SH9RyvEkavN8W5ve9pauZsMV8PI0e4olV4yHkROyw=;
	b=I2keFYWJiNTBk7jZ8A/Sx2EITkE5uO337jOP5S33MODJAkXirgcy8Tb5nv2XoprD+ZjJgy
	2+k5ucaMZrH/3O1FCgAr4iADLkg1jIAD9LJ56bwlG6zG7eBrTM+Vy4suWKF8+Vt5t0eY/y
	VVaKG4dnD19CjYYwo8ciEqm5qT6AW+VPBGIvpE/zpkeLgsscZNihfkY+bKyBb3FUB0DCsb
	ni3GcDbn2oPVFdeRnWuDFjwoZSim9h6Tv2YUIzxZGMjVdgBeBUXMexsu1KOG6b1lZZZsX8
	vOO47FEUMtUVrKYkCXb+w3i+2SVp8piK0bW+kkdXu8zJGTfrq9F6c42z6A6mMg==
Date: Tue, 20 Feb 2024 17:50:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
In-Reply-To: <9d0022ba5666223af94bbf450909b1ba@manjaro.org>
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
 <xmqqv86kx8h0.fsf@gitster.g> <33abb630c1d089e39ff48f04e586b1c0@manjaro.org>
 <xmqqo7cbt8a0.fsf@gitster.g> <9d0022ba5666223af94bbf450909b1ba@manjaro.org>
Message-ID: <a766ba7eb27f663eee34214714f6076d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 17:29, Dragan Simic wrote:
> On 2024-02-20 17:22, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> Though, "CC" should remain written as "Cc", because it's the way 
>>> email
>>> headers are capitalized, which "Cc" refers to.
>> 
>> E-mail headers are case insensitive, though.  See above ;-).
> 
> I've never ever seen anyone referring to email headers as "TO", "CC" or
> "BCC".  It's always referred to as "To", "Cc" and "Bcc".
> 
> Moreover, RFC2076 [1] refers to them as "To", "cc" and "bcc".  This
> makes it debatable whether "Cc" and "Bcc" are formally the right forms
> to use in regular conversations, but also makes it clear they aren't
> to be treated as abbreviations.
> 
> [1] https://datatracker.ietf.org/doc/html/rfc2076

Here are a few more interesting links:

- https://en.wikipedia.org/wiki/Carbon_copy
- https://bugzilla.mozilla.org/show_bug.cgi?id=212059
- https://bugzilla.mozilla.org/show_bug.cgi?id=50826

Thus, "cc" stems from the old age of literal carbon copies, and "bcc" 
was
seemingly coined when email took over.  Technically, "CC" and "BCC" (or
"cc" and "bcc") _are_ abbreviations, but the slightly incorrect "Cc" and
"Bcc" forms simply became widespread and took over.

If you insist on using "CC", I'd be fine with that, but frankly, I think
that would actually be confusing to the users.
