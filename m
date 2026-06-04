Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53D20D4FC
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.182.54.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598242; cv=none; b=PeZfFX37rH6hxDPsJOL62B4i5Hl8gkxoM5pw8dmP8Gs2vvZophzMVstypGR9yJ2dPRPqXsyyu1egLqnAJZZcZK3OKTWe7ueszUh+2rybcpEjYFV1KK38lCj6FnJFaxXrmm4D6GYPptvYfxBs+LbwhyUgFfn0DAG+HJbmyWfFbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598242; c=relaxed/simple;
	bh=g0XzGHzB9ys5gJ8LHz9BhDX/zE/nuBuIEMk4I3jEY9o=;
	h=Content-Type:From:To:Subject:Date:References:MIME-Version:
	 Message-ID; b=IyG98AkSPWIAa2RqJe9gltzfrtsrS9nu6WC9Jmidx4gnygg4bNvpIQD99A3RoWMekadH93CD1s385d1RateEem2/+sCpWn3F3lhDxIXZ7/fB09BvA4WNBbRoEjPg73yppOx0fDuqB/kT3y9f+rWrpvfVkCYEpptVqvlvuQCkia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailo.com; spf=pass smtp.mailfrom=mailo.com; dkim=pass (1024-bit key) header.d=mailo.com header.i=@mailo.com header.b=bZOHKjff; arc=none smtp.client-ip=213.182.54.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailo.com header.i=@mailo.com header.b="bZOHKjff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
	t=1780598238; bh=g0XzGHzB9ys5gJ8LHz9BhDX/zE/nuBuIEMk4I3jEY9o=;
	h=X-EA-Auth:Content-Type:From:To:Subject:Date:References:
	 MIME-Version:Message-ID;
	b=bZOHKjffL9NqkqgYM38lht8cdHJZ8lvqKlHAMl80dq7XKRQFZo7y/GLpl4gMJ5V3t
	 nA7WB+K99o9CJdmd8IzDcpFe3duH0EqCmz/Il8rMk/L72IEugDBoMzre+YZf/8QoJw
	 dVctd7bbzG0LDahwsz1g+BSDKsjZuMoWjMCMz7OI=
Received: by be1-8.in.mailobj.net [192.168.91.18] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Thu,  4 Jun 2026 20:37:17 +0200 (CEST)
X-EA-Auth: vowmWEY+/eFD7mp4uOXbr2tFsUMwb9QvV+JrH3RyG6uEndYHELouAkvr5MvEduG5JAZSf6dZrBvxhvRRXfHV47EFBb+b3LD8mUQ/aC7RoYI=
Content-Type: multipart/mixed; 
	boundary="18b5f4a8b0817894_1c880c372233fca5_934094af65545251"
From: "Debaashish Nandi" <debaashish@mailo.com>
To: <git@vger.kernel.org>
Subject: Message from Debaashish Nandi
Date: Thu, 4 Jun 2026 18:37:12 +0000
References: <fcb34925-f10c-4fc4-826d-a55217101ec8@localhost>
Chat-Version: 1.0
Chat-Disposition-Notification-To: debaashish@mailo.com
Autocrypt: addr=debaashish@mailo.com; prefer-encrypt=mutual; keydata=xjMEagtTvRYJKwYBBAHaRw8BAQdA+aK0NviIE9WzM5brc0uG8VCIyAx1+EvgGgkUCYWtqj
	 TCwBAEHxYIAIIFAmoTG04WIQTboV5vxRziyNaDfyIBDZJMjnyZRwIbAwIeCQQLCQgHBRUICQoLAxYC
	 AQMnCQICGQFIFIAAAAAAEgAtcmVsYXlzQGNoYXRtYWlsLmF0ZGViYWFzaGlzaEBtYWlsby5jb20sZX
	 E3OWNydWtxQGRhbm5lc2tqb2xkLmRlAAA/gAD/XBUrdazIY1fxJZBBPsspFe4hptxMaqNlOM5d3C31
	 CgoA/jCUektGMviVDwlmWjZaH5BU1rsQYS2T8OOJ2DBFYNAIzRY8ZGViYWFzaGlzaEBtYWlsby5jb2
	 0+wpEEExYIADkFAmoTG04WIQTboV5vxRziyNaDfyIBDZJMjnyZRwIbAwIeCQQLCQgHBRUICQoLAxYC
	 AQMnCQICGQEACgkQAQ2STI58mUcF3QEAggxGPZiL3UbMD6uekwZUo9eBgZ/D0QKmHmqy4T4l6RoBAI
	 1jl2MRtWYnnkUXnPUtNlqj7SBdBQyoUtUAjz5usT4EzjgEagtTvRIKKwYBBAGXVQEFAQEHQJkwMgKT
	 O2NWv1a4VjE2NTAqz28vKyZOeBhqkV8C1us9AwEIB8J4BBgWCAAgBQJqC1O9AhsMFiEE26Feb8Uc4s
	 jWg38iAQ2STI58mUcACgkQAQ2STI58mUeFEQD/Wof9ZgZG9ndMWHruOXP1VNLDMHN8fjDw3uBZAOxO
	 xVUBAOeXxa7vEe4RVRUHlr4+9g7kDBgJ4JYQqB19xRhHA8MI
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <fcb34925-f10c-4fc4-826d-a55217101ec8@localhost>


--18b5f4a8b0817894_1c880c372233fca5_934094af65545251
Content-Type: text/plain; charset="utf-8"
Message-ID: <fcb34925-f10c-4fc4-826d-a55217101ec8@localhost>
Content-Transfer-Encoding: 7bit

Hello, is there any game playing which l can understand how git works ?
--18b5f4a8b0817894_1c880c372233fca5_934094af65545251--



