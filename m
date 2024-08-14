Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D97E1B9B50
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655117; cv=none; b=OMB68mjgZKO0/iSPKeWouPjh1g/PIV7kCoF7PxHLdaiTl0Qs6RIoetDNYphg8ADBSRbFg/6zXoJuo/NeeBSUzDlvc4cMe3nfTgoRmSHq3U1F6ioKNRJrru8D32R7nRCDBVUzIk70y4A9SNcj17iMlnifQUYdWaY6rQM7RsUFSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655117; c=relaxed/simple;
	bh=2LwyUygF7mj/b/rLfeaK6UOHBHpFogOoZIAWBt4zfEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehLWoUAl8Ipk63nZq19tFg4tyRvSuMTsQ/AGXeeRgYbSqZ1naL7OqooxpOjZzSKmm6II10xwuUHeZ5m5M3KmVQgtNxvT00vr0DNHnEC8rfWRk5Ok03Fi9Rlqs0ZZZ8yroHXirnlQOnxD5M8AjePOTq4eAJQcRG2zw9arNwm4k4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zk/c0tZ5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zk/c0tZ5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A02A33AD3;
	Wed, 14 Aug 2024 13:02:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2LwyUygF7mj/b/rLfeaK6UOHBHpFogOoZIAWBt
	4zfEI=; b=Zk/c0tZ5LvWUrrq+kSQsTlO1snvzePfZ0k2eya0tBade+9cc9hh/kv
	EQiWAKlD/uNJCXW+yTD80qDAbxb9DemScB7Iym2Pak5aArwDlIJe95F4wN/wBLS1
	VGXTuWIk7SxoJQHAe2pDmU9DXLbC7Inl/RHqQC19FeAaelr8cSI9E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5156933AD2;
	Wed, 14 Aug 2024 13:02:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FDD333AD1;
	Wed, 14 Aug 2024 13:02:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] t9001-send-email.sh: update alias list used for
 pine test
In-Reply-To: <20240813-jk-translate-alias-send-email-v2-2-912db4eb6846@gmail.com>
	(Jacob Keller's message of "Tue, 13 Aug 2024 17:05:10 -0700")
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
	<20240813-jk-translate-alias-send-email-v2-2-912db4eb6846@gmail.com>
Date: Wed, 14 Aug 2024 10:02:44 -0700
Message-ID: <xmqqo75vyr4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06F233CE-5A5F-11EF-B3A1-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The set of aliases used for the pine --dump-aliases test do not
> perfectly mesh with the way the pine address book is defined. While
> technically all valid, there are some oddities including bob's name
> being partially split so that the actual address is returned as
> "Bobbyton <bob@example.com".

With "partially split" bob's name, do you mean the HT between Robert
and Bobbyton in the original?  

I am asking to see if the closing angle-bracket ">" after the
address is deliberately omitted to illustrate a breakage coming from
a malformed entry in the original address book, or it is missing
merely by mistake.

> -	bob	Robert	Bobbyton <bob@example.com>
> +	bob	Robert Bobbyton	bob@example.com

Thanks.
