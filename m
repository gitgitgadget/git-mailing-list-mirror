Received: from achilles.noc.ntua.gr (achilles.noc.ntua.gr [147.102.222.210])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08CF1B0F1E
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.102.222.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745790252; cv=none; b=JFPSi1CNT2vTNYbM87T0nHDgTb7VRXf+/tsj/XMpeAPklKAFsokv4uzZZKrSfHuAEETZRWUBTr2Cygytj1RzVZE9ortGEyiVTCGS0e6tKw+/4DYRvC8XWIMIkEdbF0kqi609StOh0Q4L9BsoSAVIemSoA/tU2PzW1InNVkj7sEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745790252; c=relaxed/simple;
	bh=ZV+T0NStz8zkMn5Y5T7PCE1ZlSVmtuBx54VRGXPz4yM=;
	h=MIME-Version:Content-Type:Date:From:To:Subject:Message-ID; b=WUdyMOiz0S1D+U9bReQDcTo1iWmemUt0k2mWmzFVhrqBVjJ3zN6IojuLp11wSsOjcM7gWD6PoCtPjCF1uLdxq2y8BDEosFK6Wjx8sKXQfUP68m6Rxj6AF2b2Nxg1komwJBCqTChnm7gKWWpMGdNXsNZYACht8NSZ60Trydf+HRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.ntua.gr; spf=pass smtp.mailfrom=mail.ntua.gr; dkim=pass (2048-bit key) header.d=mail.ntua.gr header.i=@mail.ntua.gr header.b=BcUHMD0s; arc=none smtp.client-ip=147.102.222.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.ntua.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ntua.gr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ntua.gr header.i=@mail.ntua.gr header.b="BcUHMD0s"
Received: from webmail.mail.ntua.gr (webmail.mail.ntua.gr [147.102.222.247])
	by achilles.noc.ntua.gr (8.15.2/8.15.2) with ESMTP id 53RL2bRL047464
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 00:02:38 +0300 (EEST)
	(envelope-from el24614@mail.ntua.gr)
Received: from webmail.ntua.gr ([IPv6:2001:648:2000:de:0:0:0:247])
	by webmail.mail.ntua.gr (8.15.2/8.15.2) with ESMTP id 53RL2akj091934
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 00:02:37 +0300 (EEST)
	(envelope-from el24614@mail.ntua.gr)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mail.ntua.gr;
	s=ntuamail; t=1745787757;
	bh=ZV+T0NStz8zkMn5Y5T7PCE1ZlSVmtuBx54VRGXPz4yM=;
	h=Date:From:To:Subject;
	b=BcUHMD0sZF1pJKH7plwkgHB5big8Nvdv8Py1quBUrx71y0l+asaC5HZbZ0iXnFe3C
	 JZYp3iQ/lQRXrJqADhawI7Uayn1AJ9UVCJkExKFOdnLYvl4RHVMI6tU7bsP+bP6qVA
	 tOIp4F+9oQxS7yWenNqhFCqq3YdtJ94UQZ3k5fRdHbspeoaWrl702ee/4knjvS6Ynx
	 WqHCG9m5E9t7m3bxttl29xY+yY3J5qMHakrLoB4RDFyGz6dOEbvKcquUcP71gqryrS
	 hyTFdFR0JCn84fEiDzDjBq2jAUdeHslyOpAPLBh/7rJtg7hc3tNeXSTU8NWIXRdE9y
	 FOf1YZ+w4v1/g==
X-Authentication-Warning: webmail.mail.ntua.gr: Host [IPv6:2001:648:2000:de:0:0:0:247] claimed to be webmail.ntua.gr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Apr 2025 00:02:36 +0300
From: el24614 <el24614@mail.ntua.gr>
To: git@vger.kernel.org
Subject: Probably typographic error in tutorial 2
Message-ID: <15509dd701ace6793f0ae19368e4c0c3@mail.ntua.gr>
X-Sender: el24614@mail.ntua.gr
User-Agent: Roundcube Webmail/1.3.10
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.6.2 (achilles.noc.ntua.gr [147.102.222.210]); Mon, 28 Apr 2025 00:02:38 +0300 (EEST)

Hello,

I think in tutorial  2 (https://git.scm.com/docs/gittutorial-2) in the 
first code box the second time that file.txt is edited ($ echo 'hello 
world!' >file.txt) there should be an additional ">" because a single 
one will overwrite the contents. As far as i understand from what 
follows bellow, the text should be appended.

Kind Regards,
N.Antonetsis
