Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EE306776
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973742; cv=none; b=hous0bHMg+whkuDQ7o7sIqO0Ah8/lY+MtUd57EWXMs4sv08TxXef391RcBxt3hK3iHXVwHmDigDUF+fbxwBM9k+6jRRE2CqGFIJdKMmrfcvbFAt9awT22kbaMnhbl+8+uHO7YGajCyLGy0EoCaPL48QZRJdRMCXf6WLatvEHvkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973742; c=relaxed/simple;
	bh=PBOa5mabiptJeJTLYqzE/WcRbNWLWG7J3v3LgAnZMYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNxuuynqeQMlrAwoZloHliYd7ETVXYQ43dNPMso5Jbq6Hse26YFB6bxQHC92883jrMarTQtwUChbQ83hmT5eKhztUtj+EE4rrVP+mNtCKqhEcMgBRidOUmk0aHGhbeSa/1KkFeGxhx9aCJjU0hzKXYrG9jscCfUJVfJ3EQYjnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=AOqMQbkn; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="AOqMQbkn"
Received: from [10.0.2.15] ([195.99.11.174])
	by smtp with ESMTPA
	id jN3owZQyI9RfhjN3qwIxqO; Mon, 13 Jul 2026 21:15:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1783973731; bh=IbANVzFz15qQr/YDxGitxE3kCNNxqpNs9UmTLKsPAcU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AOqMQbknNqsIzJBqcsp+q6fu1jaFsfPrpJi0mBgmjaTFN8lga2mv0pVDdHerMs15A
	 J1+5+fo+DHrAcL40n+fW6D2f+PFm7PAf8ITSZbp5wRjMPIBhBJ2OKFKOggPsClp2ui
	 uLQLwwtM10dWk0HG8F2xruZSj2c3oQhAKJOIQZBWabiO6mRP+8hQjPVEfvKiQ01UZN
	 vUt1iLx+KJA9NOkQ1fyrGv9zdqkQRnEmXJXbj5H7LnzAqPZki0KG/HVkviPk0UYNKf
	 gv1h/jD5V3Hj9bcNPyV0phrtkxYlNEzYCzQYNFNCn7YuVdabKpZw4kvwZPSEWzApx9
	 dxM4Yvp9v7R/Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=S5R6w5sP c=1 sm=1 tr=0 ts=6a554763
 a=rWEfxJwGD0TuYe46u5FB7A==:117 a=rWEfxJwGD0TuYe46u5FB7A==:17
 a=IkcTkHD0fZMA:10 a=8pif782wAAAA:8 a=48vgC7mUAAAA:8 a=yMhMjlubAAAA:8
 a=ECa1zBsbeb-itsmtN84A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=c8AP_gY5QSoA:10
X-AUTH: ramsayjones@:2500
Message-ID: <82ef71fc-8099-48dd-b841-87188bd39fa0@ramsayjones.plus.com>
Date: Mon, 13 Jul 2026 21:15:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cygwin v2.55.0 test failures
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: GIT Mailing-list <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Johannes Sixt <j6t@kdbg.org>, Adam Dinwoodie <git@dinwoodie.org>
References: <f65466c9-bede-472e-ad57-e72a5289be27@ramsayjones.plus.com>
 <20260712200426.GA11328@tb-raspi4>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20260712200426.GA11328@tb-raspi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPWyNwLVn5h24nd5BtrBnPPdUOwc8XQB9rbGIjqmzMSGj3/hPNXQSMiQpj3Q0tYZV7kCT73b/eAlAI0goue5nbD/AYE7l17H5UBTvmLVutvURaVN90B8
 xprQl0bmd6pbBBK6+FXaH9m/qjgZFD82INb6ImQBmfv2Gjl8aBDr/R4fpca32H06tIBU/C3IfzyUuUX3OsBmSXK4PDKJDFQHApg=



On 12/07/2026 9:04 pm, Torsten Bögershausen wrote:
> On Fri, Jul 10, 2026 at 07:32:23PM +0100, Ramsay Jones wrote:
[snip]
>> [I also had a note-to-self about 'mixed / and \ urls' in the config file
>> which is exposed by these same tests. So, another patch may be needed?]
> Not sure if I follow. cygwin allows mixed / and \ . What should be patched ? 

Yes, maybe nothing needs patching - it was a note-to-self to check that the
mixed urls don't cause any issues and, maybe, normalize the urls before
writing them to the config.

>>
>> Anyway, something to think about. Hmm, I suspect it would be best to just
>> tidy up this patch first. ;)
>>
>> Just FYI. Thanks!
>>
>> ATB,
>> Ramsay Jones
>> diff --git a/connect.c b/connect.c
>> index 47e39d2a73..6f5715e938 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -1088,10 +1088,12 @@ static enum url_scheme parse_connect_url(const char *url_orig, char **ret_host,
>>  
>>  	if (scheme == URL_SCHEME_LOCAL)
>>  		path = end;
>> +#ifdef DUMMY
>>  	else if (scheme == URL_SCHEME_FILE && *host != '/' &&
>>  		 !has_dos_drive_prefix(host) &&
>>  		 offset_1st_component(host - 2) > 1)
>>  		path = host - 2; /* include the leading "//" */
>> +#endif
> 
> This very lines come from
> 
> commit ebb8d2c90fb0840a0803935804e37e2205505f23
>   mingw: support UNC in git clone file://server/share/repo
> 
> ...and I can not see a reason to remove it.

Heh, I just read a few references [1][2][3] about file URIs to refresh my
memory (I read the RFCs many many moons ago ... and they seem to have
changed in the meantime? At least I don't remember it said that! :) ).

I seem to have misremembered the 'number of slashes' after the 'file:'
prefix as three or four, not two (specifically with a windows UNC or
absolute path). However, I was clearly wrong!

[The 'non-standard' rules on win32 are wild - git clearly doesn't support
all the edge cases].

OK, so I probably need to look at the two failing tests again - maybe I
need to mark them with !CYGWIN.

Anyway, more work to do! ;)

ATB,
Ramsay Jones

[1] https://en.wikipedia.org/wiki/File_URI_scheme
[2] https://datatracker.ietf.org/doc/rfc8089/
[3] https://learn.microsoft.com/en-us/archive/blogs/ie/file-uris-in-windows




