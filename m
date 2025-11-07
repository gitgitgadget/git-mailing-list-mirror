Received: from karlchenofhell.org (paxle.org [194.26.180.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF751324B2D
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.26.180.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516129; cv=none; b=rMUpwJmdwVcFIi6dJg5/sp8PBo1PL/9DS/POgVl1Ne4MW7+hCq2B5gjqUqFMWUjMCAELCjzRuGK5wGyS4BqRXxw8ePmKwXo+OULV7aP8sTouDZlktP8dvjdY7ferw/5ed9/JLaiv7flN2C6jwo/f0R+qMpSZCqa3q+alHiDPnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516129; c=relaxed/simple;
	bh=XMcxKF04CVmEzvPe9yxCblwTRIux2R92OHRcZ0kJrRI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:Content-Type; b=EUnpLnvEiyQaXo6JljNTzM90n0pubzMevEE+Vtyth4w2tnl3vl9p81AI/K57oCamvwA9UcmIKDx6GNJ39CFguI9gYDlMC/68T3pt/oDFK73bR4XADMcwChMjn0gMgF+b4pLpnIz7hTTWTogfUQF7DtvocQm/0Yz5A6bZZiKz5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paxle.org; spf=pass smtp.mailfrom=paxle.org; arc=none smtp.client-ip=194.26.180.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paxle.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paxle.org
Received: from cthulhu.fritz.box (pd9fa9fd8.dip0.t-ipconnect.de [217.250.159.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by karlchenofhell.org (Postfix) with ESMTPSA id 6A59814A012
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 12:40:42 +0100 (CET)
Date: Fri, 7 Nov 2025 12:40:41 +0100
From: Franz =?UTF-8?B?QnJhdcOfZQ==?= <fb@paxle.org>
To: git@vger.kernel.org
Subject: git whatchanged
Message-Id: <20251107124041.d6aac4345e89a9ac092c59e3@paxle.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear git maintainers,

I am using "git whatchanged" on a regular basis to understand what
files specific commits touched and in what way. I vote for not removing
this functionality from git.

Many thanks,
Franz Brauße
