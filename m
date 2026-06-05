Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9B40313D
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641833; cv=none; b=OxiPgEikKnnt8QcbLSu1uoMLgGZxW0WoSLPhiiMoqT3fbjWIJrnUEXJGG2BRxZwY671Ml8XdMOemmatbTr7R0wKkl2CDAzqiRvO1iATbOp5SHrcKzhOKgeYCiqF0M7h+eJSdUZ76o+LvhVkFjBw1mEhQIWRwSZZkS5Zwxgdpfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641833; c=relaxed/simple;
	bh=B7a7ifP7B1UJ8qSMxXPatTEREOTu/uc0q0VdMWNBr3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/odC/iHUb5EuuivUgbnc+oNaqeVrpZNToBz0bnVo66NTCKj09dgLjj3APqDCDl0BtOWoYv7sLR3nLDq55f2v/4nzBaCLYv2qFXnQdF7FeVW1z4wea4GzyWbxIWGNYBIIJ5K/STMWpQTAI7biU/3xdZiyxyLJ8f2Foxm4lekFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=HH4XRKsA; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="HH4XRKsA"
Date: Fri, 5 Jun 2026 14:43:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780641829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B7a7ifP7B1UJ8qSMxXPatTEREOTu/uc0q0VdMWNBr3A=;
	b=HH4XRKsA6H3NtfNCkYNbw8ZGPOMZtA58wLOm9oPPaoYzmgd1sh6IlEawO+qXFxEsHcbttq
	9O5/qU8E4967A+7+oQzyI/IpUdPft7Du+R9Vt+CfS1KMS/++taDIVcM/BIq428wBeWO8FB
	8iWJd4C7gK7in6Oz1hXiSt23qs6XVOctc8Fl40sOW9RGkAwPc4yCnL4j1gPHUSf6cDIDPC
	nKhXpDSCofw6k0oAvkxdDoNsFwoc1z374xuOQGZBiq6Chmktm2JL6hvu50gRIDCB7+hZ+Z
	i89q+qnV/kt416VWIrdfUbkEMihFpBVL1HgnAbtF2tbCcBskBYpfOkYa6+bJXQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Debaashish Nandi <debaashish@mailo.com>
Cc: git@vger.kernel.org
Subject: Re: Message from Debaashish Nandi
Message-ID: <aiJwD6xBtzx7clM_@wyuan.org>
References: <fcb34925-f10c-4fc4-826d-a55217101ec8@localhost>
 <fcb34925-f10c-4fc4-826d-a55217101ec8@localhost>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb34925-f10c-4fc4-826d-a55217101ec8@localhost>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 04, 2026 at 06:37:12PM +0000, Debaashish Nandi wrote:
> Hello, is there any game playing which l can understand how git works ?

You may try this:

https://learngitbranching.js.org/

source code:
https://github.com/pcottle/learnGitBranching
