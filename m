Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE132AEE0
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735233658; cv=none; b=B5T6lGFkJfpnbh/ls1gARqQXrYh3EsiDMuiX06Qzq3wLXrPTcY//WTgwWFJCAiqwmgcFi8jk+D8ED1pljQLVjltD+GXp7dD5NqbFQn+/VngsyHFygCvEV2GQ+vrKY/nOvHyVOo0Qd/MakHW61F8GItHPgc8DmTST5pDvFgRcztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735233658; c=relaxed/simple;
	bh=MQfAgvO/aNpIdU4xZsdXsn2KfR7W9OE4dBy3SwkEe2w=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZnNq97oHvIlHXBdUE8xwuyc/H8yLMLsAK51GHyBsX5CeG7rfadWOO/zBOU2zRg3KwXsTH8QpZ5ow0tBJNGawa4HkmdROY4b0o/Hzi2TqOYGHMhUjWeq4giPwf2FPRjNz1WD6ZQgoKzAc5ncCTIcihi4TK0maVCryt8fJ+EzPn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BQHKdqd3581335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 17:20:39 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Alejandro Colomar'" <alx@kernel.org>, <git@vger.kernel.org>
References: <lwjb3p4mqv6h3mewyh4b5gm4gs6omfapmbd34roexs7yujnswv@xwn6oriqdt62>
In-Reply-To: <lwjb3p4mqv6h3mewyh4b5gm4gs6omfapmbd34roexs7yujnswv@xwn6oriqdt62>
Subject: RE: /etc/git/
Date: Thu, 26 Dec 2024 12:20:34 -0500
Organization: Nexbridge Inc.
Message-ID: <015f01db57ba$7c9e14f0$75da3ed0$@nexbridge.com>
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
Thread-Index: AQJx+1MmbdhywYTVyNILNB2phSczkrHLfgPg
Content-Language: en-ca

On December 26, 2024 12:11 PM, Alejandro Colomar wrote:
>I'd like to have all system-wide configuration under a single =
directory.
>What do you think of adding /etc/git/, and reading a 'config', =
'ignore', and
>'attributes' files from there?  /etc/gitconfig and /etc/gitattributes =
isn't very clean.

Have a look at GIT_CONFIG_SYSTEM documented in =
https://git-scm.com/docs/git
and let us know whether this might work for you.

--Randall

