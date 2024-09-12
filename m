Received: from ci74p00im-qukt09090302.me.com (ci74p00im-qukt09090302.me.com [17.57.156.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54527282FB
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105694; cv=none; b=doLoucy5ug/XRSttqLjCrpOP3gIoeZPlVRCRruxhcH2P6LUaFMLRiQA6gz5TLuT9oRX/mi5/A1bKN3ltZqSHniry0fpw3y0tZxRlf0NxpVQ+JC+b2ILVZCAb/+q/jwLWNw5vmfSnSukYK17GK5FMv/ThvKC8k7RHHiyCyIu9to4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105694; c=relaxed/simple;
	bh=t3cZRBaahzq/c5AeKLWz6ffUX1tWffM4jNT1A4FlxbI=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:To; b=EsKLDrJYrNLcclFmNEAEeaET3y1ZE7upQObtTyTbaOthV618L9jjJQEPEyd6JdSO5NL7SicwWoMfff4Q3dOdQg3Qkx35FVsg04zfcRXIbZ52++eVAeAS+1YnV4QUj2VeiaRKDI1LMvibxtloRqVvxqPrV/Mfg84a2c25Nohnx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=krfjpNbA; arc=none smtp.client-ip=17.57.156.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="krfjpNbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726105692;
	bh=t3cZRBaahzq/c5AeKLWz6ffUX1tWffM4jNT1A4FlxbI=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:To;
	b=krfjpNbAxEyVBXLfRLnmeD9w5CVnAbBJ2SLsCxknZPGsrPBkZnvvsP+5yQzchkNty
	 aC7UG7eU6rzl+Enq1GWWRL6hNFZcKtGkPiG0o7zeeiBaGaj4nJLQ58KIkQTFpX9pju
	 ZZzk1kjqM1E89Ot2F4DIMqz27CTX0sKVbaBDIiJ4Gy7zv3xSFrIoYjygqJvTlJF60F
	 iLEHXZQF4MTbi5ViNt2zgkV+pWVAGVSTwGwbKSKJUrpZ5wnSp0iHCaU+RKdSuD9Obv
	 096dpOnowrO7aiFd2ZxuP77zpwOYTD3ce+71bFlt4lMIA+HJPR8uAJBTPQl8Wl7qRg
	 b6J5FMiN/tw7A==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090302.me.com (Postfix) with ESMTPSA id F00695BC031E
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 01:48:10 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: russki1990161@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 12 Sep 2024 04:47:56 +0300
Message-Id: <9287C3B7-B934-45BD-A257-D4825B8FD129@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21G93)
X-Proofpoint-GUID: 2k1hvN8KDjrFiDPREVe-RhfvcRMz3f9d
X-Proofpoint-ORIG-GUID: 2k1hvN8KDjrFiDPREVe-RhfvcRMz3f9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=449 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409120013

DQrQntGC0L/RgNCw0LLQu9C10L3QviDRgSBpUGhvbmVz
