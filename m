Received: from cpalmer.me.uk (cpalmer.me.uk [212.69.60.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8C342CA3
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.69.60.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215041; cv=none; b=eGpGHzQE9/GbCa3VHGbmc65eUI8/+bko9JMFJtMF47J5+cZsRs3uidazQrUC3jPE3mjghZiAwSQW+N2Z01+8hvdaxgidDQ2ub6h/onrp9CWDH5pEV5elUx6gIixML7hYcnX50+RcfLwYQPYUr2H9TSiSJ+2JNws3QqJTXOtcHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215041; c=relaxed/simple;
	bh=CrsjIDvUqRI3gmbSQfGyDZhlNDBS/5BUO22RfGyLbCY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PFtZEVS9vXcUqHtOtmkUySP1GoPsyJ0ZVZ8xAvbNMfvHIREBRFkElR/zm2Cq/pmhXZjgxDg6xI+sN3/WUpabh2QXvZUgo4BxLDBhXUuD5pgM6JS6At4PjIY/1NLpzaf83xsl6vnCZ2E21R8v3vh+NusyhlryPEk2B45/un3SiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chrispalmer.uk; spf=pass smtp.mailfrom=chrispalmer.uk; dkim=pass (1024-bit key) header.d=chrispalmer.uk header.i=@chrispalmer.uk header.b=r9sJ0KXe; arc=none smtp.client-ip=212.69.60.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chrispalmer.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrispalmer.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrispalmer.uk header.i=@chrispalmer.uk header.b="r9sJ0KXe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chrispalmer.uk; s=1; h=Content-Transfer-Encoding:Content-Type:Subject:From:
	To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a6/Op9V0ySiQhD4AHL4Nr88fdBA2LkTtDNqkrNOsyb8=; b=r9sJ0KXeHvAJ4M2RBEv9lgs/Fv
	1j6MNbqtpuEQwvYp1/Y5/V/Vw34Y0ZeOREdr0tUfaoroS4Y+9CVEUG2bPjXSYm3sARPiExl4TyPBy
	SheIzTSIzoBgkuFIy16U/de7EBH96dOmjZcpwLXfAYQNnHMtLuFeLVVEXvVCr01QqA1I=;
Received: from iggy.palmer ([192.168.80.52])
	by cpalmer.me.uk with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <chris@chrispalmer.uk>)
	id 1uqtLk-00000000YwO-04CH
	for git@vger.kernel.org;
	Tue, 26 Aug 2025 14:04:32 +0100
Received: from localhost ([127.0.0.1])
	by iggy.palmer with esmtp (Exim 4.98.2)
	(envelope-from <chris@chrispalmer.uk>)
	id 1uqtLj-00000000493-44VB
	for git@vger.kernel.org;
	Tue, 26 Aug 2025 14:04:31 +0100
Message-ID: <1011073f-9930-4360-a42f-71eb7421fe3f@chrispalmer.uk>
Date: Tue, 26 Aug 2025 14:04:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: git@vger.kernel.org
From: Chris Palmer <chris@chrispalmer.uk>
Subject: git whatchanged
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

We still use whatchanged frequently. Sometimes to check the later 
commits, and sometimes as an easy way of searching for changes to a 
specific file.

I'm not clear whether you are proposing removing the functionality 
altogether, or whether there is a new/better way to do it.

Thanks, Chris

-- 
Chris Palmer
chris@chrispalmer.uk

  

