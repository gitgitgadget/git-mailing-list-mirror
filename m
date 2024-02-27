Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244037145;
	Tue, 27 Feb 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016746; cv=none; b=pSBRBlpgtN8oRjZQPj99BkJHlbxxQB9fZ/xFoxdKsTuTLhJ6breIO4fRFu34+r9atq4mwp1QlPYievY04If6j8skZNCmf5VCJL2NY3o5bv9FZ0b6Rk2aMG/P+7Ax/ueY9xuuT9rGCrvfX1p7atotMgPSJXpkMyIVCO0gBowuj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016746; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Date:MIME-Version:Subject:Message-ID:Content-type; b=P7naSDFe6uge/aI0R0RLzI7ZyaVBJvGeDSl4vn06vzN9poHUCviI1L3ZAUTngezcK3kq5PlX/777KrVK+uLnECVSxsoNwvWy+1nul7pqGPWbgetHPri94ZIK+rZV0NsbH+3I+ThLKXNcqTIGLl0vREOjHPbUceOaV20N4aHJC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net; spf=pass smtp.mailfrom=sonic.net; dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b=nrWVfgTd; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sonic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b="nrWVfgTd"
Received: from [192.168.1.94] (45-23-117-7.lightspeed.livnmi.sbcglobal.net [45.23.117.7])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 41R6qJT2030968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Feb 2024 22:52:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonic.net; s=net23;
	t=1709016744; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Date:MIME-Version:Subject:Message-ID:From:Subject;
	b=nrWVfgTd4XU80z03W0r+K/FWhA/OzEUePMzte5vAbDVSWJa+7M9L94aky84u1ESZu
	 F2Cbn9vNaICMFWtzz1mjB4Sw30U8CGXm8zzmcgFVYLDXNKAeu/5VyJKyMBOcDVRBX6
	 JZSkqvwLuq8Jtcfh6M47eyzXlR5bQBcWmCvVjzeOzCFrcBdmv768H+6c5fTdW9rDbO
	 iaEkFwjnCFyulg3P3zshm3LEdWNS5zAkqnxDHVoPBRud5NnoQ379lZHOvAcXALYzDv
	 8PDD8ZKRyBrWK4/cyMHdIfTq88T2/lZjLpLqqPyQNUxteUnK9DUeFqw7tZmEjwfdp4
	 dmmqmqj/OC/Yg==
From: delyan@sonic.net
To: fstests+unsubscribe@vger.kernel.org, fstests@vger.kernel.org,
        git+subscribe@vger.kernel.org, git+unsubscribe@vger.kernel.org,
        git@vger.kernel.org, git-commits-head+subscribe@vger.kernel.org,
        git-commits-head+unsubscribe@vger.kernel.org,
        git-commits-head@vger.kernel.org, initramfs+subscribe@vger.kernel.org,
        initramfs+unsubscribe@vger.kernel.org, initramfs@vger.kernel.org,
        io-uring+subscribe@vger.kernel.org,
        io-uring+unsubscribe@vger.kernel.org, io-uring@vger.kernel.org,
        kernel-janitors+subscribe@vger.kernel.org,
        kernel-janitors+unsubscribe@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date: Tue, 27 Feb 2024 01:52:18 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: subscribe
Message-ID: <65DD86A2.26711.445FA9FD@delyan.sonic.net>
Priority: normal
X-mailer: Pegasus Mail for Windows (4.80.1028)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Sonic-CAuth: UmFuZG9tSVbJ79Tzo2m/TgVHl44QfDudJQokRJ2kt57p+g/4CyJ0HD4E8JxfQhjRBK7t2tN0wAzEFhR4NTWUe+vhumVoO6iw
X-Sonic-ID: C;Cr9LwDzV7hGbeC5nR+6Zsg== M;crQowjzV7hGbeC5nR+6Zsg==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

subscribe
