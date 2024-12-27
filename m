Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B241FB3
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735321269; cv=none; b=R/RygD7vMEu6ww1i9xusUgqzbi/OpfN5S5LNgc07zi3tiVvslYPEbNji97OlMyEjHoYFrzV/SVe5fOGwZZWscMcurWr4yM3GwtELkfUdFgftpUq6N+ABS/NzC1WdHBvn5O6nKtoYIzKu6L2Om8eqXru/j+zzsw0bcp+fOE4YZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735321269; c=relaxed/simple;
	bh=ffL8y0sozrtBT+tvHq5B4RGfDuEvduW4tFruk+T+wxg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+6cjBdf3A5yiRDz9rRSCCphLH/RfyUZ6sHyd5/nwrhU3yDLnz4U0fSI6dYcA29e4ha7BwjNbXsJviD6xZZBhSdDaDcdBNWv0BXViMrrCQ2W4Zf3zlnvLElco3fO8cRn6+YSPcT5lnEJn2KcEjd9GRMzdsQNVkGG81GZY3vmIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BRHeocA3758899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 17:40:50 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'A bughunter'" <A_bughunter@proton.me>,
        "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>
Cc: <git@vger.kernel.org>
References: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me> <hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl> <s44De1e7kjF5OIY_YVaSJ0DdAavD-4WeZ3XrrA7XJLJO67ShZWLM9Sb1ywSUq58wmCWOTkRfhBBOvw1qCpiiUyygy53wFTetUECruyO1SEw=@proton.me> <TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu_6Ytis=@proton.me> <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me>
In-Reply-To: <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me>
Subject: RE: [help] can nobody get me an email
Date: Fri, 27 Dec 2024 12:40:45 -0500
Organization: Nexbridge Inc.
Message-ID: <01c801db5886$790a6d30$6b1f4790$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFKritSHshqNgashQz4ZwBXeFLZTwJeDm4aAU1uG+wB50anYwJf4dxas9wapYA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 241227-2, 12/27/2024), Outbound message
X-Antivirus-Status: Clean

On December 27, 2024 12:03 PM, A bughunter wrote:
>How do you move this mailing list to gmail this is too much for my =
proton inbox
>here.

Trying to help out here. I hope this makes sense.

When you send a message to the distribution list, anyone who replies CCs =
you automatically.
The git mailing list does that also. So, stop using your proton.me =
email, because you are
The architect of your own demise in this situation =F0=9F=98=8A

To explicitly subscribe to the list, from your gmail account, for =
example, look here:
https://subspace.kernel.org/subscribing.html

--Randall

