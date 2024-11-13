Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175321F9EA7
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492512; cv=none; b=HcPqusc0NnlQADzjXf6YB68kBBHmck9hoJetpuujzLRrxwN2V3/sO+VXVFTNXixInBSlwSGH6WhZWlZlCfEPTBJ0SzUN2mc1RmFApXd8ieRCdBmVKCrSYHo43I3jddVhpDAfvs4Hwh6UojkW4t8lgZcbnNRL84sXKMJwOuy9WsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492512; c=relaxed/simple;
	bh=N743VxwD9LG+DqXEzOpIEpYWWPQ55qOyXuwiCJxxOw8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p3d1cUuYcQP7B1jHt+vw49+QyxeRQycnr4HM4amHscVvWHLhcMK3dcjSfNa8RupV53juN/Tbu1j3dKR/Wcq4fKwu5yrHu444LcyJ1McmOEVGr7SPwxapYw9M7SXSfMJZ15zkgFCfh++KQItA7eOycTmaXhyKlAYo6wq/WGGmqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=rQaQSDH0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="rQaQSDH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731492505; x=1732097305;
	i=johannes.schindelin@gmx.de;
	bh=N743VxwD9LG+DqXEzOpIEpYWWPQ55qOyXuwiCJxxOw8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rQaQSDH0S/h43cNG7PdYfvLhIMHIKfH6OxHmao0JKKtMBrkEXK0oyKrXtEv9qz/2
	 bZysXO6B8eeuQIE7osDhWiaUlXDvlY+zTgtYIF+M4IcmZzZ/IUJNIUT5iQPRCGCYV
	 3wB0h8KT/Hg2FfwUg3k398sU3yhkbjNRVXudE8TXCt3LQqEF14pWIKryaCkLmxwU7
	 W9sf95B6f+kzxOhrESIrmIPsZb84Ocrw7a9adsttT0XTGE3T6In59ABZK3wVBYmSu
	 aEbQR+SIafnc03eHa2JpokxPTlEKYZJdy8neStJZWCVQs7yvTXtbF11oZaDrgkyEh
	 8gnLWEbCpx9wlFAvTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.196]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1t2Kbo3oMS-00AC68; Wed, 13
 Nov 2024 11:08:24 +0100
Date: Wed, 13 Nov 2024 11:08:24 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Yongmin <yewon@revi.email>, Junio C Hamano <gitster@pobox.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] ci: update to jgit 7
In-Reply-To: <ZzRXGi_c2ncEJNu4@pks.im>
Message-ID: <492a40f0-c8b8-01db-e4bf-10478f1f6108@gmx.de>
References: <xmqqmsi3262e.fsf@gitster.g> <ZzRP7cR6S6YCWIze@pks.im> <653fd6b0-0351-44ec-ba31-dbae0e2d3ca5@app.fastmail.com> <ZzRXGi_c2ncEJNu4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jhE4sTzBOIANTBzbiXLy6VsnhsB2JMdbY6q2aXCkn692/WtBoSD
 Xd/pVa9E3jZl6i8vn5f8ZQUsA6qz09U3F2LfWUpDPfGXqz0Bj3ijSyWHVfWNORFUBc9CL02
 AT6i9avvikIUfgLjtc7+C/N14dqUiqbnRhlI0VOBN86SnsWKXkHH2S76n9FZFjfWnf2jq7U
 fPVNBgNgOr8OQsXHvQapQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EmY2VSCir+k=;pJPJECC9Z5yekF37YBdFamkw7lT
 TLbs41hjVXXRUPl03g0Iz/ne3RAm4hgtxFaHTbl26bj9YQB7Oclsn/cn/FNVMjbRPX6H0BjW7
 mGsNKHCHWv60ZITgcVgdjRvyP31aYy7PKQADO8IwnyZ9E2fbiNBsWsJIOuOt/EYv8egDbe/iL
 xxYUgaxAF+St3OOs+WlGZwigp4tmtJImun3cWtZ5Qmhaqr2MLbQeIfj9asKyR58s7+hhgtAy7
 DO4okj11epxw3rK5+VfW0vsIDOdixj9hGEjZk4gpjkJt6kS6anKnqEodwQlW4F1+DahyB4spy
 q9BzHIGpenqIELNpvqHl0w7Oj7szKZMxqrrN/HQdlNiYweEgzlepWkfBx/9jgVZ59zUCjvjTY
 jskZOACfSMKDoS4zOpBVDBvVQteg8XQNThz7xPq+7BJ5ETwQVZ0fMlYBBBBe/co+42GVEr7Bt
 wWGylTdXo2P6GkZ6vp80mYu1zYkluBEJ+4GVYbE67JhS6iFPQyfcRC91RnyaNfV0twKYzlU1I
 2i7DBru+ztO8gfeF5kd+wF9o4pShI5VtTQcX+FA4cmjxvw5YP77ZrU+4ndMO/p5qeE5RgVvn/
 vs07bVmhsXGM/XWrmltu2XQE64a/XVDDtvSlbGT5dvkFOUhFiRsZE+fUTjowMVQdUv1Hg/R/6
 WOr+YbSqduVkEW4x7Gb+Bihz2uw6WiAfaMSV01vRMnxwkzPnPQzVnrYSK/d9pATmbY2iX7vkg
 pjZXEQCMLx7xnEsrwm9XG6WthgO+VNazTPGzkPilia2UnJ8VtOFjHjbICG5QPOaJjKQlnJS7f
 6yb2AD6YmRguIgKMY6DjV4988K2XkSOEVK69cMI2loudcmBUxqWq5gGEDlxNLa6B5tbaaga8Z
 eq+VJf3piWi/Wgzd+5qE29AEgOdPQKcLov/3r6OYFlGFXJm+HYLTwJtP5
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 13 Nov 2024, Patrick Steinhardt wrote:

> On Wed, Nov 13, 2024 at 04:35:44PM +0900, Yongmin wrote:
> > On 2024-11-13 (Wed) 16:06:21+09:00, Patrick Steinhardt <ps@pks.im> wro=
te:
> > > Seems like all of the downloads result in a 403 now. I was digging a=
 bit
> > > through the mailing list archives (jgit-dev, eclipse-mirrors) and
> > > couldn't find any hint as to what is going on there.
> >
> > It could be [this]?
> >
> > [this]: https://www.eclipsestatus.io/maintenance/456545
>
> Oh, that I didn't spot. Very much looks like that would be the root
> cause, thanks for the pointer!

Sure enough, it looks like this was it, as it is now working again.

Thank you Yongmin for finding this valuable information!
Johannes
