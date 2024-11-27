Received: from zucker.schokokeks.org (zucker.schokokeks.org [178.63.68.96])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AC11272A6
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.68.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694679; cv=none; b=bhZQ5S/cQaznVobmBTMjJO1Bkq52PRTgrvYuvyYgb3l6gSen84sZk4ZuCwm/URzoeG2ZXoTyf3iU4mjrYWYJQP+zHl09xe39d6ifnJkXPMrgFxAiqkWxNJWT/RSPwaTlj9uL/ukb5oAHCDvgV4qVIpzmnM9v99DjxPBr3JumaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694679; c=relaxed/simple;
	bh=BkhWW/5liWZZqk5KIQjgNhaWf08UbXuaEoxoYrCR+/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LUYMgQ+5CVXXqPCTpgJgqtgg9s72T42KdO9bc9W0Sh1egenvuAHuXuMSRDPR/NFbh1irBQsllFmQOrGJ7g9Hit/7XAfySH1m2D9yz3FvHthPggW3M9rrEoi3LHjrtRRRrRuqL9r9zEGlXwG7BdvtGAzcn2304zhZnozR5/2WaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=das-werkstatt.com; spf=fail smtp.mailfrom=das-werkstatt.com; arc=none smtp.client-ip=178.63.68.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=das-werkstatt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=das-werkstatt.com
Authentication-Results: zucker.schokokeks.org;
    dnswl=pass dns.zone=list.dnswl.org
    policy.ip=127.0.0.255
Message-ID: <7746de08-2c4e-48bb-0a5f-4e6412a1f643@das-werkstatt.com>
Date: Wed, 27 Nov 2024 08:59:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: git support for "xattrs" (extended filesystem attributes)?
To: git@vger.kernel.org
References: <5b4c09a9-64bb-e672-e604-120563fc1ad6@das-werkstatt.com>
 <Z0Z2DVuR2PiN-oxy@tapette.crustytoothpaste.net>
Content-Language: en-US
From: "Peter B." <pb@das-werkstatt.com>
In-Reply-To: <Z0Z2DVuR2PiN-oxy@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you everyone for your input!
This is very good now know.

I'll take a look at your suggestions, especially mtree and metastore, as 
they seem very useful in general.


Thanks and have a great day,
Peter
