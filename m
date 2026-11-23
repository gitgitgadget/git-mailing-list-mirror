Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795401359;
	b=lhWZ34+0K4j7BPsrecx+1w/wbxxDFi1OW5tWNQPTHs7wSPkNEZGF3Tcq2XjQ/pNNQqwJ
	 w8jUtD+6c4DFrfsOGVWBpou6T93uBju3wNMC7fcDUM+b2SjYwslHWejIO6AWr5sgqkfiC
	 VprUecX21asJvdcCY7Mu5NThAjLmApQXqj2ay8b9ULGAzAZIaIF710kG2rvY30Eqe+Aer
	 Mj/+SU9KG8b1H+4ohC0OERAbKBvxrRI4jhXjJzGGe9H3bs4fp3TjiIwLTjJwXnfO4y21D
	 3v/ylwP6iD6asBSLJpy2Uh+tUJPLVVr+zLhzL68EuSjfVyn71ac2rtPB9NCep01DpuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401359;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=awME3iYt8MUhIdimfBXNKsYSfxe8yCNPooDbq0WLWrM=;
	b=niTsoBK9k/9WU0y78wf1XULoB5KhHaYgOf+FG8U85hhRsu109hVWUMb4OePuDFAxr0fN
	 DhK1wusczmFcvwRjYarutOTLM8S8HISd0t4Y9cER0XzCMb5JrBPvHk5r5OhauGBrr83Y9
	 kcvM24RDJpO9YQrbc+x9igurMV3Erh2krzRE8ET+JeO1vO3DcYvCJrd2mTJ6dF6tWZVZB
	 OprCmdCMWieOITlqAQVPmGfzpZElFJLs1Qb7LRPCtRAT+YyGydReEQEeoHLkL/jd1WKl9
	 4Z2zCywPZaek9z1nc1GGryRAa6narIQ3pXOaTp6ccr1de49jP+PKcZUrDJBrJVNnaRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=EAjsbO+y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8A606A339
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 02:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D8A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=EAjsbO+y
ARC-Seal: i=1; a=rsa-sha256; t=1795401354; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BPxOs8X1X6AL7sZG1aOir/Lq/JbI2LdkVlzwE+R13q5WNnhehcTLZB5ZJAU6UhvRXUgUt8T77X4aRGXmei0SLQpkdLkmcFhc2qqYFYs/zn3XCnyPoUqblC78Md0WLH3nsGmnze+oh47fat0DaQw9ljNR8AS58jYza14IvtROek8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795401354; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=awME3iYt8MUhIdimfBXNKsYSfxe8yCNPooDbq0WLWrM=; 
	b=YvjxrT0aaziKB18a3piKqpSMj+qLDja6eMuOAQ3GTSIp3ykF41eSL6fMIemQKWS7s5yJP/PXezIsSxPBZT6LQB3GcCGFZOlGnxxoUFljNpWgp5H0HHHBt8QwyVKX1M8pt2/drgqDArvJadtCQZ9ZoO0sHmh8Yt8IurA3TV9PMEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=EAjsbO+yeAmQk6uF2amMpzNbeQ9rFmrT4Sq96bIpTrUzDOsRjQDIReIbxzpmMOdEL892tydMI1gVstW6ulrOUY/ICtjCeWbbvPQaKMb4qMBo2MraqH5SDdOwVMb95KLoOWoRK24l5FWKtuyHaeVFa2eoZenDzkntzYikpLlp968=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=awME3iYt8MUhIdimfBXNKsYSfxe8yCNPooDbq0WLWrM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179540135308225.929488927976536;
	Sun, 22 Nov 2026 18:35:53 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org,
	Tanga Joris <tangajoris@gmail.com>
Subject: Re: [PATCH v2 3/3] credential: parse subcommands with OPT_SUBCOMMAND
Date: Sun, 22 Nov 2026 18:35:42 -0800
Message-ID: <20261123023542.88325-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261114184752.1417-4-edsonwasswa54@gmail.com>
References: <20261114184752.1417-4-edsonwasswa54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Wasswa Edson <edsonwasswa54@gmail.com> writes:

> This changes the behavior only on error paths:

Not blocking, I gave my Reviewed-by on the cover letter. If you
reroll: "--end-of-options" does what "--" does now, the case Tanga
mentioned:

    $ git credential capability --end-of-options
    version 0
    capability authtype
    capability state

> -h" shows help for that subcommand, and makes the subcommand names
> available to the completion via --git-completion-helper.

Also not blocking: "git credential --git-completion-helper" lists them
now, but bash completion still offers nothing for "git credential
<TAB>", same as "git hook" today. Is a _git_credential meant as a
follow-up?
