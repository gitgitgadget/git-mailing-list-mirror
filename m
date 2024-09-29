Received: from ci74p00im-qukt09090502.me.com (ci74p00im-qukt09090502.me.com [17.57.156.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1617BD9
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727580868; cv=none; b=EQYf5++oApZwUwEdhSKi5gyI3egsUQhQBjJt/OqPEhsggY+XEKkUqxicnO4ice8PkpOCH4RnMPTsdwyegkEO35LHN6AMPFOKSNp8etjUW9O13b1Z2IRtiE43PmpLSX4bwBWjFFffd4/Y1w3Wfj8NBq0hoRLF1/swEl29985fjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727580868; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=RyVLMY172MJUSCq7oQjNmu27g1p65nqnHrXcG6YJXe92aXIygyM5EYdRuUSAAbfARbCOWvB02wevORlM3v765rExIXu5QJLfvawe1Y70exBEaxXxn/6VA/Le0rNTMn63Mrnpz5fRfHThMEz63wxpessbBwj9Ztiy7nNVAYuOV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=N21x/ffY; arc=none smtp.client-ip=17.57.156.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="N21x/ffY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727580866;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=N21x/ffY21ARqag4uBvODgjP/z/pKKI2PG2xXhxpZ1YHV6aGgwRx3QOpvVklmO8PU
	 3ajxikih7pyeFSqrgW4TWWZcSUuNYVA/hjlKDU1Snk0YqL+0Jc65PphX0yd8yL/MgR
	 wYXX6ovPAyhebDBP/wa/KjGwkwV8rf1oUhXtkqkfH9VU1f6iT0vypvkU1QOpkCEaSn
	 ezCqEvLxRIhhCthuuzvB7Tkpv2qvTZltaZyLdAnlFIffgzrrkpKPcb+ickMWwRObWy
	 UpU+0qMdZLaSRWEeXhqD1VISh05nS6q5Bylk6C1NWMNafXZEuJxPWPSYm/cT/5S5rc
	 8dDOvsIzOz5Rg==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090502.me.com (Postfix) with ESMTPSA id 06512320014F;
	Sun, 29 Sep 2024 03:34:24 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 28 Sep 2024 23:34:13 -0400
Subject: Re: [PATCH 6/5] git-rerere: document the 'clear' and 'diff' commands
Message-Id: <14A305E0-9D02-49DB-82B3-5F642C5B3044@icloud.com>
Cc: git@vger.kernel.org, jnareb@gmail.com, junkio@cox.net
To: normalperson@yhbt.net
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-GUID: zxKXT-COJmaM1oVqq1d4vvDuZVdgWuqX
X-Proofpoint-ORIG-GUID: zxKXT-COJmaM1oVqq1d4vvDuZVdgWuqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-28_20,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 mlxlogscore=647 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409290025


Sent from my iPhone
