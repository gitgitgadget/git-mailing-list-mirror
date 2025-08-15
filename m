Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5D1C862F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223870; cv=pass; b=bJIf05U+jNXGf6GGuOdiRs7x724UiqAf081JKkb1Cy4XogbEjKsvPfVnQzlZa2Ylhe7RueEvWIoV3cSCmmU0xoehTYZfDlDNbsPtP44oCTJQcwwX/XKZfU9jy36dyFt8Z6Aby6Q4lLges+Ot8ZOrzzyUlYCWgsq2SNjyp5TZMe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223870; c=relaxed/simple;
	bh=ymbK/i+5yqsM4Fdk1EY1kPp6ckNJ9ck/Ss2rxJR//IQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pJ2i0vez4UMBu9DnLIFo6WlsVv2mCfq4brJzF7yJ4EHpdn5CNkLbRKhCXYjnFvdnQtuBRmwZyAXA6gpi6tIBig4FpfG4rrT/+WcoXAh/qIC1d3MfeECTedPNeZrGQCu5XOLsYPCeC0ICDDOfkpv1wGrCr5qtJ1uIRyy84IGwotg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 442F98A54B8;
	Fri, 15 Aug 2025 02:02:09 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-96-56-14.trex-nlb.outbound.svc.cluster.local [100.96.56.14])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 70C4D8A4EEC;
	Fri, 15 Aug 2025 02:02:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755223328; a=rsa-sha256;
	cv=none;
	b=D4GZgIoHWSMcv5ln7EKCPuhK0tkq3KKEc3O6cX0E2OivjULY9jCsDBG327JE3oPabJ8YPG
	CHkAys3uAKoA7YhbfnKs2IULQMH1nvv3cch++pFv8Fyuf64oYs+lIhbzDE3bJpmjdELzZS
	TLxn3g0yMw1/4sPOhxXEW+oghvriWBoT4cM69LCvkniUrLqd5c93jYamp9XUprsHnvmEE1
	X/FWP6ts/HEqxI64i6EBUX6IOO0mumYOcA256ImIU3wK5E2CCqJ3S+gfPOWJ3IIWglem9G
	XbXIParrmJlphHW+3KpAG0JYcUwkXkQrwgVOOyAVz14jRt8GbKe/uL3kPuP3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755223328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwn8Qqy4+Lgi6ZRmfctm7J2D9wH+qaPPgphMI9s7css=;
	b=7TBioOU258xzY2+RfVrasFWe4g8viqsJmWj8RIrykhXfwj3HylGE/mR2psHWkITd7dq017
	04vYHvYzQSQuAq5luNY5nzr4avOUXYT0M/22R0GJbDPL5sN8tSUcDyiV3dUubzllKoaPy0
	3OWwU+c8AAutG5O98RecAMWGxWwDrhMt4Av6+Z22n6hySkq3c+wbhAJ+78ZPgyLtjSbq9g
	2UAJSOIfUun+l4JOrq2E25xtGQ3+UH41R5z/sTPMaMPNnaAsgucSr6t0oqtxhbkTk/wwxq
	freWJNUuwCNsP8VnGpq6YMTnFs90mtkC1D/RG+JCh/MRjmQnCZMJI73dHQFSAw==
ARC-Authentication-Results: i=1;
	rspamd-865b9ccc6c-jgd7r;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Whistle-White: 16f5620e13e09f5c_1755223329121_1498210495
X-MC-Loop-Signature: 1755223329121:3916425616
X-MC-Ingress-Time: 1755223329120
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.56.14 (trex/7.1.3);
	Fri, 15 Aug 2025 02:02:09 +0000
Received: from [79.127.207.171] (port=51069 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1umjlg-00000005hFD-02bY;
	Fri, 15 Aug 2025 02:02:06 +0000
Message-ID: <16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
Subject: Re: why can't one alias `git stash`?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Date: Fri, 15 Aug 2025 04:02:04 +0200
In-Reply-To: <xmqq7bz5v0mq.fsf@gitster.g>
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
	 <xmqq7bz5v0mq.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

On Thu, 2025-08-14 at 18:23 -0700, Junio C Hamano wrote:
> Look for "alias.*" in "git help config".
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To avoid
> 	confusion and troubles with script usage, aliases that
> 	hide existing Git commands are ignored.=20

Can't one add some kind of override for this? Cause AFAIU, my command
from below would not hide the other commands, or would it?


> 	If the alias expansion is prefixed with an exclamation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 point, it will be treated as a=
 shell command.

Well I kinda thought that... still wouldn't though if it was detailed
what exactly happens :-)

Thanks,
Chris.
