Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652123;
	b=ve5fUXrgvgG+hgLmk31bZj4BviQ+6jK7oLimgB2l87PkD5VT3PTODNfW6NxDoZpLK1Ys
	 C+1lHcQBo2V/bCrrFC3AKV7yMaCzH4KbsWEelOLh2aSvvrgOe8gZWg5Ys+yMhCsL6tY+D
	 pAt0QQv/XBTUjWrIdOr3uaua4eiaPSk3QSwxj2C/IzZwPrmCe6uBaM2Ov0Lu/r1c3xDBP
	 QzENCsNE8Snh/QIK6yBEAcjOMTQSm+Smp+vD6mW+lBhqEywkcGNYTMnexPH9kwAJoN57z
	 Px8uFTLnCFuGsYGsFl9J2CdiYApmGGMJO/yW8EE+TTVo8+R2wkXYIfxAEkeTEo1kxAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652123;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:User-Agent:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=kNSVJmheWcjwxizdLQ58eP8AoIZ41az4wqbBsDKCTtE=;
	b=1jdfhOVjl4D6+8vvZ7pQkLec7U0089v45sSbv1I8Gq3KOANmfdLDNaKEFkeje+2w26W/
	 MDbszlehoaauQ+A1kwEUA9V5X1uDu7VmcAnGdZtWU7N1mLtuGq2CaRqYYusppITggXBOd
	 P74LbPR9NGCWgLsBB7bWWRPc9FAIGmabEy+S/1SyECfIsTol7U47iFV0yNp5rLt7pIZ0J
	 l5JT0u4gOECPb9emvh6SWNYwsuzJdx2tuXWz/5yQBZLnzoPWxFkbtUrxJtkocTAcXxxui
	 +E30RkdCgZ+9HuNV6U0FwUlF3ls0fQTHhZ3nohXdaE8gkdFRdT2Y/+uTQLrFYiet+ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=PlSXhGXi;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44975606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 20:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44975606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=PlSXhGXi
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A2Kfqbv004994-6A2Kfqbx004994
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 22:41:52 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xNyqm-000Z5S-3X;
	Mon, 02 Nov 2026 22:41:52 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 22:41:51 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 93f45d37;
	Mon, 2 Nov 2026 20:41:51 +0000 (UTC)
Date: Mon, 2 Nov 2026 22:41:51 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Ed Maste <emaste@FreeBSD.org>, Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
	<carenas@gmail.com>
Subject: Is anybody using .cirrus.yml?
Message-ID: <20261102204151.MA00I%taahol@utu.fi>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: ex19-03.utu.fi (130.232.247.43) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gLCRoNBgkbKA8FCQEERgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIW0hYSFhIWEhZX0gLCRoNBgkbKA8FCQEERgsHBUhYSFlQSA0FCRscDSgOGg0NChsMRgcaD0hYSFlRSA8BHCgeDw0a
 RgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 bh=kNSVJmheWcjwxizdLQ58eP8AoIZ41az4wqbBsDKCTtE=;
 b=PlSXhGXiKVnIT3b4nsldLhBUwKLvlsD36fR+EyYtLpVrlrIgQDYPKlnMmOk1580DheO4XFtlSR3g
	/kaoVzMLg+2rqnNjM5FtLYnSmkgj/S+YdGVw4ADmIXlLMsD61g2haXnCGQrf/NORubIYwUSGbkWv
	Qo8IQ0g44bcvauI84SwZLI1KfSa5G7DngcLEPOSrMzLwyWN6gjYU0x9Aj/Wv9W7Dloi9D3qQKy85
	6chx6xpl0KP8uTL9tPIO0m/WbH2USwRBCcNMyKI7aT9hKBbO4yNAdugLGIn9TQOuMXjh3GQ1pgZV
	S6MBS1EgM5eBRgbCRr2LZ4L9X+ykDYWGmQ4gUA==

It seems that Cirrus-CI has sort of passed away[1], but are there some other
tools and services available that could ingest our .cirrus.yml?  Or is that
file just gathering dust?

Links:
  1. https://cirruslabs.org/

--Tuomas
