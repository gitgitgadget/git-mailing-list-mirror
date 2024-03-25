Received: from mail-108-mta168.mxroute.com (mail-108-mta168.mxroute.com [136.175.108.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEE5D8F8
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372517; cv=none; b=D6xRefb+FSsr7hKaDQP8lTy3xxxMUaJCFdvqy3khDKJvwKDglaPgNAWDXpdUZpuSRqU1F9AeohQ1aLC3ShDxwk92jrJk0eUjIdkPoyFWGBmztPzJsSMISxK5xo4kRpc3EEJBEYBBfloMshGxxB2KxafE7PHOH2/a4oI5EQQqDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372517; c=relaxed/simple;
	bh=faUZQxVPPIwdqFSy2V6Rbtzpgklqwf5sJXsimyuT954=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=ctkWlsPfsDTwNfySuj4ud+8/pEeHG0MS1BWUReydikR17ZnLBJdw+TT3YwdJUVSMEdubexLSVLULlUYuoyAi6jiaIr5/U9tzH/5NgehPWbKjjfPXCO9gpfgZjrQeYBnF2k//RrI2+azsIVCMC0AfPqXFHkjEiOmWBfxk4RNpsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me; spf=pass smtp.mailfrom=vkabc.me; dkim=fail (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b=Rlqd5nms reason="signature verification failed"; arc=none smtp.client-ip=136.175.108.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vkabc.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b="Rlqd5nms"
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta168.mxroute.com (ZoneMTA) with ESMTPSA id 18e75bb7c0c0003bea.001
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 25 Mar 2024 13:10:05 +0000
X-Zone-Loop: f98544bbd24742fa12810611e40f5fefc93545848808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=vkabc.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:To:From:Date
	:MIME-Version:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=yfeweBxepHWo3zIhoa3efsKmhF1ErY1KMY/pngAM8ss=; b=R
	lqd5nms0vZGy7UqppWEVrID6Bp5MjqIxT6td6aTIN4sGlb0gjx7pQE34tof8r6sxFCnZ3IknohZ9h
	xdaRCNWtyG7yTf4T/EQv/Ieq5pHN6wGyDdzhemi5KdlICYNysMQrvbLnxcFzSiIhr7NItrG7OhV5c
	s/7Ku0Rp3kjF6ealJcnjSS52VP0AXhyV2K2Pxncg6eypX1UtaiC7oofzVMyPA21F9+RH5vsVdjXfU
	YqgEKPYtuuy1e4OVImDNzV3AfPJkqFASPDrjjYuc5yjwnjuLZ0g3kM8cIPdeWyG7tw6/KJ7e+Ghyw
	5DQYAHuBKuZR4PR62/wr0fliipGqSbm8w==;
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Mar 2024 21:10:03 +0800
From: vk <g@vkabc.me>
To: git@vger.kernel.org
Subject: [GSoC] Microproject help
Message-ID: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
X-Sender: g@vkabc.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: g@vkabc.me

Hello all,

I'm Vk and I work as a software engineer. I am interested in 
contributing to git repository. Apologies for the late start as I only 
stumbled upon GSoC recently and git project interested me as I use it 
everyday at work and it would be meaningful for me to contribute to it. 
Even if I am not chosen, it will be great if I can start learning to 
contribute to git open source.

For the microproject, I have looked into the lists for 2024 and it seems 
that all the projects have been taken except for `Replace a 
run_command*() call by direct calls to C functions`. However, it seems 
that the issue has been solved. The command I ran to search throughout 
the repo is `git grep 'run_command*('` and the search result returns 
run_command functions which I assume are essential.

If there is any low hanging fruits that you can suggest to me for the 
microproject, that will be great. I will also be searching throughout 
the mailing list to see if there are any potential microproject to work 
on.

Best Regards,
Vk
