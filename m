Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306A183CA3
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849258; cv=none; b=HhkFc4HyqzxcIuDOUir8ytD4ERCiSRxnme9rfxaD7ysx9SSnMti6BJojO6l+zcfmrcyO+wJMiNwxb40ntW+5LRqSxrATgtUEKrlG4P0Dlk9dAxzJ4VmZltpOO+ephn+PK1zTxAzEOyDEf2ReWby7+SAhkJfXIKrGGXjsatrvaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849258; c=relaxed/simple;
	bh=ywTm0rOnVdtJtmtPfs0ow4InCGKolgeU7HmEFROKrRQ=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fEcNRLeGRWNb8vMrXfoYfevx2L3TFdXHYhQtnWG7fWkGDvrX2X0Uo9VaHSyc0cyBGj90fOpAH7wDpkTEhfMxnjGDbt2CxLiuSyZjXgcKTtCjQtGAp88RF4f9OFvjN1F26UgW0BnXp5drH6Y1szFm1uuMMoHm3JQpr0EjLDJB/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48KGKlXG362576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 16:20:48 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2D/b1ZJbTlC1ml@nand.local>
In-Reply-To: <Zu2D/b1ZJbTlC1ml@nand.local>
Subject: RE: [TOPIC 01/11] Rust
Date: Fri, 20 Sep 2024 12:20:42 -0400
Organization: Nexbridge Inc.
Message-ID: <053f01db0b79$0d885b30$28991190$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQF24rJ2Q0W9JcDOH4N3ZxazDM0CYQHP+YxMsxqrHZA=

On September 20, 2024 10:18 AM, Taylor Blau wrote:
>* Kyle: Rust code in the Git project; do we want it? Why would we want
>  it?
>* Elijah: Anybody other than Randall that objects to it?

To be honest, I do not fundamentally object to Rust. My problem is that =
the
Rust team is not supporting including NonStop as a platform. I would =
love
to be able to do the port, but it is not up to me - it is up to Rust's =
permission
(or lack of in this case) to support NonStop, and I do not see this =
changing
in my life-time. Depending on a piece of technology where control of =
where
it runs is outside of git's control is not responsible, in my view. It =
restricts
where git can run, and excludes platforms that currently use a critical =
piece
of infrastructure (git). I have tens of thousands of people in my =
community
who depend on git on a daily basis, and simply kicking them off because
of a decision, or lack of decision, that some unrelated dependency =
controls
should be (unfortunately does not appear to be for git) a showstopper.

I am just the vocal one who is paying attention to the issue.

Sincerely,
Randall

