Received: from outbound.pv.icloud.com (pv-2002f-snip4-11.eps.apple.com [57.103.64.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A65A499F3D
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797155; cv=none; b=oGsu0UW+CqwwQjdO4sS92RsqbTjjdNS6wOrJAd18t7vBo7LFkXUcqINMurNz0pwu7LAq8wm5Fj/e/+3ddSmrI4/32kM+ygcnOPAxNjlfAZnEk8WLWQf9oihJNfOYHMNwjPOPEdKHjY8pany63LYTcWzIejLDJDPLVewVkqGNEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797155; c=relaxed/simple;
	bh=NC2pn0l9RB7WOMtmh4tt3OapAQJOxzZX81rIrbLaRU4=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=FVuPfX0gdkulYuNiWgN6y2mbmX9kDjA3fGS1lwLKbgJlLd1I0YEVUL8XrsouDU6SZqF0fz0DJlxcEvQc2sjT23A3XAIq/92ffY90V/5GubxAFVN80T72W5OxKnEVViU3idxfjjv8vepEwIfjEebxCDUJjkhZZteqz3gvzqQKbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=OrGfvoJP; arc=none smtp.client-ip=57.103.64.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OrGfvoJP"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id 3ACCA18005D0;
	Mon, 07 Sep 2026 16:05:51 +0000 (UTC)
X-ICL-RepId: 01a07c9e-67ab-7c01-b0b6-3758290bc6b8
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAB0MGXQJeCEwDQwBLVxQEFVwDGQJWFVcMWhlSK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUBTV8OXh8EF0YZVQRHHl1WQxsZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FDy4PLQcxfDsBQHFfd0MUTHVYAUYLNApPHihzW3dJfE9wWHVTAjBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1788797152; x=1791389152; bh=NC2pn0l9RB7WOMtmh4tt3OapAQJOxzZX81rIrbLaRU4=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=OrGfvoJPEdg0UGu8X2QEi+b2ZPjd5CJASzmCSt2n7wl488L5yRgOZzx/VzbJwsY6HvdzUF6He3ArfY4wkMZ53UVeAGOjTke6PDjAf3ePW82+YpUg0bwf8s7R8uBzFlJczL2E1NLiWuNPIL9ulVgzKFd09wBEFzAkTQ2IKwxaxtv45CJINKMQKI/ytKPnsw5YH/HFgA9Salo5InbRCVbcCWMzaivAlfaWpo1HjXkzjiwXiUO5h4peJKgzhn3kpzR+lFQwPSUIRYDPXqiu9JXn5/9YljpIdHkJcocx54tP3V+Qg0l6+DOn/iJKoEofcx8h4kmdmkpli5iuGPzJKs6k5A==
Received: from smtpclient.apple (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id AF8FF18005FF;
	Mon, 07 Sep 2026 16:05:50 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: mon.identite@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 7 Sep 2026 12:05:18 -0400
Subject: Je vais pas 
Message-Id: <C8F5AEC2-F4E3-4F56-9D37-ED0E9E7C5B80@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (24A5390f)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE3OSBTYWx0ZWRfXyLb98UtgrHAH
 X/IBhIRX8dLiMryjVo+LVRz8Nn/9R7LIcBCsB6fBQiWJ7JZmRHE9VEDFVejRogftHyNpXPENOWe
 dmXgWR4il3AgPPsNfTLd9FqJ+VIIaxewDW6mEnujE8/g9GfXLPTToHcEzAp/1htXiyijk8eqRwc
 DktlrNe82YZN6pbTrlI3xJlmn76e+O6wIZSBtpsSWLe9aOeuYAYqqpme7GhCClvDA23HvrjqdYk
 Y8/Ao42FTnGkptNs1y59EpQaUAuWalVG0AbuyY6JYtdxIHELAlulPty68DAJSSQ0eJs1ad1JyN9
 dC7+9D6zixAa53VY3oKJit1iWogIxDcW6eIB9pE6lKm+FuwQZT2IIEMyjzq2Gs=
X-Proofpoint-ORIG-GUID: 3bM8PFk6nE1tnOXjl4AXd5nCkwJ5dHXz
X-Authority-Info-Out: v=2.4 cv=WvEm8Nfv c=1 sm=1 tr=0 ts=6a9ee0df
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=x7bEGLp0ZPQA:10 a=cHTQyyNem8IA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yByyWrLn35C_8_xOOowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3bM8PFk6nE1tnOXjl4AXd5nCkwJ5dHXz
X-JNJ: AAAAAAABPBhjX9nNOSEUnX9TktybeOUbdXDNLzHAOzfg8GKVDCdGp3yO70G676aVBv8F2ZVxgMNl5Owh7KmTakhMlf/iQsVVALfD5Exz0zUepG/XxeZOPJeS/Qj/cR0t+2sRCyNIqRFxZTqAQOrGPytGIDQNGqOi4ggPozuykhg7+7EufCakh1YUUm9zVJ1Eyjxmcn1m28Hjg+1ua2nOp+NUOMuW9KwwL5NNZgCIId6GeJP5pF+ICvHwp2OWNoozncGMYS+85+fl+rBy79INZW6MQgu5BkYWMQvjaWNTpP5LyXcLyziTItKLjZgSvpUEkyIGKtSaj22evvhi/+lkdrvhaDH0W76jh2lcgyjkGy4kj/bqdWpgykI7g8oiW47wOUKHTtSx0+VessOHTYZmxdioFdABtlJ8JHEGpJDdEFbG6kkJJUlIICHeXAvi3iqYQKWr3ocbYZ4YDapjlppsdycOLuctsmgZbno+YZIZAlTqzz3g9eL/cTWhnShUd2SIS6o8MwHuHfU1rUZjXXMR1wr9xi1Mxl7Q6Kic1gCinwQivqsZNHQQSRTNvTTntJhJzNcAega0xAu2wAHjplMZzIlB8X6I+HNB6HG5/sy6UnMiIJoF3NUzKknBcfbyyoVMYi4WrCOcE1s524IBb6+zKyWZ0pa9SCltqw6MyuxHTsUBFBPW6urr9wO2dOVmU83JjXA8V9r7w/x5Rudn6WfR1wZxKp651gk3x1b8OW7rAtRyARJZmO3pd+oVbzxOhg/K8ET9fSuz2fR9rzL8M1dufWZBhnz6WUJQFw6IdhAZktwhzUDrrb0V3391sI7F8/Op8Jj432siw3oQMDn63SAy6lM7dkumfZOgf/51t4KvSSGKdezoZcnJk8KZLHhJumM/FKgVAUQSLn3QUOXijIAiiqmDVsG2Jr1Vu8Xc5bsQUQszanQhcabY6zp4bzZPTjdJzisXCBlmKusAq97//eFrLCSrXcQ0dqc
 /xcx9KXamqlPsvzURc2flhY+sljVQXrrQh//WaB4qKkpWj2yLcF5UIS6E6YsW26+DJf/CXmRp9WD4HHuGC75BH8yXcxB4TknY3vU4ZORyq3nghh5pGwT59ThVKZEkV987xpw87p3uT/pCs4EXhgStQIcYIya8cb4gsF8T6qCj/glXSDgcF2myEQZvPFZUeo2WK11LkrtX9PNo8j1UD0WaY5JFh4no4p7kfuYscMz6KYnLGUA/moYrM6Cmvx856AoqXjvm
X-Apple-Category-Label: MTc2MjE0MDYxOTk6JGNhdGVnb3J5JF9QZXJzb25hbCw=


Envoy=C3=A9 de mon iPhone=
