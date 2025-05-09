Received: from outbound.qs.icloud.com (p-east3-cluster4-host3-snip4-7.eps.apple.com [57.103.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F844B1E6B
	for <git@vger.kernel.org>; Fri,  9 May 2025 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746749809; cv=none; b=V27+c/m1kvGu8T+JXYpuSM1sa5e3dAHU/J24hMKp7B/pl+bEXu7UmBNtWnGZR2kvt51D7EHqNIMQTbP0Yhkx+sbGmF+sGyTzuUjQKmBN7itab/kw78YFPlCSY1aeBw0c1yJEIyHkT2qjvoaWfYbHJhxyr5C2vRLdMxFLpKI7gyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746749809; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=euPJiPtBl5LfmvQC+HQLxM0d9itfYE9+U8hRR/+3czZ/O0murygaGh4WdCOnrRBk4A+FQscCNbq6cq7XH/w6/KRXnFa74vocA4TuyfWRBFN4Dm6NM0ABDBx2XwSfQ1jB4GxmPRkUBWO0GjfWZS/Vauek9AMcuhIN71x3dqwr1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ni3juwvb; arc=none smtp.client-ip=57.103.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ni3juwvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=ni3juwvbMTiLC++NmGUqXfNP+L93lGN2g/36p+VYjMh4KS4TjDuHnScxOMgiJ5/yX
	 FwAo1t8xf+7fz3Y6ugWQ+qtw28wWI0ST1Izm73/X6fri9/uik/CSc0lvUAkSVAmtYu
	 SidksLX7weSKKXBrvj9vpwE1ZBE+ZD3AxKHEqUw9s/Xmx+Jhy1a9LUsR1eKTOFs58V
	 kjqFQZu4IZ7KitGe2FyLkyEl7fA9yWYFB5pPcQXvl6JU1vdIjgn71/pJFj1nIkiNzs
	 F68QxBMDC3zT7+zW7sxzx4yIRc60ooQ7h9Yp3sDI3oQMr/AhK5Wf6Jw1LQSup42bTC
	 w5L1kIo2p3hHQ==
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by outbound.qs.icloud.com (Postfix) with ESMTPSA id 98E2E1800277;
	Fri,  9 May 2025 00:16:45 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: mohammadhadi Jabari <jmohammadhadi@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 9 May 2025 03:46:32 +0330
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Message-Id: <CC67DD40-604C-478D-9F1E-87157525EFFA@icloud.com>
Cc: git@vger.kernel.org, junkio@cox.net, rael@zopyra.com
To: torvalds@linux-foundation.org
X-Mailer: iPhone Mail (22F75)
X-Proofpoint-ORIG-GUID: 3oxNZfdfqaMXVYmbBk5w06CuuKX21Ji1
X-Proofpoint-GUID: 3oxNZfdfqaMXVYmbBk5w06CuuKX21Ji1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_08,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 mlxlogscore=451 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2505090001


Sent from my iPhone
