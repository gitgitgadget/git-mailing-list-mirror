Received: from mail.hamid.cc (mail.hamid.cc [142.93.132.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A72264B1
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.93.132.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172939; cv=none; b=fgpxfh76ENg50/7GDkbWfsN8/3WnjxSSzGVb7c8gyIkYL/hmcfIDPNVrsik0nB+H3Lm1SpQi/9cRmECDoTwhCOArrDQTOCJ8nBoOOubDjQC1Jjv5Hic/FiY+zUP0kKDn8ATJQvMJdlY9BBrdJP3Tp+/swRXH9Ap9A/6F6Gm2yHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172939; c=relaxed/simple;
	bh=qaLMMWTWg3uc1F9WSpqSoe+xHoIxGmjgFGL84tzeiPA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=SZ+blnDdgn4maSOAibNWbLILJ7v6E4u+B5tBahGN/4BjirQTaJ8u9xPjFwvlNuAGSJsMX1bqeM44xw9WvTVGPbd3letOpKrc9lwLgLdhahJsOc7n/xkjfqEDp5wlBsFf6OPqQ1X++Ul5RO9EgNnqVGhyfX+fZKdElADqdwrdvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hamid.cc; spf=pass smtp.mailfrom=hamid.cc; dkim=pass (1024-bit key) header.d=hamid.cc header.i=@hamid.cc header.b=sdJoAKfY; arc=none smtp.client-ip=142.93.132.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hamid.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hamid.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hamid.cc header.i=@hamid.cc header.b="sdJoAKfY"
Received: from smtpclient.apple (pool-108-30-138-133.nycmny.fios.verizon.net [108.30.138.133])
	by mail.hamid.cc (Postfix) with ESMTPSA id 2A136402E7
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hamid.cc; s=20200130;
	t=1758172530; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=qaLMMWTWg3uc1F9WSpqSoe+xHoIxGmjgFGL84tzeiPA=;
	b=sdJoAKfYPuuGmNZTizW8sEEwj5kkk3RA/nkUgY4pSDVseyd7WQ4D58dE7DVyb+DD9Zt0SI
	M7TfLa5eaVqeLdIEuxk1Jw1zLj/VrMwXJZfuP/RwPybTEsmALvVhKIgeB8qEhJEblKDoSa
	+W075o0VK/2IMN+o+RndRzpvsE0bDkA=
From: Hamid Ghadyani <hamid@hamid.cc>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: I still use it
Message-Id: <C86F5767-CA24-4E19-BBDB-D7B4B8FF4295@hamid.cc>
Date: Thu, 18 Sep 2025 01:15:18 -0400
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)

Please keep 'git whatchanged'
