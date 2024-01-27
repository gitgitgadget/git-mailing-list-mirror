Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03B847D
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706358399; cv=none; b=I8cKuHVxPYhBtyBFOFjz7EC+BrtKvqoDLJG0dpvFR8W5dL+wq9NUYn74M4G1eQ6swCpXXPpO0XTl2KNWJlo4ezUG7vvoPdaOgvsLjE9hae0vDGjywd5jEoCuqXQJKOpuBYvIl/cY29mg8Qp7b+ORDAOpAyeC8xthmdHKJWMJpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706358399; c=relaxed/simple;
	bh=U0nxEZcVRbnztD02cK8gj67cLhABNtF84HlxdJqXL9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qAFIcxmA71zBKxheGlM4NqlRyh/1Lhjy8p+5NgPCHQ/FCMcgSx8Tq/ntAO7loA3k38On4hfOKQK7ULexPkPwhq+F7mz4Cwki8R4UViDwGdHOx1j+cw4rW3dxAAACgu0TrTlcb98rx5XHI2+f7j7jvAP8xRn7aAG0Rwrx+S1RNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1rThiX-000000002oY-1NEN
	for git@vger.kernel.org;
	Sat, 27 Jan 2024 13:23:25 +0100
Received: from [10.20.10.231] (port=11108 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1rThiW-00E1ii-0X;
	Sat, 27 Jan 2024 13:23:24 +0100
Message-ID: <a420cdc5-8294-4ffb-9f6c-06e1416ada43@drbeat.li>
Date: Sat, 27 Jan 2024 13:23:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add two steps
Content-Language: de-CH
To: Johannes Kingma <johannes@king.ma>, git@vger.kernel.org
References: <66e4baf4-439a-4a1b-ba95-1f9ed222d42a@king.ma>
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <66e4baf4-439a-4a1b-ba95-1f9ed222d42a@king.ma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 27.01.24 10:43, Johannes Kingma wrote:
> For git to work at least a user.name and user.email globals are needed. 
> would it make sense to include this in the installation process?
> 

The Git projects only distributes source code, so there's no 
installation process as such that could be improved.
-- 
Cheers, Beat

