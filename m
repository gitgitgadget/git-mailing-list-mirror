Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD894150995
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467701; cv=none; b=LVS+DtXuqz/GPzjG8vSNB8bU3TmLgULgkoU2djhYSW2lyJ8HjT2Xng1ldi151bOfLWa7B/dxYgVrq+/iUozvaU04FpajLbpkmzMFCVFfBaGuwuGwJDj4Z5f55x+sJzaZmWiH9duHFI9dHacALt7IkcksMhM0xvtxfzo97rJ4MWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467701; c=relaxed/simple;
	bh=YVxSKMlVJLiFKYoZH0l2pnIFxt743dU/9Nb9Iyp1T5g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=f7b9MCnC7DITJ4oItx3gaErlng1K8yUs1y1cbhLkNFCmyc5GREpFTB9MfWXeUAzlP2LWL3d+U6DYhth9puynQMFw5j3dldEpEZw37aI5boIXFrtuZQ+m3BtciaOy7XpMjNJ9XsV6fj5MIpi4QagVbxonJq74la7mEr0FiuR8Xvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DnW33khh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DnW33khh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708467697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bb5Q59B37ybN+9J+6hg+c4mYASxpVZeSEsI2tXuE6pQ=;
	b=DnW33khhdmr5ICsEJkCdcnxUZvJeXtoNAMkGPyiICvcKxwpgI84gfZuyhmjv365ZDycrTu
	1oe1ZiFvwrViEF47A/xoO64w4Bi/Sz8rI4aEcaGIBbRTt+GsmMd4YA1oO66jEMmTkqI0hR
	71oPTdEpIlEyUkj/IZ6Q+G72Oz7WqyLFPdmG8EIszs8sC9Jwc64GOvfIb5gto9xHUMFldH
	YSqIhkrbqbIzhp1oJUrLWlzrKG572FWcBKyH386x6575qp8FnVBy+ASH/65ovFRq9zVKdR
	KJEZee6/AYmaYXa0Fo/CL69OpGdJqazHAFkFAkH4NsWvDHu5kxLf8TaiYqUbmA==
Date: Tue, 20 Feb 2024 23:21:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] documentation: send-email: use camel case consistently
In-Reply-To: <37c0c025-7120-49f3-bc2f-f35249339f3a@app.fastmail.com>
References: <877b5bec11caa8a328ee0d4f226fe0666fd35a10.1708466383.git.dsimic@manjaro.org>
 <37c0c025-7120-49f3-bc2f-f35249339f3a@app.fastmail.com>
Message-ID: <112df7b4122155b8021134367fc0e458@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 23:17, Kristoffer Haugsbakk wrote:
> On Tue, Feb 20, 2024, at 23:01, Dragan Simic wrote:
>> Correct a few random "sendemail.*" configuration parameter names in 
>> the
>> documentation that, for some unknown reason and contrary to the 
>> expected,
>> didn't use camel case format.
> 
> Interesting. Consistency is good. Nice work.
> 
> PS: Please keep me on CC. I’m not subscribed to the list.

Sure, here comes the v4 to you as a virtual carbon copy. :)
