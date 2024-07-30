Received: from rush.cubic.ch (rush.cubic.ch [176.9.78.115])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EB18CC1C
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370497; cv=none; b=tkEzJIZa4gQgygieix+Er7KV5Ym4loOq9X78k5RUpLPtgnXt6zwd9DNDS6i+DHtqRxeIK+6nx64r09B/TBxULQruyVGXVEs0Kc5cC5iZI9Rhd5YO1o52XYsrnqvL3K1sIlUe+E2bSHexlo088EfjA35/bqt9ah57l1pp7nsZQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370497; c=relaxed/simple;
	bh=TZFek2ntOI1Aej77b+JrN/0V8NzC7JeVtuZG4mRW+SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g5y2lFQDZNnPhaJFOWWl0TREliAZxW99Ei8Gx49v0nSKeTg+EeBJe47F8ZeIKM5AwX3FODK4GWbO2ntLxIowLkS/Kn1AfxSJlU2QWyxf5g+ydJgSqy3OVby9rqsrRbGdobJzsmUTrkbtaYXc3kCvFK8H14ZJH5hlgeFBVEDucxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch; spf=pass smtp.mailfrom=decentral.ch; dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b=JAHAcglU; arc=none smtp.client-ip=176.9.78.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentral.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b="JAHAcglU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=decentral.ch; s=rsa2;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID; bh=2AO04xHbYT9Dg3bqOyvmhP+jxP5nCxBZWqW5WYWkAiQ=;
	b=JAHAcglU8w5CPXtEEov9IINJsm70a5L3JOhiwWBCRCzv4tx0WbnYKbFwkhzyAI2PrNIelqIe4UU4qQWhcnuKu++YgwS63Qa5kbPRN//tdxCyyIl6tLSVd4tuZOwB868VFVYVuMZMtjjSxYCNHZTBe+1oEL4A2Mfm/t2YgjpcN/17VQRVs5ixwhTzfvFBUNeyDRMIWlzc2I2Y5550BF4/agCpw/noJcGwYLkUD+9tQ3pBBY8SuX9pF/CmveSs4l61K8qp90U0k89uxa57XCIU2wWmsnPOhFlhL0d6/jbgKU+84d6cjZQK8BGjSg4EQQ6MgOfOQ3n7xsfkYgz0pw+0Gg==;
Received: from james.decentral.ch ([85.195.242.225] helo=[192.168.219.103])
	by rush.cubic.ch with esmtpa (Exim 4.76)
	(envelope-from <stuff@decentral.ch>)
	id 1sYsqI-0005CL-HJ; Tue, 30 Jul 2024 21:49:06 +0200
Message-ID: <8405597b-ea80-45c6-b370-fbea2876a9d8@decentral.ch>
Date: Tue, 30 Jul 2024 21:49:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GIT by github 2.45.2 is listed on Software Informer
To: Informer Team <partners@informer.com>, git@vger.kernel.org
References: <739497c1eefa2c4d99e7ee30393a6e21@software.informer.com>
Content-Language: en-US
From: Tim Tassonis <stuff@decentral.ch>
In-Reply-To: <739497c1eefa2c4d99e7ee30393a6e21@software.informer.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/30/24 12:04, Informer Team wrote:
> Good day!
> 
>   would like to inform you that your product GIT by github 2.45.2 is now listed on our web site and your program got "100% Clean Award" https://git.software.informer.com/.
> 
> We would be grateful if you place our award with a link to our review on your website. On our part, we can offer featuring your program in our Today's Highlight block. This block is shown in the rotator at the top of the main page and also on every page of our website in the upper left corner.
> 
> You are welcome to order a free video tutorial for your program as well. Once it's finished, you can add it to your website.
> 
> We also offer you to take advantage of our free storage by hosting your installation package on our servers and listing us as one of the mirror downloads for your program. There is a selection of predesigned buttons available to fit the look of your website.
> 
> Please let me know if you're interested in any of these offers.
> 
> We are on the list of the world's 1000 most visited websites, so this could get your program some extra exposure.



Yeah, I bet git is desperate need of some extra exposure!

Next year they might give the "100% Clean Award" maybe to the LINUX 
KERNEL or GREP.

Tim
