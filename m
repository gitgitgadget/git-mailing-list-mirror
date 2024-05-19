Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7471743
	for <git@vger.kernel.org>; Sun, 19 May 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716154781; cv=none; b=RlakfDFZDAz7Gc4Va60qXlobIAObWgi56hhQi/5cT9rXKFMe3ygjfmovT3Jgw0m2YkoPCmoigl0k2rFB8Zqkc3eD5gbtw6n+oz81Zrb7XnzmflahjJlZ1TjeUqj8U8WcE/RXTKwi9aQ1TLYoaRurzeW/W6q7+jhTlDz5NSFbWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716154781; c=relaxed/simple;
	bh=FE1d2EcLYxsFcXcZIQmx1E51hsLphXGK8xeJsgN6MXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvnpeiJk3SU6ytsrKqKyOSb586imvpK94LGFD/2/8BU+TH0kc7dhHz27f6fM1kcXQbEiciEyt/1+kINaZjP4vnGgo/ACIYX30nx4blF82hvytyFvr7Vy4AeQMuwkktcxVXQqj9ANU+qapaG1z4M6o+UrMpKPCk//Cs0NZiW1EGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email; spf=pass smtp.mailfrom=iee.email; dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b=gMQU3Q6w; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iee.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="gMQU3Q6w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2024022300; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=FpDT+OPkdZ7p/mEHoC1O3Psk/D7D/EQrYy5DrEcnBwY=; b=gMQU3Q
	6wGT8RF3dLqLtZMY6uao4I5Sb576Vk3hRhnpTy/gUVK5sae76G9Ixq1RdWO6JBiInRSFww1+kJM63
	JW2EEFBxOh7AnBFiw2LPSb9cO5PyF8ol6nBtjiIctoWN4magMcCChbsQ/fzhAQz/i8inQh0UtOJVG
	aoJ8dwU1uGM=;
Received: from host-78-146-11-207.as13285.net ([78.146.11.207] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1s8oFj-000000000q8-2DIW;
	Sun, 19 May 2024 22:39:35 +0100
Message-ID: <6c0206de-054f-44db-9442-8940396f3e72@iee.email>
Date: Sun, 19 May 2024 22:39:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: subscribe
To: Junio C Hamano <gitster@pobox.com>
Cc: Kevin Gale <s7g2vp2@yahoo.co.uk>, git@vger.kernel.org
References: <AA7553D9-B385-4745-8AA8-31BBFEF6A818.ref@yahoo.co.uk>
 <AA7553D9-B385-4745-8AA8-31BBFEF6A818@yahoo.co.uk>
 <b4d653e9-11a9-46fe-bb5d-3a01756c4454@iee.email>
 <CAPc5daVJ-aj+xCdHesBr7VEeNmgvvaW8Tj=6PS419jYvSLfDTw@mail.gmail.com>
Content-Language: en-GB
From: Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAPc5daVJ-aj+xCdHesBr7VEeNmgvvaW8Tj=6PS419jYvSLfDTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/05/2024 16:32, Junio C Hamano wrote:
>> If you haven't already realised, the registration/subscription requests
>> go via 'majordomo' as detailed at:
> 
> Hasn't
> https://subspace.kernel.org/vger.kernel.org.html
> superseded that?
> 
> https://subspace.kernel.org/subscribing.html

I wasn't aware of that change. Thanks for the update. I've been
'off-line' for a while and had missed the few emails that mentioned it.
--
Philip
