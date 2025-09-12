Received: from scc-mailout-kit-02.scc.kit.edu (scc-mailout-kit-02.scc.kit.edu [129.13.231.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AC4A23
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.13.231.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694599; cv=none; b=rlb+UoVqXjOMSvdeV4WBfULDJE9Lq1skefuzaklzlFi1bueq5a8HMkKD1CA6+IgT5pXBtnBS4NhYKcK3ZMbWtfBLytH/HO+3gxvq126xjYHBSvAHiMkcPvt5zd99NayTgsobTuYrQ3XZRYLj7PFGI0htmbMtrfb6xvbRhh90g6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694599; c=relaxed/simple;
	bh=iCmJYE+2KnDeDHyV4n+PBqi/YjvgPTcBQdW1lTWjYzk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hymnJ92yeGzqAM3Af3xan0Yl9PU8e8D4M6A//KHAJ5qiVyVv8avmZGygICn4Tup8ed3S2KZLB2aDvU1fINoAQtGHLBb8RPmJyxm8SUfkt3EY59dYJxcYVp4/76Aqcseb++8mHTFOTxib2jXrbP9lBwlQZ/k+KampJxnlnIRQISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kit.edu; spf=pass smtp.mailfrom=kit.edu; dkim=pass (2048-bit key) header.d=kit.edu header.i=@kit.edu header.b=cVjXFrOw; arc=none smtp.client-ip=129.13.231.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kit.edu header.i=@kit.edu header.b="cVjXFrOw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kit.edu;
	s=kit1; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version
	:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x2AXu4RTrXt8JKO6VD3812/u76QHnIZmZd/kffr2yss=; b=cVjXFrOwHHTP9UnSTyBtEDex8r
	8nceL3+rwPhiV85ueYjPA5BeCtBj8bXMrcTXAYKRQbFMXnxCu6/0ef+cvmOFi+1R3/WP7Nut/lQMp
	e3oqUUaDV2Go6WAzSHb614FDkSRdemlasSm75o/PFtbogweZLI92z5hTkktjNRxvEppowslQy/CcI
	pAOcnZ0W9BOAH+bwKFL2342eWrRZ30KEvGPIuz0AFxtOXtLR1jn3dE3OPgxoEWuLapIvTeKVqg8uE
	BefzsEMVZwloTse2P6uI+q48JKFNgIdwaYxhduFWdzXj0CEOFZibxWLW30O8bObymvYh+Omq1PVKa
	HiFaV5zg==;
Received: from kit-msx-49.kit.edu ([2a00:1398:9:f612::149])
	by scc-mailout-kit-02.scc.kit.edu with esmtps (TLS1.2:ECDHE_SECP384R1__RSA_SHA256__AES_256_GCM:256)
	(envelope-from <darko.veberic@kit.edu>)
	id 1ux6Pz-00G6rK-0V
	for git@vger.kernel.org;
	Fri, 12 Sep 2025 18:14:35 +0200
Received: from [IPV6:2a00:1398:4:b001:2ef0:5dff:fe01:2c47]
 (2a00:1398:4:b001:2ef0:5dff:fe01:2c47) by smtp.kit.edu
 (2a00:1398:9:f612::106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Sep
 2025 18:14:34 +0200
Message-ID: <874521b6-8311-467e-b49e-44124154b5b6@kit.edu>
Date: Fri, 12 Sep 2025 18:14:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <git@vger.kernel.org>
Content-Language: en-US
From: Darko Veberic <darko.veberic@kit.edu>
Subject: git merge/rebase feature request
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

hi,

Please answer the following questions to help us understand your issue.

   Disclaimer: this is not a bug report per-se but a feature request!

What did you do before the bug happened? (Steps to reproduce your issue)

   git rebase main

What did you expect to happen? (Expected behavior)

   all fine, it just would be very useful if git would issue some more 
information (see below).

What happened instead? (Actual behavior)

   a fictitious example of the output from the merge command is as follows:

     Auto-merging x/y.z
     CONFLICT (content): Merge conflict in x/y.z
     Auto-merging a/b.c
     CONFLICT (content): Merge conflict in a/b.c
     error: could not apply 9cd549b33... start with initial status, 
update some refs
     hint: Resolve all conflicts manually, mark them as resolved with
     hint: "git add/rm <conflicted_files>", then run "git rebase 
--continue".
     hint: You can instead skip this commit: run "git rebase --skip".
     hint: To abort and get back to the state before "git rebase", run 
"git rebase --abort".
     Could not apply 9cd549b33... start with initial status, update some 
refs

What's different between what you expected and what actually happened?

   a very useful output before the lines above would be:

     Rebasing branches:
       --ours = "main"
       --theirs = "my_great_feature_branch"

   and vice-versa when doing a "git merge main" ie

     Merging branches:
       --ours = "my_great_feature_branch"
       --theirs = "main"

   this helps greatly in the otherwise confusing choice of command-line 
options when trying to keep one of the versions intact:

     git checkout (--ours|--theirs) -- x/y.z



[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-79-generic #79-Ubuntu SMP PREEMPT_DYNAMIC Tue Aug 12 
14:42:46 UTC 2025 x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]


-- 
darko.

dr darko veberic 大口 ~~~~~~~~~~~~~~~~~~~
karlsruhe institute of technology (kit)
institute for astroparticle physics (iap)
campus nord 425, postfach 3640
76021 karlsruhe, germany
mobile: +49 151 5600 7386
office: +49 721 608 24704
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

