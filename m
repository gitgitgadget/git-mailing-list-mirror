Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA402570
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127996; cv=none; b=GbKgazi4xn4FaOWSoO4rHOH5hJOoFaZpaH1plJC6azl3zGe+EmUKYUvz1YbVhY5nQDnf+Mo8qUTXHfey5da0VrP1FTGCTDbk5bMNSRdl1wubGB8+LxpmO8w3EVsRCOZJpotkZMejbJnuRI90ue9F83pKOyJ9CLd3xzNvP89kxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127996; c=relaxed/simple;
	bh=6iNV3iA1h2SmVtIXIoGmUwMozcI1tf4GGh/sp6RUjhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+GxTV9n7XQST4TVMsdPv5jTmbF0Ws7FyMkQ4vdw222DJuZTTvLEENccitPno7GbYZMiJPg3K84/6rOtOGZk3e4e32kc/XnUdc/pmDd3509aDry5Z09yxUfd2wmVfe0sqINv1zJ4C4XZWqMafPwN5oWb9At8bj26EsTA6DkEmpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 45BHkS5k087838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 10:46:29 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <c98ac093-73a8-45eb-a82a-5274606de336@rawbw.com>
Date: Tue, 11 Jun 2024 10:46:27 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
To: rsbecker@nexbridge.com, "'Jeff King'" <peff@peff.net>
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
 <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
 <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
 <20240611064847.GC3248245@coredump.intra.peff.net>
 <102101dabc06$16dfead0$449fc070$@nexbridge.com>
Content-Language: en-US
From: "'Yuri'" <yuri@rawbw.com>
In-Reply-To: <102101dabc06$16dfead0$449fc070$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 06:48, rsbecker@nexbridge.com wrote:
> It has been a while since I did a self-mount in NFS, but I do not 
> think that will reproduce the issue. The mounts have to be on 
> different servers from the client to experience this silly rename 
> situation. On self-mount, IIRC, the client is aware that it is on its 
> own machine and will not try to detect the situation. 


You can use a VirtualBox VM.



Yuri

