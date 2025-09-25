Received: from smtp86.iad3b.emailsrvr.com (smtp86.iad3b.emailsrvr.com [146.20.161.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9513FC2
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837129; cv=none; b=FSQk70XNPM4y1lhZ5mUxBIIVbGPDKrheaFOitsalSf8akFFhZCRB5sNndBTM3ahdb0nRqq9gCzJhGwGVXDvJoStkhaOy3BOPCAuO3RKx3qTdoyUuMN7KnTQhta5pjaG9YBa8Vc8jcZJR3DMbTNMCEeZBK2nFE2I2UlSoD2HTXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837129; c=relaxed/simple;
	bh=YuGIAb1EsJAAtFJFSrcNTniqp8bxMLKuMi2RV1N9EVY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FIa8GIMDP0eBmVP9DYOW9DzhxP+758mQTKLgcgM2jM+HFwl7qGBkj+gPSU0my+A5PDgr6N8rxkGGLk/qGZj2RvHLgkQZAo/5bev22tXBxuD+KHXWIJjf6dDPEKUjjsMWGjJSWjo1Vp9uQEj500i3obKcnBbdC/e0A5NiYN/1qWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=electrooptical.net; spf=pass smtp.mailfrom=electrooptical.net; dkim=pass (1024-bit key) header.d=electrooptical.net header.i=@electrooptical.net header.b=sLnT+OMm; arc=none smtp.client-ip=146.20.161.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=electrooptical.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrooptical.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=electrooptical.net header.i=@electrooptical.net header.b="sLnT+OMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=electrooptical.net;
	s=20230609-lhoc62o1; t=1758836696;
	bh=YuGIAb1EsJAAtFJFSrcNTniqp8bxMLKuMi2RV1N9EVY=;
	h=Date:To:From:Subject:From;
	b=sLnT+OMmcpXarkTHfnRVCofPtLeVvbZcG2kApRTo0V6ARCE+tW/RNranCX+USwrNi
	 QfdhmJ+E12+2+zn48LsgS6ty6QcsWSeYkrZXVxyN91XS9A7TeNuItgOaMD9fC6I3eg
	 k69q1EBYv325Gs2d+gR1FU7ZzEH83jo3FU2ku+XY=
X-Auth-ID: pcdhobbs@electrooptical.net
Received: by smtp11.relay.iad3b.emailsrvr.com (Authenticated sender: pcdhobbs-AT-electrooptical.net) with ESMTPSA id 3BC85403A3;
	Thu, 25 Sep 2025 17:44:56 -0400 (EDT)
Message-ID: <67a6ec3a-a718-438f-ac4c-ff989f316a9b@electrooptical.net>
Date: Thu, 25 Sep 2025 17:44:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Phil Hobbs <pcdhobbs@electrooptical.net>
Subject: whatchanged is super useful!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: a78c571a-dcdc-41f4-919f-9173c14eeeef-1-1

I use git whatchanged all the time.  Please don't remove it!

Thanks

Phil Hobbs

-- 
Dr Philip C D Hobbs
Principal Consultant
ElectroOptical Innovations LLC
Optics, Electro-optics, Photonics, Analog Electronics

160 North State Road #203
Briarcliff Manor NY 10510
845-480-2058

pcdhobbs at electrooptical dot net
http://electrooptical.net

