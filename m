Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B979184D
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721355369; cv=none; b=gDfQ1Zwb7jkcuPaRI5HKrWwU8L5kKL+IFs5b5HazGz9H453IH0RMaMa5dvJh3Xa3SFbu944SWHy5o9B2gkb/3ppZq2yXJ+KPJliI3sjqc/SiWQdgmtNWQHUpPVybxLXBRLznVRJP8fZsRFGqOf3/v2dnWNhMQ5wcIJ5YILLrbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721355369; c=relaxed/simple;
	bh=6ZpEo6pSafkAzgmcOL8A1HMJ7x/MEndCndHPOsj1GOk=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VZVSl5NNjxo3oFnicyQgvwj6eZwmDDE6f6VjqH74JTfQKi05vYApfFL3QQ4gE2V4ZAD7hHRM3ETEUN45+RAPp2SfYpr1+VDyFTANRqYwt4mPNW4jDXyddnsiZSWt9P3lI6/PBVtc0lQcUEt5IX0Hj6b7vlbL48cu76hBt6BuYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46J2G1oS1151038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 02:16:02 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqwmlivcdp.fsf@gitster.g>
In-Reply-To: <xmqqwmlivcdp.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.46.0-rc1
Date: Thu, 18 Jul 2024 22:15:56 -0400
Organization: Nexbridge Inc.
Message-ID: <010d01dad981$9a5e2280$cf1a6780$@nexbridge.com>
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
Thread-Index: AQIFWOJEOBu7nHfKzxxj5/8qe8cg07GoUQEA
Content-Language: en-ca

On Thursday, July 18, 2024 1:28 PM, Junio C Hamano wrote:
>A release candidate Git v2.46.0-rc1 is now available for testing at
>the usual places.  It is comprised of 728 non-merge commits since
>v2.45.0, contributed by 78 people, 28 of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/testing/
>
>The following public repositories all have a copy of the
>'v2.46.0-rc1' tag and the 'master' branch that the tag points at:
>
>  url = https://git.kernel.org/pub/scm/git/git
>  url = https://kernel.googlesource.com/pub/scm/git/git
>  url = git://repo.or.cz/alt-git.git
>  url = https://github.com/gitster/git
>
>New contributors whose contributions weren't in v2.45.0 are as follows.
>Welcome to the Git development community!

Build/test looks good to me on NonStop.

Thank you.
--Randall

