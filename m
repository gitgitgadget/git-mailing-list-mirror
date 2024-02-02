Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE81487DB
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893580; cv=none; b=dEKEsmXXpS0+C1DhnxiOqFj5AKh6/+EtXz+983Gmn9t2ZR+vMLtYTkE8hZxI10zy3emGg+e/FmIz8ftXI/P3grM9PBgvrfqR3dqUkXRL5lA5FRqv2TdjxXsbogTOJ1EtyCWNhVnUW/Yfx7Jsb/u2R694CSd13R1897LaXLXhCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893580; c=relaxed/simple;
	bh=Bas0G7FJjENR279S1UPdZplzyt2eBjwaACpze5kVa2M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWycK+idGyPCWh8/Td5u4dtVbis8dC446rQwpRxUr9njjJWoEJHcx3YMOgNbxIsq//yanDq0luKsk8m7fNvtBJVWcNXEQjbSdmlzq3lkFRgusPD1QrK1aManz93UZoJGIQJSZpZrVKBkN943OiPiNKClCVBkVC1cd2hRJaNrAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 412H6B8v1727457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 17:06:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Sergey Organov'" <sorganov@gmail.com>,
        "'Hans Meiser'" <brille1@hotmail.com>, <git@vger.kernel.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>	<AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>	<877cjm53bf.fsf@osv.gnss.ru>	<008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com> <xmqqcytevmwq.fsf@gitster.g>
In-Reply-To: <xmqqcytevmwq.fsf@gitster.g>
Subject: RE: Migrate away from vger to GitHub or (on-premise) GitLab?
Date: Fri, 2 Feb 2024 12:06:04 -0500
Organization: Nexbridge Inc.
Message-ID: <009601da55fa$1ecc9580$5c65c080$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMTzlW4975feouBsT254Lv1BIoWdQGhQd7aAcbbN+4BmxetWgFZgewTrlFxmRA=
Content-Language: en-ca

On Friday, February 2, 2024 11:42 AM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>Did you consider to rather read the list through
>>>gmane.comp.version-control.git nntp newsgroup?
>>>
>>>This way you get only very specific mails in your mail-box, those
>>>where you are explicitly CC'ed, and you usually get more support for
>>>structuring from NNTP readers than from mail clients.
>>
>> Google is dropping Usenet NNTP updates on 22 Feb 2024. I would love
>> that idea, but it has a limited lifespan.
>
>You do not have to read NNTP newsgroup via Google Groups, which has, but
will be
>ending, support to gateway between them.  The suggestion was to read these
>articles over NNTP instead of subscribing to the list, which does not
involve
>anything Google would (or wouldn't) do.

I should have qualified this with "free" NNTP. I have only been able to find
for fee NNTP servers where I am. The search continues.

