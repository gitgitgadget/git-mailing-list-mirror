Received: from st43p00im-ztdg10063201.me.com (st43p00im-ztdg10063201.me.com [17.58.63.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D33168B7
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727837385; cv=none; b=pLZ3FDfKi+1UhqS5wQODJdR+lHYaUVKClzD3Vipe+BSrnb/ABzrF68yJtwHt/qJRxu1X49gPYbHSbUBwAFy02546XhEo/cPiKqsSTgJdBl1i1dJPKxO27+YYJYCQqp2j9C5pwD/W7uSPyyXj0IL+12wJGeUR+rJEubcWpXPbObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727837385; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=cdCU0IO+x4F0sCNAe3VkonlCqPCSi1f7mMK5lk2wfoSXjhXHW0/bfAGZ1LZXOz901O4Posf/eNnDoeoP4pZ3zjmhGAFVLNOLdTARah/SFW+MH1GNBTXsbbpOVkAHawXdkNSGTvpAGIskJCBhCJOtad5eQpVtixGF79aE7uanQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=J5FGuxyV; arc=none smtp.client-ip=17.58.63.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="J5FGuxyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727837382;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=J5FGuxyV8Qhe1Fp3JsvlhxY2sZS88zIl7aScLYtfqTXeW+P9k34vvCddWrVbT3jKD
	 rgP5pXx7fOvQkMQqrnkrtyVeITsCPtmR+DGdIYqVLwHKaJNAoU+lOlmuUx9+/DJeQy
	 lkbDhNJybEeV1ZVB6wi5iBUJZytxYZQlPJzbgkQLVbG02ynfOVAXY5tBvxu8zoKwmh
	 gwXv4JYPPylqEcKmsIJUPPvWNRtNgIuiSpaeKHukwuGtlSUilYUgTWXk6P23kKMp4M
	 XLmhkOPedHlZ/+8fez57dCGkO+8jz6yMcu4iCHsdCSR+aWHFhgWkhd0U1dsI9PyHhU
	 l7lLlv4hF51ow==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id 1A3F39802B4;
	Wed,  2 Oct 2024 02:49:40 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 1 Oct 2024 22:49:28 -0400
Subject: Re: [PATCH 20/23] object-name: fix leaking commit list items
Message-Id: <CE279193-6453-495A-A48A-54C7927CF540@icloud.com>
Cc: git@vger.kernel.org
To: ps@pks.im
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-ORIG-GUID: uY15XsllTJV-bDDF0qiNxDmL68N39wSF
X-Proofpoint-GUID: uY15XsllTJV-bDDF0qiNxDmL68N39wSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_02,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=752 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410020019


Sent from my iPhone
