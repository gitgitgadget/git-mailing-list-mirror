Received: from mut-mta1-se01b-zose1-rescue-fr.yulpa.io (mut-mta1-se01b-zose1-rescue-fr.yulpa.io [185.49.22.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730217E4
	for <git@vger.kernel.org>; Wed,  7 May 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.49.22.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611184; cv=none; b=JA2aovxFLxeivNM0bS7E/AtDE8+WO5WyJ1zK3Zz72qCoFvTENdcqW+Uap6DM0ik6XAfYErx9wX0NlmKiz5wLVacKCA6TfDkVz0xmFpWaxz5CDp4JNGFxJ5n2+7PFh/qVxcKKy2nuqwQ0rmyr2nQrv9KB+FInKcmQSWAzCXsAbcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611184; c=relaxed/simple;
	bh=Tsl6BdWXN1tXcd/C+5W4xdDF1E28sV+N8HECftuzGgo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a9jSxPMiVrxPIKm/uTC03DARbSF8hmH0BwqhTZBxgMeYIkFtYdfSNiTMqNOnehmSCCRkDnMacu6xf/fdoLKVO35h6wnX1m7b/XSEWTV/YZNmP8ARj3WHHJNQ4NXmu8KNzqYTt88pxKgNd5/5P/A/A1uvdWzqtflD64zs7Y/4d/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthieu-moy.fr; spf=pass smtp.mailfrom=matthieu-moy.fr; arc=none smtp.client-ip=185.49.22.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthieu-moy.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthieu-moy.fr
Received: from [185.217.155.54] (helo=mut-zose1-mta-hub-outmua01b-fr.yulpa.io)
	by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <git@matthieu-moy.fr>)
	id 1uCaod-0099EN-Dm; Wed, 07 May 2025 11:11:50 +0200
Received: from localhost (localhost [127.0.0.1])
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id C4B6A100CC4;
	Wed,  7 May 2025 11:11:46 +0200 (CEST)
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
	by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uyHzoYLWlLoE; Wed,  7 May 2025 11:11:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id 2DC80100CDE;
	Wed,  7 May 2025 11:11:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
	by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fqeOfNMsUfA4; Wed,  7 May 2025 11:11:46 +0200 (CEST)
Received: from [192.168.1.82] (209.56.68.91.rev.sfr.net [91.68.56.209])
	(Authenticated sender: matthieu.moy@matthieu-moy.fr)
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTPSA id DA548100CC4;
	Wed,  7 May 2025 11:11:45 +0200 (CEST)
Message-ID: <108f297a-b415-4742-80e4-51ea02af18e9@matthieu-moy.fr>
Date: Wed, 7 May 2025 11:11:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 06/10] contrib: remove "mw-to-git"
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <20250506-pks-contrib-spring-cleanup-v1-6-e6d5ddd79a72@pks.im>
 <xmqqr011h41x.fsf@gitster.g>
Content-Language: fr
In-Reply-To: <xmqqr011h41x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.217.155.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.217.155.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.18)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9p2hGKdLcZfsw7HwUF3DC/PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xwE+hFmHMHy7s8iAlBXqMSJ34yWkEDVsqYuRzEmKCD/jvY
 alByojF4/HJojC+gJeiYLVWfuE7KV6TRwC004sAACNkMkPiMYC+wMzHEMLPorbobc2oE2sGfAUTk
 EY7T3q4A8cYjACAs+j94NvLRgDL8VE2GDhhqlvnVCBLP4t+/qqVq46o/8MwZyVD9QGGfHMq7jJDZ
 ae6/9tkhc4aQqqFfN942RHV7KcBh+Yyy9UjcDMivEsJmn1J3i12zQnpjnAmy5UuY4esEwCgdIg/E
 IjtOg46a7F+LaHXXFQyrAsHe1K0udfbeJGXxh19U+NTtq/kGKqiBEW9ii+hcJOF6qk3sQRLeJOb9
 1qg3iHopBP3/vLDzrhovf28HhjvwUeewP+A5Da5oo4qcHGmq3GQv9ZVj7LkpijicqSalrW2rJb6H
 PsFUVZKs0eeC26uVFs0oAkiflq7EPr0YgoJW9n+OafbCpKg4T3vgTS7kLivzY20h++wKvRaKNZis
 NFiUWHlKyjzuDFeHsKFQTpBp9R1uNwjHsFdDzqgpYxz1gf6QkX8e0GiH1Wgh6RAenBR+licROGbs
 k3YQoRw4Z7svCbphEftyfmEMaf5c+xWmLXJHak999PZHFmWeyMKEblX9h9vPgm6EpheizIhoWwtm
 5CT3thgqYixlBRaMQfsEfUT6qffDgVvEUMWF9507kX9PudfQZl+LBDMrD7q/cJogwbqzsuok3gFJ
 TFE9LIBVCsj7+GXcyREnRV+KD/zPY7Gk9PF60yqIyhaI671I4yi7MsEJJOHqowZWfqOfoY56Kz1g
 bVajKNS5ltNyc8pc5dVBGlMifyclCkSujm58a/xB+XC1kCc60ScQfWjzSCvQ9Y+1CCZHkMcnOSyB
 mtqjtHaipgVbT5gfw10R8xRWgb42LTVX/Sq//5iHE6NKmdYM/wvullW8NNjZ2BWEUGaa2KR6vniz
 CCbswUEHuAiex0HQwUJspzSocRo1RRiieYHPbowxVKku/TiHyo1+EhP4m3G0HBShybIxL7hrJSk6
 0SF3F6RYOYr2
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
X-Complaints-To: abuse@mut-mta1-se01a-fr.yulpa.io

On 5/6/25 22:34, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> The "mw-to-git" directory contains tools for accessing MediaWiki via
>> Git. The scripts are essentially unmaintained in Git: despite a couple
>> of global cleanups, the last changes were a couple of security-related
>> issues part of 9a8606465e8 (remote-mediawiki: use "sh" to eliminate
>> unquoted commands, 2020-09-21) and its parents. We don't ever run any of
>> the tests so it is more likely than not that many of the tests have been
>> bitrotting, like e.g. documented in f8ab018dafc (remote-mediawiki tests:
>> annotate failing tests, 2020-09-21).
>>
>> Furthermore, the code has been spun out into a separate project at [2].
>> Remove the directory in favor of this new home.
 >>
 >> [2]: https://github.com/Git-Mediawiki/Git-Mediawiki

AFAICT, there was no activity at all on this project, neither in 
contrib/ nor on GitHub, for years. I'm not using it anymore and lack 
motivation to maintain/contribute to it, and no one really stepped in to 
take over.

> OK, the new home also lacks activity since Mar 2022, but it
> still is certainly a much better home than having it here.

Perhaps it's a grave more than a home, but that's indeed a better place 
for the project to rest.

> And I doubt this removal needs to wait for Git 3.0 boundary;

Right, actually IIRC we already discussed its removal and it could have 
been removed long ago already.

Anyway, many thanks to this list for the help building up this project 
when we created it, loooong ago!

-- 
Matthieu Moy

