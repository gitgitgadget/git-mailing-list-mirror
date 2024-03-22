Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83610F2
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711083050; cv=none; b=BD0haJtZUU68htheJcXnt4ShHiIXGFzfgAElkc6PLdL6QhYb5BsHMqdOYcbpgLMiE527TA8kx5e06AjbmyzbMl19u1V3tgI1Cu2yYX+8xhH7S2GvXh3g9zilpPpSdMi602IsWLkhoAsVpQRR58iAh/3CtLKUTm2J2xNdR+vqE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711083050; c=relaxed/simple;
	bh=Jm6Af065DY5Mv3yFN+0bSH9Ox5gXxHRGgrj3f9Xuess=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gOGfZSRWLe3gQAXwuHmOmbW7IWaphkglmBE7qtEFHLkD0s/R9M4+jCRwW5VDFLAyRqBmflZLIsQs8SrBj8aPZ/W+urFGIA8tB9stwNKnnqOnUmJVt160024OHSXRpKcegGnf/lhSNy1xsyCZ6FUSVfIXhPWW4Lf8AXJxe1UVryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=LCWFABF7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LCWFABF7"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711083037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YGdLa6MrbM3PIkK5q4fELI+GsWhTmYNwjY89nLxdHk=;
	b=LCWFABF7UdEFyuitoqDb/MgJ4HjFQwkN0qxpXyG0kLBHSyXnAQbCzXHNDUHrYhER94rzhC
	xpeB3VOf8x6k0dV4WPYOe4WPTDzlKXZLS+U+CFqsZiPtuFmRnLggM0FCFZrOM/m5EN/RJP
	DrqVwWat4yFs0KTIYvp4Fm96J26Hz42bBXWSriLKlUTxlSLe20qMMIaJX08oSKgFS63mMd
	F+Qc0eM7Uh2S/ONZb1DnhIEPmzJzMqSTQu9ePxPwYcA/5joC3epiqoWoNHqx5Lhku/tfLt
	vtzWqjVAPR1yk0JKN9E/rqc4BE5y9xV3lSkn5YjDr9g+GVfA7v455ZYD1gritg==
Date: Fri, 22 Mar 2024 05:50:36 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
 rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH v5 4/4] config.txt: describe handling of whitespace
 further
In-Reply-To: <xmqq1q836vkc.fsf@gitster.g>
References: <cover.1711001016.git.dsimic@manjaro.org>
 <a75a5eb8793f4ae6eb6e7cf0e2fd017471fefd0e.1711001016.git.dsimic@manjaro.org>
 <CAPig+cToaiCzj2XwNSeStx7p7ZPn7=a2nKZBFLwX12Uj=hJ7cw@mail.gmail.com>
 <xmqq1q836vkc.fsf@gitster.g>
Message-ID: <a75432d09c243587bbb3877fa1feb471@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-21 23:58, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> Thanks. I find this discussion clearer than v4.
>> 
>> I don't have any further review comments on v5.
> 
> Thanks, both.  Let's mark it for 'next' then.

Great, thank you.
