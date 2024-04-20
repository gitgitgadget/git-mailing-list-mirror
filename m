Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E7625
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713635226; cv=none; b=OF+wRMgjrBF3U+c3kxCuOHHgoGO99WX+g76D8+0tcBI6xuhpjQh8dsuPO5YC7DqQDcm+MlAoxjwQurg4RmUarudtEHI6O/gCi3wmpezlCArFePhGFOXjW14hFaYSD4Hoycwc3V/whv03/aZHaE4DXggF0ch1wxMe+/CYlk/6Gzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713635226; c=relaxed/simple;
	bh=ieNL8chrH/NBf+GCdIwI3Gag2L8v2vczD5xsKToTzb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hcg8mbWr64WwwVmhuHqqEjg6ae+5qdANgyAyeAJCV5VtV1RboBVz+AWZM/1SOL+rQSq54BCMtyqqHoYufIpkdMiA1pEhrOMqyRUApUpE7fli2dKdUcjc5QQLEmlrF9Ojg22HMlvIyf1BVVM3GqLkRGssfC7EVsb8lOnvDHjTC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43KHkuYl2609265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 17:46:56 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: Re: [Announce] Git 2.45.0-rc0
Date: Sat, 20 Apr 2024 13:46:50 -0400
Organization: Nexbridge Inc.
Message-ID: <034f01da934a$bc7c0bc0$35742340$@nexbridge.com>
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
Thread-Index: AdqTSpPXLtAD7rkRQqi+If63hJ79og==
Content-Language: en-ca

Hi Team,

Git 2.45.0-rc0 looks good on NonStop. Thanks for your efforts.

Regards,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


