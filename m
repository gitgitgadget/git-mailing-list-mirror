Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067936;
	b=UVuMz4YaoyE6sOuf+ORTuEvxiQqsyP/N9l7//DgcUGNINMmHnP0oWz3XtlD1Et86Aut8
	 1EP+/h3NQp5vlev1vOXo8eSEpXjYaTOkW87F0TSsx/DOdEyM/V5dlWSL0tqiexMRExVoz
	 tCgyS4H1ASsk62SoGib6YghWEcrECqYeiitc5RUyu1hp/kyEt6uwX10bzfQiaH+YYAYH5
	 6syiTixTQ9PV7888nBKWxpIm5itliquSCx01BzVkwBEWg4fnHMfAvFRlUc2eCFCCjFbkX
	 WnYQYMYaQegOFXAsWvek2kK3V9kN1IWZQcJHEOQ/kLo8xNJgPCCjbdvdn4wHHLZ33BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067936;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4rNwl894Ppr0MCbTEUlSBwlRnpGxnLQSHQE0xeXhdZg=;
	b=qlg8rQzN00GfXmepL6NUs267K5XLXiLW+1bx59y5DGWV/3+PF4redAYhP/PF7NMQ2NEB
	 K+Q7WvwRj9QjQhIANUkwhekwdeKx7uvfJrBEF/lpcTWJvmK1h8GtME70zDepyDm1YQenu
	 9JHIbM4CXKZe4j/VFnLiKiqFv7FG4uBcHkF1a3byrbG91SdQa8Wo+pczM54XOtq5GYlvz
	 1EREyPW5KR41mgWgfzZzGWAONiXWYOtvCZ+rslwDKLe5acm8h+s/gJ3y5PhojQrroaEbC
	 H/qDWlfJusxHMexDYY+TTh1fmK5ps+LKUw0OYSVp/ONuF5xppYup/Y7TZTc8MvE6zmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=DpfwlQAJ;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167E606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E167E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=DpfwlQAJ
Received: from localhost (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AJ5wj1r1961901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 19 Nov 2026 06:58:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795067926; bh=4rNwl894Ppr0MCbTEUlSBwlRnpGxnLQSHQE0xeXhdZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DpfwlQAJfXSDCnJrk7whzhX8xwD7UfQKv7tyz2AGx65/jb0T4RrBX6z+fgkZ9L+ix
	 VK9LRjtbB4fHwOa9KLr9i0hgcW438UNSkMbr5Qjt6K4bsvP82PfYE5hdW1B7okFeQm
	 rMmtzYglgH8RBFtFrdtxkfJhQzKKQvB4yydAF8bI=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] utf8: fix comment for utf8_strnwidth()
In-Reply-To: <CAHWeT-Zzvjx5knLdCdxUmn8zmkAk2qrzzvXkbSjhCibWy7hAeQ@mail.gmail.com>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-2-3f2aaec15d31@gouders.net>
	<CAHWeT-Zzvjx5knLdCdxUmn8zmkAk2qrzzvXkbSjhCibWy7hAeQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 19 Nov 2026 06:58:44 +0100
Message-ID: <gh1p8hbbvv.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18 2026, Andy Koppe wrote:

> Dirk Gouders wrote:
>>
>> The comment for utf8_strnwidth() states it returns strlen() for cases
>> when the given string doesn't look like valid utf8, but it returns its
>> argument len in such cases.
>>
>> Fix the comment accordingly.
> =E2=80=A6
>>  /*
>>   * Returns the total number of columns required by a null-terminated
>> - * string, assuming that the string is utf8.  Returns strlen() instead
>> + * string, assuming that the string is utf8.  Returns len instead
>>   * if the string does not look like a valid utf8 string.
>>   */
>>  int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>
> "null-terminated" is wrong too.

Yes, I will fix that, too.  Thank you.

Dirk
