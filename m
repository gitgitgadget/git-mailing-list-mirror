Received: from ci74p00im-qukt09090101.me.com (ci74p00im-qukt09090101.me.com [17.57.156.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CD126BE3
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396965; cv=none; b=rQtg9lOGewZkjAJ4eyXjWlZDyhgpknSupw75pWrzcm38Pr6gcwMRaGIbCjZA3l+Q+Zqyip1McxOSaR73lh9+t2OaEcJ8WLLG7NrFT2gXAMkSF8zcavnKJmcdZm9srePO5n9xAHwhrc9QO+GowEV8Sw7/JsFpgwgBtn8E5CnoZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396965; c=relaxed/simple;
	bh=eyQlnu0J1TaDdyyeCgkE2eVsVHx54yZ+yP4LydXLZgI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=YyKFbZEoKI8xYhkzy1KaTNh4xv8R4TOfzDo4hR7sfFR00rGKfiBANCaUiU5GrYbiwm+rJel88d9bB/TgMSQpLEH1oSHXy8JTktsOOJBcbOSKqlbB0s68ClRQzliWNcVE8Z/SYjHuymVCSOfBidS4txBLjkja3RbWxnmB+N9shUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yL4RrMmO; arc=none smtp.client-ip=17.57.156.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yL4RrMmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725396963;
	bh=XLzocVeNV74J074ytrXIyWQtTR8yL4grwvJHFl59deI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=yL4RrMmOlBRpAqBaXwELrih4ZG8DUhLZoOn0yaqXxtwvPnKikFi1olGaE3XaQCG3o
	 526mgMGgI7jDsJU+OT0NXe7mTHVSf+UCfN+MCk8OgsFXzh3OZb3Z27WTRvuBNmJtEJ
	 rz9WNlJqBWQSI7sS09PBo+J8cvmJXUsLSvpprWXgTbzBCiYFzj1cxx3JUHbVF8zNm6
	 mhcWjYzULcURF7BvbZEw997mb5Sst0Sebccgyd3Vdx1vm6QsbBVECWjajzrdwEYcRc
	 5GIri82RLm0PmA0wbHeV/x7VJZiHVIAfHe16yEp+Da7ckWymoEMctXxm4fMhKzhiuM
	 1qmSpey6RRJyA==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090101.me.com (Postfix) with ESMTPSA id 2207F35C00F4;
	Tue,  3 Sep 2024 20:56:02 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Cathy Litton <littoncathy36@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 3 Sep 2024 13:55:36 -0700
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Message-Id: <51715E12-52FA-4895-BF20-E1C34015D037@icloud.com>
Cc: git@vger.kernel.org
To: ae@op5.se
X-Mailer: iPhone Mail (21A360)
X-Proofpoint-GUID: d2W46uwRYcZ-dh98ZTnIV8c-WTxSUNEz
X-Proofpoint-ORIG-GUID: d2W46uwRYcZ-dh98ZTnIV8c-WTxSUNEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_08,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1011 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=537
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409030168

Can I get 
Sent from my iPhone
