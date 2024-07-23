Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F901509AF
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735089; cv=none; b=HTOQ4ITPwghOQvy5amFN3D59CCMErhXrvCkKRwX4zoiStj9QP3IjzUg9wAWZ8Obx+wLtpcWZNioPkrd81fRlfgE727fAzK0IlhhLHWc7HWUz3xOvqON8abFPDOwEItKH+1yf334/mKvNrEsa/6wsO5S+UfzS3BTfPsAQZuVzlxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735089; c=relaxed/simple;
	bh=sLWnWUJGJgLZx+36V34h75cMTo8dBksf9fzWWo01s9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jk5Q3sOfxmUrCJ+7DCER8Fr9/YWVGlKsd/IqwcieVuprtV9794BxmyoUp+sM/tDcjocMD94FJ6r/SkD3qeTkPkXtS303PFxn+P7WkpQrznsqV1pG9iUn5LcQIGu5/m112TDqTxtQJpgzBmoJ/yrgaSICXRzDc20v0e6V3JfLPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=SOZkBqTB; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="SOZkBqTB"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3B160240103
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 13:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1721735084; bh=sLWnWUJGJgLZx+36V34h75cMTo8dBksf9fzWWo01s9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=SOZkBqTBIc2TK+uxz6+NVpW65Y/KSBZb9MBIu4/w+Wwn4yMtXPIplNnMVJKq1a2UE
	 0Uy5bqkqVidmdSNOlXLd8FQF+BJAIUDz+RDF1UtC2nHjxqvaoQfc3sMbK3BOS8DZYI
	 Lfbw190NoAwlPTzmeshp4/+HWnwDTUg2IvvTO9CwRxK3SS2cEANcob9Y3KY+CnKeIg
	 tM+8tEIAH4KtPmiNKM/0b/JXRBUOGbTzTHbgYBTncZC7BusI0JTzPR4zXlRla/BwXg
	 BX0/t5WGZBW+VXh/V5+oTCZ6JzDbLvROHZ6o0ilcp5gLNtUlaAnFsK2WMESc99KajY
	 jQ3fv1NPP54zA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WSwL34D3hz9rxN;
	Tue, 23 Jul 2024 13:44:43 +0200 (CEST)
From: Tomas Nordin <tomasn@posteo.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, charvi077@gmail.com
Subject: Re: [PATCH 1/1] doc: remove dangling closing parenthesis
In-Reply-To: <xmqqo76p54ib.fsf@gitster.g>
References: <20240722225302.124356-1-tomasn@posteo.net>
 <xmqqy15t824l.fsf@gitster.g> <xmqqo76p54ib.fsf@gitster.g>
Date: Tue, 23 Jul 2024 11:44:42 +0000
Message-ID: <87h6cgwcwl.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Wonderful.  Thanks.
>>
>> Will queue.
>
> Spoke too early.  We need a matching change to in-code help,
> otherwise t0450 would break.

Good test suit (which I didn't run)...
