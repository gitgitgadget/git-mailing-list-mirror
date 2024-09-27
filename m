Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E334C9D;
	Fri, 27 Sep 2024 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727396475; cv=none; b=DvFprI17jryNUsN1wyU89v5Kz6rkuBsjoixgCtVIjV184YQjCwbWV6vdQ0KmSsD4y+E33TKTR/zpudfOzupdTFwqsS2kcLNbAwfTLtQOrxiwAYCsN9bLvQwCYiu3agcQGZRTpbytlGZ76vpZ4Vl2OUfbcTfNycyoxFL17gBF+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727396475; c=relaxed/simple;
	bh=HWG7RpDLrRHr25tablqDr3PAJLXsIi/0E8gauy9GUCg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=geCdAsEuP1EPBalmcFLW91Y3vNNDndXjh4qaEmHYG68zBa3HoZCYMLNiBWdJozI2eT3cAYEGvEXdTdBirW2LMRgNMydkIfUUh3ZKIjmsE6Kx4CAikjlywiMZXrKoogSKUMfo0ZY/7VVise5dHsJO4oneQbSvbpQ4DECUy2yBgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48R0L3Kp1769041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 00:21:04 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqv7yijq33.fsf@gitster.g>
In-Reply-To: <xmqqv7yijq33.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.47.0-rc0
Date: Thu, 26 Sep 2024 20:20:58 -0400
Organization: Nexbridge Inc.
Message-ID: <02d701db1073$23c0e850$6b42b8f0$@nexbridge.com>
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
Thread-Index: AQMNDtWMcFSu+xH81pusNJ/g6d9/5bAGyHMQ


>-----Original Message-----
>From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
>Sent: September 26, 2024 1:13 PM
>To: git@vger.kernel.org
>Cc: Linux Kernel <linux-kernel@vger.kernel.org>; =
git-packagers@googlegroups.com
>Subject: [ANNOUNCE] Git v2.47.0-rc0
>
>An early preview release Git v2.47.0-rc0 is now available for testing =
at the usual
>places.  It is comprised of 597 non-merge commits since v2.46.0, =
contributed by 69
>people, 27 of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/testing/

RC0 looks good on NonStop. Thank you.

