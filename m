Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C8F1B812
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050131; cv=none; b=CeCR3+9gffGpJ3d5rGwgrAUgMQMRdGByFf31WtWNuezrQA5AEXW7jw6SBfx1y4B9hWJy2x+WOyowpC/RyS7ddPCNNMFUJLjSMHqgrWsgFi1yw7QlEoAS3Odc6MgE//a+3kPxLy+KzG/9yAUzTrfhAIb7zaiy76F6iD8cKQev3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050131; c=relaxed/simple;
	bh=PPdbG122lNDFLcQ2UsH8ujnliw1W4EIrr1V8etpwTYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+aRuz0T9zGAdOyfDuPKkI3+Z9cw8UhVgOIkiks2+ULBuQWDEntwphTx7dm1Pu7j/PJTVUv1AiWdujGNmziGSuBzrv1UiQhTr0iSzQ4HKAYq7ZFU04TCkVkFnER5SIvb7OR+WmWYz6MfIAIR51v4Hh5506Se8gIEcloMjTFFEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 45AK8dkg079329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Mon, 10 Jun 2024 13:08:48 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
Date: Mon, 10 Jun 2024 13:08:38 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g>
Content-Language: en-US
From: Yuri <yuri@rawbw.com>
In-Reply-To: <xmqqwmmw1sev.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 12:58, Junio C Hamano wrote:
> So "was supposed to remove" above is not quite correct. Where did such 
> a piece of misinformation come from?


"git clean -df ." removes all files that

(1) aren't added to the repo

(2) aren't added as exceptions

(3) aren't repo files themselves.




Is the above definition incorrect?






Yuri

