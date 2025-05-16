Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374017E4
	for <git@vger.kernel.org>; Fri, 16 May 2025 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417537; cv=none; b=AKl7yUWH2q96myoAyVLfjYG9iSA+LprHJy8IiHX9FqFnFLOrXEK5LKitETqRW3D8TLfDAL1n2LJ1am1RL3wcQoWY2wSqzPVrsGdcjWVv76/gjq/5rtm60PJ+Mb1sDgHKYN9QqyLkIZGEdk50xEPMqJMudL+zQNUHdAVswY8e7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417537; c=relaxed/simple;
	bh=/hAXDkpzPs4IoMIlfj/O+FySvHXFPJNJ2dzqZwxT+p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2DDiIChMdMYDRbdkebbS2BS6PRYpvADH1zrEr5f14BtTBvTwK/XyqTUhjIyZStaseTQMG4xiOUiJUzVgcqErt0tm9Ytu/4d1QKMfKgTslxlYR6HgtN/PeC4bky9s0xG75JarW/AhqLCebVAtFQgqy3beqvvx5Z9vFGans+n32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4ZzZHJ3MDszRnlJ;
	Fri, 16 May 2025 19:45:32 +0200 (CEST)
Message-ID: <a72235c1-625a-4b90-8111-629b5a6ee7c2@kdbg.org>
Date: Fri, 16 May 2025 19:45:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] userdiff: extend Bash pattern to cover more shell
 function forms
Content-Language: en-US
To: Moumita <dhar61595@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20250511141101.18450-1-dhar61595@gmail.com>
 <20250516144515.49514-1-dhar61595@gmail.com>
 <20250516144515.49514-2-dhar61595@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250516144515.49514-2-dhar61595@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All my comments have been addressed and this round looks good. Thank you!

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

