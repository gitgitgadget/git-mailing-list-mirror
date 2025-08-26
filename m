Received: from mail.5y5.one (mail.5y5.one [65.21.63.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECB2BE7B6
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.63.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212167; cv=none; b=UOv5f/QFozvgWbslJ8iUN1aAq2lRlNCccIPHp04Ab+Q4eMcQIpsznZ8or1E6JXDc/IRXg052WME/L/P1ljiY/mSIPM1yPwz4R714I/UBkXZ3MnAay+DhFNyLwzFPaLAqcLqmIwCoVfziVnry/aONopyvUfXnxjAlhsMPNQuY3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212167; c=relaxed/simple;
	bh=NjwLYQ9CmfUlrcnfvG4tuy+AhNqHBYtAMOhHI7NENNQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cyJhH3lciaoeHDIdfFw3fI/NT3rOw/Hlu8038QUcnWIalj1zaS2Mwc2h+n7DazOp2sDwqUZik2QZ2VxasfqMoPLCbsBh6kcIz4bQ8x9m8yIYTGafLA9v2d41CgB4VsLgkdUoZafvKcI6hvhjWshnVWF4WyxqeeimyliFHSWB1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=5y5.one; spf=pass smtp.mailfrom=5y5.one; dkim=pass (2048-bit key) header.d=5y5.one header.i=@5y5.one header.b=E/J52Yis; arc=none smtp.client-ip=65.21.63.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=5y5.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5y5.one
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5y5.one header.i=@5y5.one header.b="E/J52Yis"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D848BBD900
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 14:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5y5.one; s=dkim;
	t=1756212163; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=9/Sa1CNKzUUeq3lr0L0juzWovLTONWM0kYYbZhaykaI=;
	b=E/J52Yisn2GFvXBLVsThWeeTDrwyP7ReGpncKFUqbDTzR0e92qI+J4lRy16TAL/DDJzMW/
	GnRIFiMvWukKAq7stZBsMrqeZcvgxW93/AJncHHJQkMHCOcHaHVTz6rwoQJ5cpcyvPFF/H
	kn8OkF1UktaN1Xqujiq2poMz7/Rl3qU+EoO6I1aYkLqaH1ClTUtKJ/53mMgMEdyN9cX8Qz
	VIyiRMMKY/tVaSAk3ZHQnr1+12Dv3Mt6RUElCHehN4FkoUwTCV4+LJ7NXwjJxi7IEa/9YY
	sz6sjwK3z39S9A0mk9JVn+Gxz8FbNCWOgI+dv7vl960uCn06dcLEw4/KctW75Q==
Message-ID: <e1a69dea-bcb6-45fc-83d3-9e50d32c410b@5y5.one>
Date: Tue, 26 Aug 2025 14:42:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Mira Skwar <mira@5y5.one>
Subject: I still use git whatchanged
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

I just wanted to let you know that I still actively use the |git 
whatchanged| command, so I’d appreciate if it remains available.

Thank you for maintaining Git!

Best regards,

Mira Skwar


