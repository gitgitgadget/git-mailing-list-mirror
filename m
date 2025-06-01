Received: from outbound.ci.icloud.com (p-east1-cluster7-host1-snip4-5.eps.apple.com [57.103.88.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A717583
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748805052; cv=none; b=ZOXvlB0dL9rNsdbpQ2ezXy/F21u7V35h6DC5PjrEc/BZM5O2MLak+MPobpy5Of2bB/ln0ClfgcZ94xE6tbEnrsjvjtWMRJ4nncaF4l9luW4Ndw+AsTGMJPGRzY3xZUSm8WILXfTheF8dSebaX1QSM42TRStyw8E2kH7usFT0ztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748805052; c=relaxed/simple;
	bh=AnM97FIUcspiyEc29loffiXUyANeM3zt/SXFH8Hgczw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=CrkaneaJO8EAtlzlqCN0UjAWIjy/9/Xc1toVuNP+27mManq4neB/RzMm2r9ioaJqq09wSOtt9yK02OVakJAGHExWsNDNtD8nIzQI3g3vobDY4Sbcaw5dlESAOvxTiH45MytMVn5Iu62fIbz/F/p7XZBohS8P53ryqNdKaJPB3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bUHAupj1; arc=none smtp.client-ip=57.103.88.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bUHAupj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=AnM97FIUcspiyEc29loffiXUyANeM3zt/SXFH8Hgczw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=bUHAupj1hODvopCdeUrpk780oa/RclQ2/oKhgELsl0ugxUXPyXeJS53YSWRMTFomg
	 G1Hk5tpcYBlefKD6i+KktDBHyLNawuThqX+QL0/AiUFo+5SFDRQEab4L/gFfzoF6c+
	 EXxzIeywE4vCK4XSGYAt3kj9yUxTk73tZJ15TXlb0MGaRbEUcZfAt6ZvQd4ldMecnO
	 e0JVewx9gPCGRSRqVGuW4/TTwUUicqGYGeJ2+NjGzZlts1QGpZKc2eeXKSaQnHhJTC
	 lMbHbICe6JRmPNS07lGDtfoBmnbzpiNK61FSdP/2jvimpTy109M1gDgHgBE0EiAHiw
	 C+KSQnTechjeA==
Received: from outbound.ci.icloud.com (localhost [127.0.0.1])
	by outbound.ci.icloud.com (Postfix) with ESMTPS id 1B33918000AB;
	Sun,  1 Jun 2025 19:10:47 +0000 (UTC)
Received: from smtpclient.apple (unknown [17.57.156.36])
	by outbound.ci.icloud.com (Postfix) with ESMTPSA id 3382118001E8;
	Sun,  1 Jun 2025 19:10:47 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: "Shawn A. Hollva" <hollvashawn@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 1 Jun 2025 14:10:45 -0500
Subject: Problems 
Message-Id: <11896F33-E812-4013-B3A5-DB4BD3827D24@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22F76)
X-Proofpoint-ORIG-GUID: i2OwkAc9Z5uGW0_ABIt4u5yvvT4loq4e
X-Proofpoint-GUID: i2OwkAc9Z5uGW0_ABIt4u5yvvT4loq4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-01_08,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=688
 clxscore=1011 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2506010167
X-Apple-Category-Label: MjA5OTAxNTMzNDU6JGNhdGVnb3J5JF9QZXJzb25hbCw=


Sent from my iPhone 16 Max Pro Plus

