Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B16205AA1
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519778; cv=none; b=sShVMsow1JwaAoLLpsMsNLEN1KgXnoxuWQxsD7CD4bX7sJT2liNDsME3cb99LRznMpn0ZQajuRJLMHxoZelmTTSaYMH4uMJrOMmZBmrJNut24e+6C5ssvvRTeIOj9g55diuhrVUEzCJZSaQRG3YesLAlGu69XGMVRqb5URTdAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519778; c=relaxed/simple;
	bh=KWWzltR/fBdQxk7xWb0OUb2algcHSEqxcpJTrh9VT38=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JwBtTY7iD+MR9ta5sZEYcQ7N3+UIebjgEaFwjfCUnvqZ9Gvi+XcvPN7R+45a1aHJWNUeIrH/V3sQDfsDUufpYGsNZ8kTHW7C5zP497TpgG4ke78YuaLakljzDzwAcM4jduZsn6l5lVcuibi+StTPry0BlojH1Cjubzty0E0JweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 576Ma7k13177116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 6 Aug 2025 22:36:08 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: Re: Git 2.51.0-rc0
Date: Wed, 6 Aug 2025 18:36:02 -0400
Organization: Nexbridge Inc.
Message-ID: <03b001dc0722$80b0dfb0$82129f10$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdwHIkFSbCD6uFzkRlysPhfNsZwg3w==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250806-12, 8/6/2025), Outbound message
X-Antivirus-Status: Clean

Git 2.51.0-rc0 looks good for NonStop built/test cycle with OpenSSL 3.0
through 3.5.

Regards and thanks,
Randall
--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.

