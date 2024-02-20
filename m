Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D8152E10
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467439; cv=none; b=mFh8TgpnAPxzBaF2H0MOUnq6wb2ccmv5+Xhnb9ICFIBvS4W9Ic7Vsl19S54mLGJ2qH0PbvhBEcmI5AP+D3FT0l3Sf/Pabmm3Eu1vi+HupXIcqMZs9kQ9KDgl2J6qViwywQAC2l4C0j1BIbNC9WWcFFpbMuIHaBsJenMUh1MSWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467439; c=relaxed/simple;
	bh=6XYLk0Yo+/QnFZCKmsxnmfzUiSi2DjiqlkcuACal2Zk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OecOsYqTOTJrvQD0YDZN/taFnHQVOBW4dyZWF+uC83cZW4XPxfckVfg2wGDzIZ8rUYTADDlYIEukbG5Z5R3R0lDd/8tNHf2LHn9qsExJGu5gFgZlexzh9a2W2nezaLAkkRlPsTtoWVZrILS7VYBIHPtMazpgKcWjZJoH1U6NHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AD1uu/9X; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AD1uu/9X"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708467434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zDN9tOZI0ZFJZt2PO6DePZ8x63teNrDKfz96IbzvPE=;
	b=AD1uu/9XmviWP2v7iq6OLFwLPd/8+Kubp/1EbfT32y4HpYPzOokvN4nvwPvouliJf2A8j/
	HcoqpG+fYnYkes011v6DsvS5RRsAi7DHujCgNsWmGr/fdbTqcrXXv2wsvlVCrUY6g1YptS
	9Rva6VjRy7jOWW1HsRPBl4GjvEzZvHhoe4mcoiJcKHoJJJv/7c9F6ku9dGXMIR5+3R8Z2B
	4REIDFnfqemy+D3HeAzs/GGblTpZTG5gMfxBdim5Ow65zrXV/CyUgahg4uEAfzE5EtK0P0
	araFPDHcK5/YTBPW1oJvjYYy3iNVajQHPnAPTJYu//U26UXv2bjT9Wh0yDY0wA==
Date: Tue, 20 Feb 2024 23:17:14 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] documentation: send-email: use camel case consistently
In-Reply-To: <xmqq1q96okkb.fsf@gitster.g>
References: <877b5bec11caa8a328ee0d4f226fe0666fd35a10.1708466383.git.dsimic@manjaro.org>
 <xmqq1q96okkb.fsf@gitster.g>
Message-ID: <59cb804a0221038626f16a4b0138e3eb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 23:08, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> general rule for making abbreviations, with some exceptions.  For 
>> example,
>> one rather well-known exception to this general rule is "SoC", which 
>> is the
>> abbreviation for "system-on-chip". [2]
> 
> I am not opposed to say "we allow spelling 'carbon copy' as 'Cc'
> because too many people mistakenly use that capitalization pattern",
> which is what you earlier said, though.  As I said, I do not insist
> one or the other capitalization, as long as it is backed by solid
> reasoning that would not confuse future developers.
> 
> It is very common to omit upcasing prepositions, articles, etc. when
> spelling acronyms in all capital, so "SoC" would not count as a good
> example of an exception.  That's the kind of bogus justification of
> giving an exception to "Cc" I would rather want to avoid.  It really
> is only "Cc" that needs to justify exception in your patch.

Alright, let's try v4 with no such examples.
