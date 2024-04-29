Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FC8614C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412753; cv=none; b=a0DkoSOwC03DG8PEYT6QwL97kzYmV5DncNWXvdCHF7sMvW9QrdSlBZhTdrxgRYVRglUO5Ka/RGb2mpzOmwH42j5lf4Q9vP6lgL8O7WbjsWGkQHsP0Jy+BTcW9hGDMBfvSfV/7vjlvksAbKHaJBD4990F+PZF/wwqTHqDvCNxnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412753; c=relaxed/simple;
	bh=xpBs0/0MnZhwNCqNAyfmHAgu+tz6Q7i3dTNOnWzO6wM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GYVvaEjSGdpzQOWNdBIVNpkbYvAoTgs7if4v7XXmIRyorhcSxI29hYEvBCENizI5ICVdiajZAoiqU7kFYK9LHWKGpJbEqFjF8CwmYh5hiYBybMIHYRHI+i4BeKEC2zFITxgnhkAnyOxGFPgFXSDBL/36cXi5uN4Frl3fx+im23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=r0/uBrBo; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="r0/uBrBo"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714412749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HumjEDdIGJgeNdM5pfMPhil4cJ6qdSXDN2z8dysrHmg=;
	b=r0/uBrBonxxUY6tNBPxLsnCCpKuV9x+N8W8s1F8iloumJj2Y+3mALUg6e9qB6O+VaVRqD0
	aZdLTadcroWiBxSYZ/3vFtMpffgkMQj+YeH11jQpM/YPwg56gg7U4vkO4Do1vCEj39EPUO
	oWXec6tfM6j97C3aODntyBJPmjK1LtRioWxaegP/uzmH84urrppdaakYM/nFgDfIbry7hZ
	PDjrmP++PvKqXgOKHWWT4/01TS0sVj57PpJypE/dkFR68DPCLfE1F+fhWW/shK0ICJbgB/
	jslgHtMpT1u59MM+Aoz16VaFlIb5OP8JdJEuvCayb2iKWRVN7bFy+Ae1eU1jew==
Date: Mon, 29 Apr 2024 19:45:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #10; Mon, 29)
In-Reply-To: <xmqqplu8ulra.fsf@gitster.g>
References: <xmqqplu8ulra.fsf@gitster.g>
Message-ID: <5209161598ea38138becfdb33e7e8811@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-29 19:22, Junio C Hamano wrote:
> 
> * ds/send-email-per-message-block (2024-04-10) 2 commits
>  - send-email: make it easy to discern the messages for each patch
>  - send-email: move newline characters out of a few translatable 
> strings
> 
>  "git send-email" learned to separate its reports on each message it
>  sends out with an extra blank line in between.
> 
>  Will merge to 'next'?
>  source: <cover.1712732383.git.dsimic@manjaro.org>

Oh, nice, this is reassuring...  I'd be so happy to see those patches
accepted, which would avoid wasting all the effort that went into them,
while also making "git send-email" a bit more user friendly. :)
