Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29143AA5
	for <git@vger.kernel.org>; Mon,  6 May 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991242; cv=none; b=c73LAIkgnUwqM1ybSszsLkZiIpHzH32ICFZiGjAmyQwNj5tuUx3ad8rFSqzciTFztClvdvhwyCY5RTmcCF+wk7OBouGlHUWm1/o+pcTuqJrzE2TtjVbjVyny9UUL2c6nlsoloc+zzMyFAHAdRIeEAO3NbEEjs/uxanKqtyDqO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991242; c=relaxed/simple;
	bh=r7t/1oeYm/Oah7oSS3TwGteG74fuCCqcDbPOFXOxonE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=ovK2eGMM9uhIWTQnpADMFGVOa1UNkMDqC2zFn2IbByaOnUi05jFzY2Jx0W1CFy+0+DTJSjd89cQsywFk9/fstidUBCh4cu9MWITyf3ipnxYBgliBn2wgx4Tyr1NAWmSpm4DjJskLTzeyQSI6HLyBamgt70vfqqbAo6kCDNEZQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HYJqxFsM; arc=none smtp.client-ip=17.58.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HYJqxFsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1714991240;
	bh=r7t/1oeYm/Oah7oSS3TwGteG74fuCCqcDbPOFXOxonE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
	b=HYJqxFsM+xIOg5nr84+tNIVE/UGPQy/R2UTtWmJC19n8hoQaOds3YIs5eTItY5XLk
	 +BiNrSLNb1yDz9rzsQFpJMY9nEPOe1Z2jbTaaaY/IiOZ8IJX1QfU581sfYwwOBfDaP
	 LTdNEqVW6iW03yEvipMraX5H9kTlTiyUW2YK+xRkIHm8Aw/kDQASayBAuJ4XV0owBu
	 zW6y/4hFZKAeL5Xl7PfunxZy8ztdZ0s8SCHtDSUKl2zQNAS9S7a2HZM1VlV1VVXhYS
	 JrtJFl8E0LUA45SxDWQJItzd9uKx1emZEuRtG94UwOEYG5CzEzhsHHuuUCxCRmJHYd
	 z6fHVXlzNECvQ==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id EA19174021F;
	Mon,  6 May 2024 10:27:18 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Toshihide Mitumaru <mitumaru5930@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Date: Mon, 6 May 2024 19:27:04 +0900
Message-Id: <18FA0D03-4CAC-445E-A24F-7E3E64F0DEAC@icloud.com>
Cc: ae@op5.se, git@vger.kernel.org
To: junkio@cox.net
X-Mailer: iPhone Mail (20H115)
X-Proofpoint-ORIG-GUID: SgbMV134cKBqzlPaaOwgnLrQtoVQzPgn
X-Proofpoint-GUID: SgbMV134cKBqzlPaaOwgnLrQtoVQzPgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_06,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 mlxlogscore=589 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2405060071



Sent from my Hello,World!
