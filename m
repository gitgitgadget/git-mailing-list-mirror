Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2410A28
	for <git@vger.kernel.org>; Wed,  8 May 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189207; cv=none; b=kwIteqEt3V8Wu45hWz2mRK3cxhMdJao8ETjOPtLKa6FGguHo1a4Hyo6jDwLafB9NovWm+wWCp558xIemKG/CyCviPrUXOqUSi73pi7GPnCtwMzWIyRjTqb6GcIliJGVhlgp5JOh8uyP95iKrhKFQ3Hl/rTVDfZ+JLB6//GbAE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189207; c=relaxed/simple;
	bh=kM370gwoN+InywX3tMnTMNakeHAJcWiZhjdieFzSt30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RnEmoFCmbvlHjdJSfgmqrjOyYTvfftQv8uf1+nZ2C9IObWeYcurca8I5wRFRMMYvnW2ZAxAsIIvykkuht50n+iYBfMkkJe7lPZtIetVKsCdNKTtKxeL2LAEFZBPfrUioaplhctZJ6wS8QNRRCVhwV0+54xZ7kcADeE/IZ8Qxy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oPOyhPHA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oPOyhPHA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CB1561EB1B;
	Wed,  8 May 2024 13:26:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kM370gwoN+InywX3tMnTMNakeHAJcWiZhjdieF
	zSt30=; b=oPOyhPHA3S6uxUtJUIw1qChIELEQRVWFOl1LiHtjbUTghblvAKAdb8
	r9MZ+7tjr2Qe6mjK3RMpRLfjFpdQ6q7qCXL+kArPoXo/fcbhzAyay4exevfSZ7a+
	TUShf+VQi7sCP1ItTuHqigFWlbExsgD+a31RcTMeIgKfZ+arw7I10=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B6C4E1EB1A;
	Wed,  8 May 2024 13:26:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3DAB41EB19;
	Wed,  8 May 2024 13:26:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>,
    =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>
Cc: git@vger.kernel.org, Helge Kreutzmann <debian@helgefjell.de>
Subject: Re: i18n of git man pages
In-Reply-To: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de> (Helge
	Kreutzmann's message of "Wed, 8 May 2024 16:30:09 +0000")
References: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
Date: Wed, 08 May 2024 10:26:35 -0700
Message-ID: <xmqqjzk4xlis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1FC34F24-0D60-11EF-A5F5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Cc'ing folks who have shown interest in translated manual pages.

cf. 
https://lore.kernel.org/git/cb74f3b-c2e9-947f-8f89-f51e79b17825@softwolves.pp.se/
https://lore.kernel.org/git/11498572.Kui42GGras@cayenne/

Thanks.

Helge Kreutzmann <debian@helgefjell.de> writes:

> Hello,
> I'm maintainer of manpages-l10n[1], a collection of translations of man
> pages for over 100 projects into many languages. 
>
> Our policy is to move translations into the upstream project where
> possible. Only where projects are not interested in maintaining the
> translations for their man pages themselves we host them[2].
>
> Recently one of our translators approached me to translate the man
> pages for git. Before adding them, I want to check with you if you are
> interested in adding translations of the man pages directly in the git
> project. 
>
> (Technically, po4a has been proven to be a good tool to maintain
> man page translations).
>
> Thanks for considering i18n your man page part.
>
> Greetings
>
>          Helge
>
>
> [1]
> https://manpages-l10n-team.pages.debian.net/manpages-l10n/index.html
>
> [2] We collected many translated man pages from the web in the past
>     and transferring them upstream is a (very) slow process.
