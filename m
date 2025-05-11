Received: from outbound.qs.icloud.com (p-east3-cluster2-host4-snip4-2.eps.apple.com [57.103.87.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7721917CD
	for <git@vger.kernel.org>; Sun, 11 May 2025 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747003972; cv=none; b=Dyo3rHNAbEtrDYUJO/xzdSETYosUFcvsIZc7UE8Xuhp5XmrkYdJQOnHyv2CLON9eM3BTZTRLVGjvVEWkbNikRhxDxH5TYuBIQXAx81oTRuGx0eqEYDWcTgmf1RF6/JPCPUNyDS5r7wdsnrmvHRGp/m5ZtFyfpgDxH4wpbi9EIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747003972; c=relaxed/simple;
	bh=YuVPVzw1GH3Zf+NRSg77c8YJv5qj2/RUK3Ji4YvkcPs=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=V91x5uylAIr+8nzDnKYmGwFykokKrnEAqfc5C/BVt6triGu51GTByzmHVVGg5UOpMB/T0e4jr6ubUVLSqnU70EwsRIECzrkSSa14Y3ZYxVsOC2JANIq9m9Le+VAMYjta5eu7BIMMQZmivMHOl9MiVkEqAiNBvcb1XkUO4XrthAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yFwyakpB; arc=none smtp.client-ip=57.103.87.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yFwyakpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=YuVPVzw1GH3Zf+NRSg77c8YJv5qj2/RUK3Ji4YvkcPs=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=yFwyakpB/gwoQF4Sj6GKS4oQvHp9lkL8xWM/ozOszRbGlA2vR+ttqfZmMFmwYOz0d
	 ExsjeYf/yYFV9/BrEyvPkJIDPMX/X/X40PITiHMt5r/fp1B6ie1bm/7qMy7opBloRl
	 gG3YVJw6mtQ5yRuBe8f3sXiuia6AuAWc6bIhaO9EWa1LSyuEH7qwlUzwvdVvW+DJ4q
	 PI++hstJbhrNXt0N6q5xTQtZeWxVx1E9sw1BHI/gZk/ZXPN6Z3SpqCcwTpiODp9iey
	 neGFNdZd5sSHKmTpOs//NRXRRSEA2vt/1qbLy/7Ijo2388wKBWYwBR1OxPAcGD0ITZ
	 F2DO/naRGRMBg==
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by outbound.qs.icloud.com (Postfix) with ESMTPSA id CE619180018E;
	Sun, 11 May 2025 22:52:46 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: jan.jah@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 12 May 2025 01:52:43 +0300
Subject: G
Message-Id: <1FD51383-6DF7-4DBB-AD87-DDA54E71AA07@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22E252)
X-Proofpoint-ORIG-GUID: I6UhYnmeeY5jOz4n1r2DJj5-YpkMmrKU
X-Proofpoint-GUID: I6UhYnmeeY5jOz4n1r2DJj5-YpkMmrKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_09,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 phishscore=0 mlxlogscore=534 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505110244

DQrigKvYo9mP2LHYs9mE2Kog2YXZhiDYp9mE2YAg8J+UjA==
