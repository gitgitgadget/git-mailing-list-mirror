Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5121D3C0
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857141; cv=none; b=sbVyx9Q+JUPQ0SgiEECuKpfwbfLOC139HJS+pFMMPdI9DIjccpJmLpwyGUn8Q0U5mqp4OCMgrmvzZc/WQTvnAFS7K+UfuFSCXL8tdIy/fg91k5TgTmrqyds3uGEk/aOCWwKIsOfDImrfnmw0zWQHPR567ZK9UvqBikVPpH9hmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857141; c=relaxed/simple;
	bh=q2CtKAFInOlCJTgLrQdrnphMrLLufdRpYtQwIQyAky8=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BgEecrZ0iTeSfhkV2pX54ZkWYrWXCR5w6FDJraJP3/+21KN2WMp5q/qV+FYHC8T1CCHW27OdDRfrRv4U1rxFkOdUCgYLw/ZgvONRGbdS4O3k69s3E5VmSvAoG1mHfFmisKuv9kDVTPuMc/ol+5kSG1W8sd3laEg9As96tQxS4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5B4E55ba528305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Dec 2025 14:05:05 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Mark Boonie'" <boonie@us.ibm.com>, <git@vger.kernel.org>
References: <PH7PR15MB617958EEAF07E4C5F8CDF0C5FBA6A@PH7PR15MB6179.namprd15.prod.outlook.com>
In-Reply-To: <PH7PR15MB617958EEAF07E4C5F8CDF0C5FBA6A@PH7PR15MB6179.namprd15.prod.outlook.com>
Subject: RE: Command line query for teams
Date: Thu, 4 Dec 2025 09:04:59 -0500
Organization: Nexbridge Inc.
Message-ID: <01c801dc6526$fdc522b0$f94f6810$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH/cvSL2DDII4WKH1MW7G6PyLp/eLTLZ3Bg
X-Antivirus: Norton (VPS 251204-0, 12/3/2025), Outbound message
X-Antivirus-Status: Clean

On December 4, 2025 12:10 AM, Mark Boonie wrote:
>I'm a git very-newbie, still trying to find my way around, so I apologize
if the answer
>to this question is somewhere obvious to everyone but me.  I'm looking for
a
>command that will return the teams that I'm on.  Someone gave me the URL
>https://github.ibm.com/orgs/ztpf/teams?query=+members%3Ame, which gives
>me the information in a GUI, but I would like to get the information from
the
>command line.  Any suggestions?

Hi Mark,

This is probably a function of the upstream git implementation (GitHub,
BitBucket, GitLab, Azure). The function is likely done via a REST HTTPS API
and is not part of core git. You might want to check with the appropriate
documentation on those.

Regards,
Randall

