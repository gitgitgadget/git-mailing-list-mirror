Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEF22611
	for <git@vger.kernel.org>; Sun,  5 May 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714939589; cv=none; b=OUk/1LCg462AK7YHxgthx/NGSl9CXmqJjAI4AMJ1sSu04PEJqVcGmmBpG+qcM66nVRDuuY0RSMQRMj+mHbwSQZ712ad7vti/zSOgxD6NlIszE48qUydAiEgtiOYTH4ZiJVpqIfWUxVC7xkX3bpjoRo9mIEhh96VKVbV6u1fDvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714939589; c=relaxed/simple;
	bh=e1MeLU/5rljMNo31+m7uvMUZID4Jq8mEJmBj8JOE5r8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=TyKBkA1vPHMV58kmS88/9Y/pOn+dLBGV5e1JG0h4VXm27VO8TpLRG90kiJDexlz927ho43CkF+mmAfC4qc77Yfttpwx88oy2rxge+zx3vMk9RToKeIlUKzMN4FMZZDYOHGUcKmmXJsTW/1IW798PiyHP7nt/+0bgTLR3Xgjtd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=I+sHdsl5; arc=none smtp.client-ip=17.58.23.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="I+sHdsl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1714939588;
	bh=e1MeLU/5rljMNo31+m7uvMUZID4Jq8mEJmBj8JOE5r8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
	b=I+sHdsl570vT9fQiBDfi7wLsrPGK27dC12MbH0ei8BUGM9QjQDd62Jbi5SKoBZtRb
	 G2ZVlNYh8avFJDd+RM8NxlqinC4JUq/8xQgVXFxdpz5xV39rp0uq93RCK6B73JMmga
	 KGSfpRdo47LgC02gKST+d6l4ZEP/jqsKAoF4r9zLgEosMFWjkPCBgdAJ6CJij3Av9P
	 Cr6JIIJds8EDminVvkeQXIaolBAadbMPmBMT1VYdAPrxb7zX0PpLY/R3sYcMZguMFr
	 DdpVnkTAgtoQfd37VQSYvFyWMcLn5JdRveKKs2xGTCH6yDK5SsAwBF93JjIPzfqhYN
	 q0qCCHygo+6YA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id B75FA357AEA8;
	Sun,  5 May 2024 20:06:26 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: hosamtot@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Date: Sun, 5 May 2024 23:06:13 +0300
Message-Id: <AA060682-248B-4CD4-895C-448DE86F2C87@icloud.com>
Cc: ae@op5.se, git@vger.kernel.org
To: junkio@cox.net
X-Mailer: iPhone Mail (21E236)
X-Proofpoint-GUID: rsbOgn7wvXv2Ozz1TpkK1WSpAlTzsIO-
X-Proofpoint-ORIG-GUID: rsbOgn7wvXv2Ozz1TpkK1WSpAlTzsIO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_14,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 clxscore=1011 mlxlogscore=628 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405050086

F u
