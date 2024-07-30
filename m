Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C2145A11
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379898; cv=none; b=g9otZ5gy2uqvfl3xD0PxFVZS6vqL1ATIUfUIHPJ7JJzbrTbW2arDEFCgXr9CRCNzy2OZn51HPtDgwfUY9LXOW03k0221JAuAiGcdDQdKQPkHeu5eg4jP4sZv+RLoX2mjDkXcrKoShQaQ7QvOGOSDYKKZkmU+g6879hk2cd6M++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379898; c=relaxed/simple;
	bh=5F5cnDUNA5PNvAiuYihnZphJWzqXM6YDjthbq8Yp+zE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GoNZawTAXkwK9FBFMdvppCX2HEYm3/6V5KU9nrjrBNTHyiqKK/b5gZjb8Y2damjbCiBofd1lD+vc+OkTq8+WaUPPgPVrMjMy2bCuRydqp3wLMmK+S+gRaJ0fLJdy7zV3I6oMpxJqH65pJOueNyZppwY0vWRrdWgC183Ae/SWEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46UMpWCD3141421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 22:51:32 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc: <git-packagers@googlegroups.com>
References: <xmqqzfq0i0qa.fsf@gitster.g>
In-Reply-To: <xmqqzfq0i0qa.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.46.0
Date: Tue, 30 Jul 2024 18:51:26 -0400
Organization: Nexbridge Inc.
Message-ID: <000101dae2d3$05a3d210$10eb7630$@nexbridge.com>
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
Thread-Index: AQL9v0GWykiED4xx3+20hDe5YqxRmq/KJxEg
Content-Language: en-ca

On Monday, July 29, 2024 1:10 PM, Junio C Hamano wrote:
>The latest feature release Git v2.46.0 is now available at the
>usual places.  It is comprised of 746 non-merge commits since
>v2.45.0, contributed by 96 people, 31 of which are new faces [*].

v2.46.0 has passed on NonStop and is being packaged for general use.

Thank you to the whole team for your efforts.

--Randall

