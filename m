Received: from outbound.qs.icloud.com (p-east3-cluster7-host11-snip4-1.eps.apple.com [57.103.84.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566A20C038
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270927; cv=none; b=ixnYQpdpttjZudyzX/zgOoatz0SVhiX+RvO++1Mt8fqsekzN8HnCbQzR5rMJHzkezO2BlFpiCoJx1DG4gveoLjsYnOLROHSWgpCi8zgewJxP7Y/dXXsxz37RVdmE8pSToKiLf0YtjDe1zKR8rU5fmgMlm0m+g1tZ76QTEPWGJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270927; c=relaxed/simple;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=m3JTzsFV+J59axghDchkRfwgUTrD6zf3HpAnQETnIRjCmlPrFc5AP3g7E6GTcwJ3GIrglkJxInX9N8he3wx1/4ZJlUxbrBt78yq5ZZQkEp5c9xn5PUoRZT8ZGNaQPQQrLCGIzNXwkSNtIOlomGA9YO14JdQ2QpZJLYxHrXrLoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ZqyzI13x; arc=none smtp.client-ip=57.103.84.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ZqyzI13x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=ZqyzI13xw0kmB4Iodav6GfxMqOjA6oo3Qv5ERMMlvU01ZV9e/lPMg0zzGpMu1GaIt
	 gcooPuIITF8o2UW9WpjqbMA8zW4r3y0WmL4n5CtljxZyE6jziMzlN2c2Cz2c9GCrpN
	 8Vv+0132la0BsCVjs+OnEd/qP2gprjoX/KCtTQV6Y6rCoRiwYpaRdsZZJWVB/yfbn3
	 w9FNjsJAuY+LcXWJyWGF9xm4H+78rAw/j2SGVp0eojxc/3H0J15WuvJmCigrf9MBuI
	 4VBjzvNudcYhVjbv1aruCkrBCpyAEKtiTmza6QPAT/YBFCGRXIjBTcb1XEvO210Jd6
	 DL9bik/Pf53qA==
Received: from outbound.qs.icloud.com (localhost [127.0.0.1])
	by outbound.qs.icloud.com (Postfix) with ESMTPS id 8DEBF180012D
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:48:44 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by outbound.qs.icloud.com (Postfix) with ESMTPSA id 1A54418029B1
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:44:00 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Tengo kalandia <kalandiat@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 26 May 2025 18:43:48 +0400
Subject: the 
Message-Id: <7374F252-3540-40AF-9DF7-9B308A7626A1@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20H360)
X-Proofpoint-GUID: JE7_eES3DiO8DFGjy8Hcjch3LLtCr_cR
X-Proofpoint-ORIG-GUID: JE7_eES3DiO8DFGjy8Hcjch3LLtCr_cR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=575 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2503310001 definitions=main-2505260126



Sent from my iPhone
