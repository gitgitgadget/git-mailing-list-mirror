Received: from ci74p00im-qukt09090302.me.com (ci74p00im-qukt09090302.me.com [17.57.156.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9F6AA1
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727592701; cv=none; b=PTOzQt/V67GPlrkux+0BSMOsGQi5UK/eEOiQNzcP8WvMyi+8vOYF2inuo6eHy5lbvZ2Cc5CDuCHkv5AWHv/9XoQNowpLtPM16byUVMKNcS3tSSjniitIAwHlOpF/pOutF4LNS2UXOjpbLUefj7wZFdk0kvcmNDp2d1o01Xxpn/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727592701; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=qMMzYKme0WPJuvXUz+IXyaeIdf63/hkxB/MkcfcS2badDJmmUUaRbdXJYn9MONdSI9dTczSWX8t0uTDTKwMse3ZC03LBaonuwwI9Vt8slDEF3AWuj4unDLSjd/RlSaz4gyrTx9SCv1BVWQYRNQmJy9+1lleI/eUQ/tjkoYRZPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=imbZBuUc; arc=none smtp.client-ip=17.57.156.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="imbZBuUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727592698;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=imbZBuUcSRt5DqSNjlnrKhUsn0S72YrfnNIj6D5QA95IHVIvE7OpSLpyuQG9J1MGL
	 0pG/JtVuub3vMulmzRUHZiPeVSSLdm4cOp3IIuTrXD3pRD7qiY61fP8AEpyDHzRwsQ
	 95zbAXWIwUpH7roWKjJP7sIahBgLT8mk7WRaVSZSaP2j+GyAlUek9TNu2KAvvpvuM1
	 IU/kIlJZNt9823b5a5wIKjPpJYPXgTHyOiY9Zr1nSnprRwl+ezBcg1xs7MMNUHk/KQ
	 Sge3tauZBhZojZxnvbK7RIy3W31YlLsS4lgewlrzeGfORCqZ9EG3PmLKSvIwFoZEvl
	 MRpP8ndGkwF4A==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090302.me.com (Postfix) with ESMTPSA id D73A65BC00C5;
	Sun, 29 Sep 2024 06:51:37 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 29 Sep 2024 02:51:26 -0400
Subject: Re: [PATCH] send-email: document --mailmap and associated configuration
Message-Id: <DD7D52B1-E86D-4762-9176-ECC795DAF47D@icloud.com>
Cc: git@vger.kernel.org, jacob.e.keller@intel.com, jacob.keller@gmail.com
To: gitster@pobox.com
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-ORIG-GUID: KmLyM5TZAsqB59Wra5jK6ew8z_eaB9B_
X-Proofpoint-GUID: KmLyM5TZAsqB59Wra5jK6ew8z_eaB9B_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=720 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409290050


Sent from my iPhone
