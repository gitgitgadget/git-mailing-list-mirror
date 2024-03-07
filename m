Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D72380
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709771328; cv=none; b=ZciYxGrbSu+dQszCC7X4eEXQKzP/bzZZzgMFqfC8FPobz8jjlGUtORbWTmsGsAPBl0ZujLsUhaD+22kA1ktlmFNdIyWi+GqY2hXbxEkX0STO7pVEp6xSLWNaMJEzvagJSUPzFx3JCJ+jrTt8UU3tg0rjcfb6Zt+fqzfnOFbKyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709771328; c=relaxed/simple;
	bh=cZf85iREgQP/8ZpF9FEYSVFAbALV6DNBZhLfGC7XW4Q=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HlB6iUIyjNbJ4n0xZ2+JBHLcmIzBBEspCA4pvqIFopxGJaxWfZBKoCjCkBwWxA7gpTBHCMarpMdLFWeeoDFeHmDyk7UHu2G5eEjtlzAGQmcVV1Ect7eRJXM/CkWfia33udBHnsJVeUWIQnly8kiFJcjeXMrudYQmHPwQRhig7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4270Mpna089353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 00:22:51 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Victor Porton'" <porton.victor@gmail.com>, <git@vger.kernel.org>
References: <0d741b90-8307-40cf-b0b3-163203651a57@gmail.com>
In-Reply-To: <0d741b90-8307-40cf-b0b3-163203651a57@gmail.com>
Subject: RE: Bug in Git
Date: Wed, 6 Mar 2024 19:22:45 -0500
Organization: Nexbridge Inc.
Message-ID: <092101da7025$97297b70$c57c7250$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQGzTOH7iGnwd6GOJR6n4qkHT20a/rF5sO1A

On Wednesday, March 6, 2024 6:52 PM, Victor Porton wrote:
>Recently updated Ubuntu 23.10:
>
>I tried it several times - the same result.
>
>$ git clone https://github.com/dfinity/motoko Cloning into 'motoko'...
>remote: Enumerating objects: 104759, done.
>remote: Counting objects: 100% (5702/5702), done.
>remote: Compressing objects: 100% (2333/2333), done.
>error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>CANCEL (err 8)
>error: 1600 bytes of body are still expected
>fetch-pack: unexpected disconnect while reading sideband packet
>fatal: early EOF
>fatal: fetch-pack: invalid index-pack output

What version of git? Do you have a firewall or proxy between your =
machine and github? This works correctly on 2.42.1 with no proxy.
--Randall

