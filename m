Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E866DF78
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731770167; cv=none; b=qF36PjXTeFvW1E/mB/9MdCh9rQ/fGyW9IJqi0GAylrMj/24CS7L5/jGnXXeWC39HjZHVjhixnngxtz3UgTMXwFzbcTX2je+Rof6E67nIq8WLKbM6io8NaCPUPfkgKGpy4YdsvAiv3TL4cHOBjWBUjdV/3i7lQUv0P7R7yAcAW08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731770167; c=relaxed/simple;
	bh=8dMwU037SgAIAAbMgSru+L0ewbwqLEXUKwTGWrZ1/YM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CkNlYk2//xNRb0Vb8uO6FjQEM/j1dUYNdwip0emZdv5BiV/FanrxndNUeguIlwkku3FXV3jIxaeOEATpIVYnnkul5iSi1SL9meE6voyRaiPHyVbc+wwqy9ocJGXOjtACrf/vftedW4IHkbz9G+Y9mwJt7PjXrW3xwKKQT0ouhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4AGFAvee3879490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 15:10:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [Question] OAuth Integration with git
Date: Sat, 16 Nov 2024 10:10:53 -0500
Organization: Nexbridge Inc.
Message-ID: <014301db3839$bdfa7240$39ef56c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Ads4OYDom1hLkI+ESIOVDzKSumrdBg==

Hi Team,
I was wondering whether there are any good discussions about integrating
OAuth with git using a custom credential helper. A process flow would be
very helpful.
Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



