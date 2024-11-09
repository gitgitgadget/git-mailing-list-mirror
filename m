Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC1155322
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163401; cv=none; b=He6xiVy1bqH5cdVl6gTsXT/bywDYEPxW9kRaWsg7g1KdmBCLATT0hkMyatQjM11K7yb0N+Y4bOWZecURsoBkJr/0jlScQxQmEF+5BYMfunwu1i2GC0UUgZC+zwWL3TYuPRxO3lXU6YEuJ0sIsdtUzbKWrtKv8ub96y3ZMlox4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163401; c=relaxed/simple;
	bh=gRuu9nTktllS3yZ8baSRRLZtRFTBY8ariJQ2I6oDQ+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnlWI5eVyYOe9v7EUbhtc33/9OtOeSkJ9yFcPNgvVWHjpgv7zblLUD5nbLOFJIzspioXDlVjV6zgIF7ImUJzHyeJlAuAI8Wg+knLtvUuECjWfrwu8sWv9fJUGidpKEEji+xPSEEnNs9a4VvijOPSiznDfmIFELGUI7ZHxtloQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XlyyH5NcSz1sB7x;
	Sat,  9 Nov 2024 15:35:03 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XlyyH55Fqz1qqlW;
	Sat,  9 Nov 2024 15:35:03 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id flrVRJxUCspY; Sat,  9 Nov 2024 15:35:03 +0100 (CET)
X-Auth-Info: KCu/t9V5/kRtHop0nBDDAZxkJetlLhDgrPJgf3G2adlWQTcDoR1EctoycHhrY8I2
Received: from igel.home (aftr-82-135-83-11.dynamic.mnet-online.de [82.135.83.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat,  9 Nov 2024 15:35:02 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id AA12A2C1ADF; Sat,  9 Nov 2024 15:35:02 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christian Couder <christian.couder@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
In-Reply-To: <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
	(Christian Couder's message of "Sat, 9 Nov 2024 15:01:41 +0100")
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
	<CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
	<CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
	<CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
X-Yow: Now I need a suntan, a tennis lesson, Annette Funicello and two dozen
 Day-Glo orange paper jumpsuits!!
Date: Sat, 09 Nov 2024 15:35:02 +0100
Message-ID: <87msi85vc9.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Nov 09 2024, Christian Couder wrote:

> Yeah, not sure why it doesn't work while you have it.

It's probably of the wrong architecture.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
