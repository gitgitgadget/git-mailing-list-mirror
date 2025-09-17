Received: from cmsr-t-4.hinet.net (cmsr-t-4.hinet.net [203.69.209.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73AE2248B0
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107008; cv=none; b=BNVx3m57v2YV16fm8e6Xq1YGBdBfCGR8Eou//xvXtY5DV6Emp5xtezs8H8c1hankkI/ats0PwAInqMkKb6XDNX9SYoZDJr+NNXSznNS11PypJv503/M76W1oWC2cLXtDwYkJLiw/nO8kmQ1bU21mezXIhzAJ4Gcn7T8BSivtir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107008; c=relaxed/simple;
	bh=HBRjaJXke4APE0BRa5BDlZ2/yyjz3GLzkbMYKxMaMKc=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=rFDuGmQD/ZxLI9fWl0cFY2JOtcyyBLnKEnfoSwYS5x6FAAIvLYINV0qdoPkke67RiGzLyd+rkXbAIdz/Z7AlKlLFIan+9oeiBQYTQV4hBIQtYyy4laWMoComIhPrts+OjpCtCnpYsPOpUyKysn6dGN2neFPBW3q7UHbuUPG4n94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=FzT5PRga; arc=none smtp.client-ip=203.69.209.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="FzT5PRga"
Received: from cmsr3.hinet.net ([10.199.216.82])
	by cmsr-t-4.hinet.net (8.15.2/8.15.2) with ESMTPS id 58H9viHp375514
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 17:57:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1758103064; bh=HBRjaJXke4APE0BRa5BDlZ2/yyjz3GLzkbMYKxMaMKc=;
	h=From:To:Subject:Date;
	b=FzT5PRgag9VrjdlSvYUd8QrmuHr6EdrqzehNctCkRTV+KgNV9U1GekO4Wyt+yfADU
	 CUvnOwJrDq/oZ7s1n1rgj0TWBPg34PYzd5kX5IIRddTg1MHm41FdGTx53F/UCxbQys
	 guA3MsA7GSjCZoqp5/9+p5Eh0O++4XOWItRh5MXi70b7mJcKFUkxsI56RqJ7Mhf10N
	 8BiO9HxJZFyEI5Q1eUAkBvVdQQfBdIZpAhuGuITUbivudpp6nN5GCxRG1FTf0Oio5Y
	 j5Xjxp0atsnCfsGn66uvOFvpO6Q4V5PrtCd6aroB7pIyWnFJ9iwia6c5beMLF/MtLr
	 HFUFnPIMkogaA==
Received: from [127.0.0.1] (114-47-79-5.dynamic-ip.hinet.net [114.47.79.5])
	by cmsr3.hinet.net (8.15.2/8.15.2) with ESMTPS id 58H9tTAx343206
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 17:57:43 +0800
From: "Info - PathnSitu 935" <Git@ms29.hinet.net>
To: git@vger.kernel.org
Reply-To: "Info - PathnSitu ." <info@pathnsithu.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMTUzNzIgV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTcsIDIwMjUgYXQgMTE6NTc6NDEgQU0=?=
Message-ID: <259c8ebf-8f33-803d-efbe-0af243d31b75@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Sep 2025 09:57:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=I/PGR8gg c=1 sm=1 tr=0 ts=68ca8618
	a=fHieX8g/ZNrwFa/Gk3wStg==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=Vsjs0GzW9LUQJwS5HMAA:9 a=QEXdDO2ut3YA:10

Hi Git,

Greetings!

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

PathnSitu Trading
