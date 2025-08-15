Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6746BF
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220164; cv=pass; b=Evv6MQcmrETmxP2uh4H+XCKQJBRR6BXloBIV0wqx1dnTH+Y3DDChVy7sF51JzdJ9UAEGiPREXiBvcsp3PMmGS5sanOEW1fxVNMaHGj/nuwlaoLLfTK+qJas2QwhvFNVbyYGCazDXGLhPlI3mY0gLvXdgAGjDRoF2Bn/xnVC68SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220164; c=relaxed/simple;
	bh=wyXxhgzTbIprNa4aZzS0aJrID33KLIM6+gPMB+Ul2pw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=nunCjZgXE9SP3Nn+w3nW3rBDHwxrqOpzUJqmhqi+7INrKJCtl+l6w8LeLOvG0+O2UbYQJBgP1N5x5FVpK3tjaWVjbuPeAF6vZxSQVSdU8LGwjS79NEa6oI9uwMkNA1tmzJ78UIMN85ChdkNCbQu3hMQmZ53IwZ0ED64V+LCZwMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 116B21C4AD4
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 00:33:26 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-blue-3.trex.outbound.svc.cluster.local [100.96.44.139])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 056F31C4C78
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 00:33:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755218004; a=rsa-sha256;
	cv=none;
	b=8NP5eoWajRwZQ1TXEnE3cKKWA315i4qQG+o1IAfJteb5UfTMESADFYvk2xxXWLZYGzvcbA
	DHnGl3Rq6ditFD5OEQErGSdZrVIRKTCH3ZD/sStchmD5lOcLszCR48Zvxyw5+BLbmZeyy7
	C7pUAzBpwr+2famJihws7UyYSGfjO9TIpeWQqOcUebCemTkW9EBgbOnHI/3Hs5ReTfd7Sr
	N1cIhee1clEu2luTXXa6pgsVIBut7nKoyNuuIk/nmmeJsvqSXpAbQgcb9e4ktz40jw7Sq8
	f1yA7eZawmsq50n5qGpRkvkAtBOUG/sXMRAW06QLPCAKa3aT7j3oAExoU/7vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755218004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fDY2w0SN23ZNmSbOubZoxvDfzNIQQpxx90CiuG8JJcA=;
	b=hINZgKapYXLcSZeirfdkoJcCCQY4ubOF6ao1uger0gW3R5MjlF38EiB6GHWl4gsfdWG+Fn
	tLcgz8bo+gEICxcYBfBxTcMeiG4z32O4u9XYRBcOWa046xPwwBfmw1tuMreXMVGIO70UH1
	44mMXME175IYdX8wcOWtSiOjH3mSLOW9GsHAeT0ecTWjCSe8ELxHWgmrvSFrWpb6WnVC0j
	VxiahrF0mR7j174stDPXoXLPDfJjQtkPgrS8borhG4y8nDtpSyT8ZZjIG/KUJpcIk5eeI4
	EDHmxZEux4+7eJ3V11pCOQ9+nJYBc5cE3uGWm3ufPWRS3GU1QdFBYrh5mPn+DA==
ARC-Authentication-Results: i=1;
	rspamd-7c5968dc44-4lc2r;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Exultant-Continue: 31ef91ff22cc1b9c_1755218004674_4239438268
X-MC-Loop-Signature: 1755218004673:1647879138
X-MC-Ingress-Time: 1755218004673
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.44.139 (trex/7.1.3);
	Fri, 15 Aug 2025 00:33:24 +0000
Received: from [79.127.207.171] (port=54225 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1umiNo-00000005NfP-0VoH
	for git@vger.kernel.org;
	Fri, 15 Aug 2025 00:33:22 +0000
Message-ID: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
Subject: why can't one alias `git stash`?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: git@vger.kernel.org
Date: Fri, 15 Aug 2025 02:33:20 +0200
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

Personally, I've always disliked that `git stash` already does the
`push` and would have much more preferred it, if it did a `stash list`.

So I tried to solve this via an alias like:
[alias]
        stash =3D "!c(){ if [ \"$#\" -eq 0 ]; then git stash list; else git=
 stash \"$@\"; fi; }; c"

which seems however to be ignored when the alias name is "stash" (it
works as it should when I use e.g. foo =3D ...).


Any idea why that doesn't work?


Also when using such shell functions seems to be not extensively
documented (or I didn't find it)... the example in git-config gives the
"!c()..." syntax but doesn't seem to tell what the ! is for?

Are these functions executed in a separate shell execution environment
(or could I accidentally override a function from some git shell
script)?

Is there any sanitisation of the environment that the shell gets (or
does it simply get whatever the user has)?
I mean a badly set IFS or similar could easily cause troubles.


Thanks,
Chris.
