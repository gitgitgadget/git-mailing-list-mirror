Received: from ci74p00im-qukt09090102.me.com (ci74p00im-qukt09090102.me.com [17.57.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7441C6C
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727592635; cv=none; b=ATvl6nv2uoqdqNjRqCIN/JuPtkjFGg9z34uu9YLPuD4QLCfH8msEGompJWky8wOzVfLAJLZ1HQtQaTcUN3zP36+dc6R1geABCuZeWZGF7XeM90IlIiwhzIOwHe/uPEgdtM6WvahwTo5QI+5rq6Lz84zPLrdhF7RcSycq3P8RgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727592635; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=SNV8kK1V9Tk+keibjjGTlpdIf3HRVlSCyeOzx88xaF5+0UtrFiPv+L+kzofkF8I3SMXQ7adSrxDdwquEdV7v1K2i55cTzNSQxIl18VEHUHyOk7MaWBqlnkeUnHOvJ73t6fUFhZpu165Anq+JdNGz9hspgCVox3oWpohpvvm7MOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dOCgjQPy; arc=none smtp.client-ip=17.57.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dOCgjQPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727592633;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=dOCgjQPyC3mQtgPJgaqxZ5hdviZoausr0+zY1Pn/O/3ty8Ih0ZzdQTAWfyeKeWmbY
	 9OLwzitHQkut15Zm1SLgWYHyvxKz7u3z+K30lFInW6rWGZjBxbi0oYgAUggXB5HRz5
	 W9QuvR811r9NLCKzMc2MXaGtrW4JZ+Dxb+OUxZOjq3c7TNJvIycNz7v4L7vbWJzdVn
	 ezBwZQMVIbrH/Kgz2x2bm9fwM9mVb8GYhrmGuqTr7K5w4LHWJCvvKNNarVap9HIfxK
	 /hUsPKNQAYHrUoj2lVQ1fm5yGgBb4nfmQFJBL4TKgq5BjVz7BH1A7qvJMOqTPki/ds
	 9YCQQ9wSaVFrg==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090102.me.com (Postfix) with ESMTPSA id 4FEB13C00117;
	Sun, 29 Sep 2024 06:50:32 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 29 Sep 2024 02:50:21 -0400
Subject: Re: [ANNOUNCE] Git v2.47.0-rc0
Message-Id: <A0706A65-9B12-40C0-8E6C-842793C5780D@icloud.com>
Cc: git-packagers@googlegroups.com, git@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: gitster@pobox.com
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-GUID: _ePVpDPHU8759ispMG-EE6Xwpkf7SQ-y
X-Proofpoint-ORIG-GUID: _ePVpDPHU8759ispMG-EE6Xwpkf7SQ-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1011
 spamscore=0 mlxlogscore=609 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409290050


Sent from my iPhone
