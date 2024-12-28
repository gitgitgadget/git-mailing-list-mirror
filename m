Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BFB644
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735350979; cv=none; b=GNBq9XoftI7Dl3Od2IiPBssyhXm59r92lOJM1kzQzfvCTQpMBFjrPG95ABOEdJ9NTgfIAJDX0KxW8tKidahvuAgF4paONxddXrUegQVlai/kphn5pp1allOD3yFOt034iN4PIiy5Pe4FQ5KZLCj3u4KAvJtt1WwzE8WzY+hVg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735350979; c=relaxed/simple;
	bh=QJRFIy08egKTJVUFJvyN9mP4GPY7uM6+Osmt9BfnZUI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ancylS6cmCDX8Beep+w0INfxgs9xsdZ/HXi9ZcBh1iLzQ3LDgxKDtMD96KoVPkltlRee6jtPqpe3mp4NF4kQs1m+JBfS/HTJW++dslrh5gt4wUzUfr8p4fp65mCr6uRWdCE/qWopiCMAOSgyufDbw2vRzvsdl/uqCCDSEXiuRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BS1u4Re3818287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Dec 2024 01:56:05 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'A bughunter'" <A_bughunter@proton.me>,
        "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>
Cc: <git@vger.kernel.org>
References: <4wL3MobzQEJEcq565GgPg4K-l5xzGERtmFhRm9FgCnlyU5rOMCgLMaWB3qzFR5httauT4gi7peWUjIfR0j_nBtiatlTpqp5xfTXnz-kX0Jw=@proton.me> <hzyhvw4pe42yqbuqdbgl5bgnxz2kd5mxxh6jnklnqwvembueqv@b6oaetnegprl> <s44De1e7kjF5OIY_YVaSJ0DdAavD-4WeZ3XrrA7XJLJO67ShZWLM9Sb1ywSUq58wmCWOTkRfhBBOvw1qCpiiUyygy53wFTetUECruyO1SEw=@proton.me> <TpuMiCTLZ7JDXxJPgVNqcYXWFavK4asar9Gk9uJiiYp1nbqmKlP22mX6xiDOKHKr5yaN7ZH7jXoISqIY67wmbFfz8i8MsYokeomQu_6Ytis=@proton.me> <ErRnPDWInS44QmxYjAyDuZ9aaZgBwRoP0xRdx0qln2dHF_I6JK6zYErrx41iQaN6GOb0iOWeEMMEXtWzlVr4ayLUUX9L6yDkpj23O8ubNPg=@proton.me> <20241227-positive-cyber-guan-b3891e@lemur> <ZdbN-WEAvzrUFGmH6BlSKp8gAbRpXe8afMWdR3cD5eR8mlYzxp4ICi0kuSlptzYjj0qMMpz1zgbtgM1GHSLGWq8ciWR0jxnvONPmx3F647o=@proton.me>
In-Reply-To: <ZdbN-WEAvzrUFGmH6BlSKp8gAbRpXe8afMWdR3cD5eR8mlYzxp4ICi0kuSlptzYjj0qMMpz1zgbtgM1GHSLGWq8ciWR0jxnvONPmx3F647o=@proton.me>
Subject: RE: [help] can nobody get me an email
Date: Fri, 27 Dec 2024 20:56:00 -0500
Organization: Nexbridge Inc.
Message-ID: <01fd01db58cb$a85b1b30$f9115190$@nexbridge.com>
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
Thread-Index: AQFKritSHshqNgashQz4ZwBXeFLZTwJeDm4aAU1uG+wB50anYwJf4dxaAlps6GoAplDs3LPEn5tA
Content-Language: en-ca
X-Antivirus: Norton (VPS 241227-2, 12/27/2024), Outbound message
X-Antivirus-Status: Clean

On December 27, 2024 8:30 PM, A bughunter wrote:
>I take it I just need to unsubscribe here and subscribe using another =
email: that
>there is no moving the ML account. So how to unsubscribe?

Unless you subscribed explicitly, no action is required. The emails on =
this account
Will stop. Just subscribe with the account you want to use.

