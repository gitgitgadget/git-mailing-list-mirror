Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F941AAC
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466930; cv=none; b=SmKVpBRt9ZfN9fefBLX3xaE2vJogFG961PmBQFYQCCiq16ZVul0lxOf5VNBvK4Q1U9L8JW/gxobjbl6n9oCDdxzd4eHU5XPjR+U+/RqW9m9GjW2vIx+gM4J893RMz4fUDm2iOMmbiMps6qHKZmlWa04uiRMgch5/m+6+v7MUs/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466930; c=relaxed/simple;
	bh=IUIsrxjZYO1gj0oc8R6aoPvnxjkwTtQnynnyqP3pzwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNLf6NGisE4+BKMblaMylij2PYsuV33Sq3aWfUYhmtonY+NkPUJ//zMYF32C/jbg85t3ja6E3kIi3yUVXzhQR0p3/Sus8/PYMb1gXkGpdge+rRBjYF7Ze+Mx8poQhcTFnv9wvOWq6AvFGoDV4HuPYUtU7jtvk0duRCD081Jqfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Co8WTbmP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Co8WTbmP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E361F2E9D7;
	Tue, 20 Feb 2024 17:08:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IUIsrxjZYO1gj0oc8R6aoPvnxjkwTtQnynnyqP
	3pzwg=; b=Co8WTbmPSUpXAUH6BoiSL4370HUzU/MlcrEnl2+f68DPuKUvS+l3Je
	ccIsX8yU6ejYzD8obLqP8TR+sgxLibzmGkYXThU0SR24ZY7BihUOdbM4GZUcUTfQ
	Yqlc0Iag1yQ4IdWWwV4/L0OBa0oUH6As2D3Plb3XYjXaYOvuS48PM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D893D2E9D6;
	Tue, 20 Feb 2024 17:08:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42C5A2E9D3;
	Tue, 20 Feb 2024 17:08:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] documentation: send-email: use camel case consistently
In-Reply-To: <877b5bec11caa8a328ee0d4f226fe0666fd35a10.1708466383.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Tue, 20 Feb 2024 23:01:21 +0100")
References: <877b5bec11caa8a328ee0d4f226fe0666fd35a10.1708466383.git.dsimic@manjaro.org>
Date: Tue, 20 Feb 2024 14:08:36 -0800
Message-ID: <xmqq1q96okkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9941A582-D03C-11EE-9E8C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> general rule for making abbreviations, with some exceptions.  For example,
> one rather well-known exception to this general rule is "SoC", which is the
> abbreviation for "system-on-chip". [2]

I am not opposed to say "we allow spelling 'carbon copy' as 'Cc'
because too many people mistakenly use that capitalization pattern",
which is what you earlier said, though.  As I said, I do not insist
one or the other capitalization, as long as it is backed by solid
reasoning that would not confuse future developers.

It is very common to omit upcasing prepositions, articles, etc. when
spelling acronyms in all capital, so "SoC" would not count as a good
example of an exception.  That's the kind of bogus justification of
giving an exception to "Cc" I would rather want to avoid.  It really
is only "Cc" that needs to justify exception in your patch.





