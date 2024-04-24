Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24776156F5D
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000260; cv=none; b=jdFkpp36jwLlhibF2C2+K6aDLEaO26Jy7RC/x0NOJVabLBIdaB8HatDpyzua4JG6TtXWcb2UbhSKP+TwlPFjp/kFhTL99BQ9Y3u7IDvP15UxtNPQhTd14iCNsnBRvkQla7cFD3+qhlyTnUb6XT+vz4n9zMp3X7BLA8KYEJ5cHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000260; c=relaxed/simple;
	bh=iY8hl6+9AR8Ttve1rR3/JFPVh5WGNJfU97+H50lhsmE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=K4hXNR79hcxuCnIB3aLeRXJgpRJJt6Im8MNiuva1QGdFv9DNX5nnK9L1uYfEL8SRcC5JGq+2SNfF7qAm8W77tISVJw0RveV7Ln/Bb+NdU0PVaGHDq60HAduhPK1ZbG00T1FjcMHq7hoILRwkXKT3pLjADW5TopfPyc9iQDvKL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43ONAmLV3788133
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 23:10:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqq4jbqzo3j.fsf@gitster.g>
In-Reply-To: <xmqq4jbqzo3j.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.45.0-rc1
Date: Wed, 24 Apr 2024 19:10:43 -0400
Organization: Nexbridge Inc.
Message-ID: <06df01da969c$a5898a50$f09c9ef0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFgUOKSZnnhd/WqUukqBGZkRweHQrJslyUw
Content-Language: en-ca

On Wednesday, April 24, 2024 1:07 PM, Junio C Hamano wrote:
>A release candidate Git v2.45.0-rc1 is now available for testing at
>the usual places.  It is comprised of 521 non-merge commits since
>v2.44.0, contributed by 84 people, 36 of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/testing/
>
>The following public repositories all have a copy of the
>'v2.45.0-rc1' tag and the 'master' branch that the tag points at:
>
>  url = https://git.kernel.org/pub/scm/git/git
>  url = https://kernel.googlesource.com/pub/scm/git/git
>  url = git://repo.or.cz/alt-git.git
>  url = https://github.com/gitster/git

Looks good on NonStop.
Thanks team,
Randall

