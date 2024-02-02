Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E024776F
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896250; cv=none; b=J3iF9d2gNx13fqHcxzGcIo+5jpSvaSj+pqs6s6hq30JQxxtS5OGwwcH6KFRLANZtXG2IqytKODpXaERSW72oTTDSIoAMw4fNVWi4TQVJbdFRu+VxMBS1HV2gAYmyM5jP1x5GwevTWMfPfNvTWuJASKJhohXNUCLAR67lDgY5Nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896250; c=relaxed/simple;
	bh=zbJe+z17ATOCBfFR1SF55y8ZUMyYbX5JyNZbPxg5zBE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wi4bz7kagKsjSuba8znBD1WKzKFwTC2vBHHYOo/YdihY43XEbpe+KGdj8hdJxqOp3cXC1wcvVSJVKao2BubvUrYB0sZHesj90ed6ZQdvMno5gJ4eyQIphMumIHMDHfi7r55XoH8yLxgTUPIe+9PChVmfgD56uQ5SE1YiFxk8liU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 412Hohba1734776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 17:50:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>	<AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>	<877cjm53bf.fsf@osv.gnss.ru>	<008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>	<xmqqcytevmwq.fsf@gitster.g>	<009601da55fa$1ecc9580$5c65c080$@nexbridge.com> <xmqq1q9uu5nc.fsf@gitster.g>
In-Reply-To: <xmqq1q9uu5nc.fsf@gitster.g>
Subject: RE: Migrate away from vger to GitHub or (on-premise) GitLab?
Date: Fri, 2 Feb 2024 12:50:36 -0500
Organization: Nexbridge Inc.
Message-ID: <00a201da5600$574b1ca0$05e155e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMTzlW4975feouBsT254Lv1BIoWdQGhQd7aAcbbN+4BmxetWgFZgewTAdVh0I0Bcdvdpa43RDXQ
Content-Language: en-ca

On Friday, February 2, 2024 12:40 PM, Junio wrote:
>To: rsbecker@nexbridge.com
>Cc: git@vger.kernel.org
>Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
><rsbecker@nexbridge.com> writes:
>
>> I should have qualified this with "free" NNTP. I have only been able
>> to find for fee NNTP servers where I am. The search continues.
>
>The NNTP server "nntp.lore.kernel.org" carries the mailing list served by
>lore.kernel.org archives, including this list.

Thanks. This is sufficient for git. Appreciate it.

