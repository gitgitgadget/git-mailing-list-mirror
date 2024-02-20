Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EDA7605F
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453788; cv=none; b=TOfKpOzWZSEblvXaAstzFGYwnyltPwB9aH0nxAEfyJbm/rouEhb2/krAl++wPRsyiNNm5Ldw+SIdetEm7vCjtIH6V5JqGadTPm/Yfx8gT5eyoIdWqer3hT1DWK1lLW2J5PLks+Yfs1YJGOkAjDIfeflTwMmhuA4lnsVtnhktLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453788; c=relaxed/simple;
	bh=yptZwoRoF7tWHtYcOH48ZwhpoYE+AWA4jHqCJR/wUq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aMDSkFFZFs8w+ich1XFDqQA+XY0W8iJyGoXcXeyVMEpRyMdoD/bnncd+r3zRTgyzMbF1s+FpY7Q4hS/Dr6NcmxfWHEb0kU55gUsBMmAtU0vg/Cx+j/9iUCYxUjZi62iq41SeWXCPY/m9JGSS0IJ8W7j66ZdoG0UdJJRLfxq6rFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uEeFGoqK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uEeFGoqK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CC431E9A53;
	Tue, 20 Feb 2024 13:29:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yptZwoRoF7tWHtYcOH48ZwhpoYE+AWA4jHqCJR
	/wUq0=; b=uEeFGoqKB6sUHRRwVajIQsdTAvNV09o131BKeP8FqzTdDcoj1qZSMn
	lfVkoOxd2POk3a1XHv2MqG0ehOX+pIVf5Ma8GJ345ydBsYCKpxeasHsV1qS3msun
	kUtuexq0ZfIIkybEB2PSgmjAxCchtOhoBILXDS3Nv+VF0Ugu6OhLQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4491C1E9A52;
	Tue, 20 Feb 2024 13:29:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B26261E9A51;
	Tue, 20 Feb 2024 13:29:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
In-Reply-To: <a766ba7eb27f663eee34214714f6076d@manjaro.org> (Dragan Simic's
	message of "Tue, 20 Feb 2024 17:50:41 +0100")
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
	<xmqqv86kx8h0.fsf@gitster.g>
	<33abb630c1d089e39ff48f04e586b1c0@manjaro.org>
	<xmqqo7cbt8a0.fsf@gitster.g>
	<9d0022ba5666223af94bbf450909b1ba@manjaro.org>
	<a766ba7eb27f663eee34214714f6076d@manjaro.org>
Date: Tue, 20 Feb 2024 10:29:43 -0800
Message-ID: <xmqq8r3foup4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 050E075C-D01E-11EE-BF23-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> If you insist on using "CC", I'd be fine with that, but frankly, I think
> that would actually be confusing to the users.

I do not insist; my job is to just reject what is not correct.

In this particular case, I do not think Cc is outright wrong; it
is near the borderline, but I do not know which side of that line it
sits.

I gave you one possible rule to decide what to capitalize (namely,
acronyms are spelled in all caps and that is how we capitalize
http.proxySSLCert and imap.preformattedHTML) and if we adopt that
rule, then sendemail.supressCc would be incorrect, simply because
carbon-copy should be spelled CC.

You need to give an alternative criteria that is easy to understand
for future developers and follow, and explain your choice in the
proposed commit log message: "We spell acronyms in all caps like
HTML and SSL, but in the case of carbon-copy, we spell it as Cc
because ...".

You need to fill that "..." is in your proposed log message to
explain the choice you made in your patch text.  More importantly,
it is to help future developers so that they can easily follow the
same rule to spell the variable names they invented in a way
consistent with the rule you followed in this patch.

Thanks.
