Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFEFBF3
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390367; cv=none; b=XC6ZRquX9JrwAUsoPEbJZN91xy+zWmtR6EzwxHEALu/gpnIgVOnv0rsKCZaP/ccjHLh55tf6dbkceMqD8QTwMrRf5uAWEjjemGfUXfWTUMPwX+5xrmnWQeuxWp3IpFrcF4p7OdW7b4aG6S+u0wZGeP9rUMDdIsfSAvdd3lZBrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390367; c=relaxed/simple;
	bh=Xf/ZmA25c6vqDOdEZHUzHcNSklLosqe1KTfR6jqAGMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c1+fzPHIxxebegmgHzKj5rKKyAexvW7Q63/tAVxI5PecgbdneF+ji+5utmUXPV+AMhnIy/NoUu6ERZY7Xi6cFJhErX+gO39KIUiZdlHlPEUNuPtgmtsujZXHkRETjniSlN/sBXN/bAKql7gt3zIv9EbfBuxMAz/aWm3UeEqNSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dYywgb3Q; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dYywgb3Q"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D902C1E30F4;
	Mon, 19 Feb 2024 19:52:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Xf/ZmA25c6vqDOdEZHUzHcNSklLosqe1KTfR6j
	qAGMk=; b=dYywgb3QMEEJUInh8EEBOjcvu+qvsHT0pbyszg06Fq1Lde0Cq/tvGZ
	rFAicozHaEI9MdpWODSiBiVd+D3sB7O7+slzNAPIJNk74A44j2f3QsWa2vFhWGzw
	4Jrz8ELqwp+ZLRwopvLNzsM+TxCM9q8GupfrREPRGm888IF9hpDsU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF4F91E30F3;
	Mon, 19 Feb 2024 19:52:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 450401E30F1;
	Mon, 19 Feb 2024 19:52:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
In-Reply-To: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Fri, 16 Feb 2024 06:19:56 +0100")
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
Date: Mon, 19 Feb 2024 16:52:43 -0800
Message-ID: <xmqqv86kx8h0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5B864700-CF8A-11EE-B562-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Correct a few random "sendemail.*" configuration parameter names in the
> documentation that, for some reason, didn't use camel case format.

Thanks.

> There's only one "Fixes" tag, while there should actually be a whole bunch
> of them to cover all the patches that introduced the configuration parameter
> names fixed by this patch.  I think we're fine with just one.

I suspect that we are even better off without any.  The only reason
to have them is if we plan to cherry-pick this patch down to a
separate maintenance track that the "culprit" was cherry-picked or
merged to, but we typically do not do so, and if we want to do so,
we'd need a much better coverage.

Anyway, checking the output of

    $ git grep -n -e '^[a-z]*\.[a-z]*[A-Z][A-Z][a-zA-Z]*::' Documentation/config/

and comparing it with the output of

    $ git grep -n -e '^[a-z]*\.[a-z]*[A-Z][a-zA-Z]*::' Documentation/config/

I think we should spell "SSL" (which is an acronym) full in capital,
and possibly do the same for "CC", too.

All the other updates in this patch looked sensible, but I wasn't
being particularly careful, so an extra set or two of eyes are
certainly appreciated in case I missed any.

Thanks.
