Received: from plato.cgl.ucsf.edu (watson.cgl.ucsf.edu [169.230.27.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F808302151
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.230.27.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507989; cv=none; b=fuQasM02v140FwK3w1uBfqf57FDhyJ9DHmHMee6p2NXZLTDa8bEgnPbtqn9MRpcQmvoCkHGRupjyCtY6uQtlOsRCLWB8dL8fvl0zo1MrLZSdDw2xrC0FY0b/JuHnUGXCIhqizKCCHok9qlKeOEP+Lne5cw2GzCJi4dsauHS8iPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507989; c=relaxed/simple;
	bh=JZDwBr96RaDhCJ79mp/Vom1WdARZ+qEKpXBCAltFw0Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZRPy2tGGH93nQz3qvZ4X4Rq34GTplVa7RQPLYoroa32l0STHax5uRX7W0fCOXCJcNT1vGPEoa9komQQwI9vQfKeYCxGayFq1WJO6y3uhxaXJT+9Uska8+pBEGX0obR66EQr0MgVAmuC425cfw1xhg4oTH6hk9bUePbtX4tOjw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cgl.ucsf.edu; spf=pass smtp.mailfrom=cgl.ucsf.edu; dkim=pass (2048-bit key) header.d=cgl.ucsf.edu header.i=@cgl.ucsf.edu header.b=S6bb9EnS; arc=none smtp.client-ip=169.230.27.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cgl.ucsf.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cgl.ucsf.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cgl.ucsf.edu header.i=@cgl.ucsf.edu header.b="S6bb9EnS"
Received: from [192.168.50.73] (23-93-78-111.fiber.dynamic.sonic.net [23.93.78.111])
	(authenticated bits=0)
	by plato.cgl.ucsf.edu (8.15.2/8.15.2) with ESMTPSA id 59F5gV2x1568010
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 22:42:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 plato.cgl.ucsf.edu 59F5gV2x1568010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cgl.ucsf.edu;
	s=rbvi; t=1760506951;
	bh=U8cuxgdoO3B0iFm8FYgss1nSCD7ElL//kxNfa2L7ITo=;
	h=Date:To:From:Subject:From;
	b=S6bb9EnSrhdJd0kzKFjZmOH99FKrQv16t5p6O4GtNL7Qia40Rz/D+MB5icfXv/Veh
	 1P4qUbjT2mmlBfVxo23WpHD5aFwHsGVZoODeoKZbYOlyIWLu8AGOJtYqxu18cTq8zE
	 Qwboa7aHh1zrZDJDZsP+9KIjamM41QVPAw2Wi0x196wNW9J2wDHUdEOn6PD1Wf6GQ7
	 Wwi0xEEFKQuCCR7W4aAKhnFKj2wzIjI/a+HRemOzS/W2dmkKvUWv35ieIsVz1t/hlH
	 d9UnJX2ioHTgt13T6Rh+p6RwDYr6CN1fhdA7aqXfiO0CzoLpJnPevYKEw+UrFGrdSx
	 3W3wrEJDMpGnA==
Message-ID: <870bd6e8-3253-4b25-85f3-9a12b074548a@cgl.ucsf.edu>
Date: Tue, 14 Oct 2025 22:42:29 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Greg Couch <gregc@cgl.ucsf.edu>
Subject: still using 'git whatchanged'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please fix the 'git whatchanged' deprecation message to suggest using 
'git log' instead of suggesting the painful --i-still-use-this and 
email.  The current behavior is unappreciated.

     -- Greg

