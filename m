Received: from mailout3.zih.tu-dresden.de (mailout3.zih.tu-dresden.de [141.30.67.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAB1E51E0
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.30.67.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762688770; cv=none; b=l2jrCxwzHxgau0Hk0/YvaG4mIf5ChVvZIWEx3/fZvnR2TADslR1nA+H+uEG3EbuvSBEScTGu/f/E0xOSjt8mynrR2b5NGh5n2+MeDo2xeXdTEQfiTQcFNiawRP67H085MCemvA97OoznoxjSEViJbg6xFjibWhuby9C5Is7cHfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762688770; c=relaxed/simple;
	bh=F80U+nk3qIBtniM5ASqWUgxznG7J0DnFCeN8fON7Bj4=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tNmwmcaVKbx/AlOLp1nFcfzGk1ZcGIo2JUo0j7RZOuK/LuXPf/I7tcp7Y9kgVx16kFXE4k/qO6ATXtkU5eqXVcJKAtngiYTNbEN2drFmRrS9uEM1c9tja/BuHZ1loabbZiwAzV2B/C9vEiVWLgcqRSphWvy8BxG+4GKLr3cccbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=UrsHuq4w; arc=none smtp.client-ip=141.30.67.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="UrsHuq4w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pMwxjGWQNxjDszdE36nZUK33jwyvK0cW7ZWnODeQp50=; b=UrsHuq4wnHLT5b3oWo0PZre/Vj
	VRA6wcsVulqmhkIb7cytt55wn6dx+Cl/LElHycLNMpQlNxF4AFrevHnPO0+pbr8JJJt0yziIz9Ntm
	itutC/XdeCebaip7uWbfIRvQ9fnwQ4a2tRSJptGAb9JHfSldMt5YBpkPm32tp9EsyRODDRgjSwbob
	+QPjCqcXboBwJo4vJfEYniHL8Mous6B93AuupA+/oNb7AGBTPbA+3gDNuN0Xm+kIh/YhmwGVJ/L04
	BfoT2MtPM8cb820Vp7ANxrXRttoah8QbBWoRqRHr2BJ2OU8gbZ8+rkgD3CI14Cu8T7Hh4/pj6kouY
	myptayzw==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout3.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1vI3rs-00HIu8-0d; Sun, 09 Nov 2025 12:46:00 +0100
Received: from login2 (141.76.13.149) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Sun, 9 Nov
 2025 12:45:46 +0100
Date: Sun, 9 Nov 2025 12:45:43 +0100
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: Junio C Hamano <gitster@pobox.com>
CC: Johannes Schindelin <johannes.schindelin@gmx.de>, <git@vger.kernel.org>
Subject: Re: [PATCH] wincred: align Makefile with other Makefiles in
 contrib
In-Reply-To: <xmqqwm41g605.fsf@gitster.g>
Message-ID: <cef2a5b6-8133-0e5a-5523-80625d9d4671@mailbox.tu-dresden.de>
References: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de> <927c2094-3654-edec-072e-1f6ca7d91f96@gmx.de> <xmqqv7jnhzmh.fsf@gitster.g> <19573251-81e1-e07d-0f21-1f90ea5153a3@mailbox.tu-dresden.de> <xmqqwm41g605.fsf@gitster.g>
User-Agent: Alpine 2.26 (DEB 649 2022-06-02)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: MSX-L422.msx.ad.zih.tu-dresden.de (172.26.34.142) To
 msx-t414.msx.ad.zih.tu-dresden.de (172.26.35.134)
X-TUD-Virus-Scanned: mailout3.zih.tu-dresden.de

On Fri, 7 Nov 2025, Junio C Hamano wrote:

> Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:
>
>> Thank you!  Does this patch qualify for the final version 2.52.0 or is it
>> already too late?  And if it is the latter, wouldn't it make sense to have
>> it in an updated version 2.52.1?
>
> Highly unlikely, I would suspect.
>
> In general, after -rc1 gets tagged, nothing will become candidate
> for the final release without a valid excuse.  One common reason is
> that it is a bugfix for a regression that was introduced during the
> cycle.  This clearly isn't one---the aspect of the wincred Makefile
> your patch fixes haven't changed since ccfb5bda (wincred: add
> install target, 2012-10-24).  People lived with that awkwardness for
> 13 years.  They can live with it a few more months just fine.

I agree.  Fair enough.


> Those who _have_ been building wincred and installing it for their
> own (or for their colleages) would have an established procedure to
> work around the unusual arrangement the Makefile has (which you have
> fixed), and changing it this close to the final release would only
> add extra work on them, without helping anybody else.  A good time
> to merge such a change is early in a fresh cycle, so that they have
> longer preparation period to adjust their build infrastructure.

Understood.


> There are reasons we may want to have changes newly floated after
> -rc1 got tagged; for example, I merged 8d716966 (ci: update
> {download,upload}-artifact Action versions, 2025-11-06) after
> tagging -rc1.  There were another CI fix merged immediately before
> -rc1.
>
> The benefit any late changes that get merged has to outweigh the
> risks by a large margin, and CI changes like these have very small
> blast radius even if it goes wrong (nobody other than our developers
> would be affected, and they know what to do) while the damage
> unfixed CI job can cause is larger (CI can deliberately stop to make
> us realize that the service we rely on is being deprecated).
>
> There also is a message typofix merged post -rc1, to correct new
> messages that appeared during this cycle.  The output from the
> programs before the release candidate were properly localizable, but
> left unfixed, our translators need to translate typoed messages, and
> then when the typofix hits 'master' later, they have to adjust their
> translations by updating what original gets translated again.
>
> Is there comparable justification why wincred/Makefile change has to
> be in the upcoming release?  I do not think of any.

You are right though.  I have just thought that it might be good to 
have all the three commits for the update of the Makefiles in 
contrib/credential "in one go".  Yet, this is by far not comparable 
to those other cases.  Thanks for your explanations!

Best regards,

Thomas Uhle
