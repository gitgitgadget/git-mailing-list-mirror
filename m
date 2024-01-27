Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A71E52F
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373107; cv=none; b=sgI9gP6SB3Jm1+nZXw2yjVhtsG04+zGpMaORfKWX1H/edGc5d5cFhiT1QkXQnCIRvai0P50/rU+YFziQ16f8kWig1yyHcQE4jpcfX8RmP/SP00/VlJOIffO2DahdCOpU4NZ/FFesg04kqgRHJJfOzJz4vrGPwW79RspwDCNmWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373107; c=relaxed/simple;
	bh=ntsk+YRUtFRVPTuXB3oSz+Jx96QdnYGWPPZWUdZpBXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dfxaKOy24f6+811/fGlWLOErLn9jftpJ7EKse4Awy661+6JMpIyQMk+DEhWNYno/FEfkHIsca6+p/Zt/6llUgt6sZvtRMYOoK5hX4ek+vynmmtx/U2dTJmZ5Gsh9EBUzg59CtSWqgvfl5BniqODcwk4GmnUxMnbmno/Nw4PLqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1rTlan-000000001GF-1Naf
	for git@vger.kernel.org;
	Sat, 27 Jan 2024 17:31:41 +0100
Received: from [10.20.10.231] (port=42688 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1rTlam-00FbDd-0W;
	Sat, 27 Jan 2024 17:31:40 +0100
Message-ID: <c1c041f7-e388-4451-8573-547a2cad9f8c@drbeat.li>
Date: Sat, 27 Jan 2024 17:31:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add two steps
Content-Language: de-CH
To: Johannes <johannes@king.ma>, git@vger.kernel.org
References: <66e4baf4-439a-4a1b-ba95-1f9ed222d42a@king.ma>
 <a420cdc5-8294-4ffb-9f6c-06e1416ada43@drbeat.li>
 <e64ea18e-a733-4a01-af1e-22a7f9d974dd@king.ma>
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <e64ea18e-a733-4a01-af1e-22a7f9d974dd@king.ma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 27.01.24 16:27, Johannes wrote:

Hi Johannes,

> On 27/01/2024 13:23, Beat Bolli wrote:
>> On 27.01.24 10:43, Johannes Kingma wrote:
>>> For git to work at least a user.name and user.email globals are 
>>> needed. would it make sense to include this in the installation process?
>>>
>>
>> The Git projects only distributes source code, so there's no 
>> installation process as such that could be improved. > I'm talking about installing git from git-scm.org. That _is_ a
> software that is installed.
None of these installers are created by the Git project itself. What 
operating system are you installing on?
-- 
Cheers, Beat

