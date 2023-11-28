Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pimpmybyte.de header.i=@pimpmybyte.de header.b="L5EHQhzw"
Received: from pimpmybyte.de (kalmar.hosting.pimpmybyte.de [212.227.234.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C892FD5D
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 21:55:42 -0800 (PST)
Received: from [127.0.0.1] (ip-176-199-210-019.um44.pools.vodafone-ip.de [176.199.210.19])
	by kalmar.hosting.pimpmybyte.de (Postfix) with ESMTPSA id 3B8377E90A;
	Tue, 28 Nov 2023 05:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimpmybyte.de;
	s=default; t=1701150941;
	bh=Sxx3o48yLMouXPLByXXIfJdIAxtMhkSgVxFl6ER2OBw=; h=Subject:To:From;
	b=L5EHQhzwr7ob7QenhxmoyAmtbkCgR5vPnfKPMD0ovylHIb5VnTjc8NK+F5ddYkDk0
	 wWH4+T9RCxMk1/KD8YG4z/M5YEoFJk2mNcH6yXlYSwl+//aoryRUeTpD/m4jbtpozC
	 q43tm113fqRozRM/o6PnLtl37TPr7HhvPlzd2Qxk=
Authentication-Results: kalmar.hosting.pimpmybyte.de;
        spf=pass (sender IP is 176.199.210.19) smtp.mailfrom=mk+copyleft@pimpmybyte.de smtp.helo=[127.0.0.1]
Received-SPF: pass (kalmar.hosting.pimpmybyte.de: connection is authenticated)
Subject: Re: [PATCH] doc: make the gitfile syntax easier to discover
To: git mailing list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Marcel Krause <mk+copyleft@pimpmybyte.de>
References: <20231124194711.563720-1-mk+copyleft@pimpmybyte.de>
 <xmqqr0kd5i66.fsf@gitster.g>
 <70125a8e-57ed-2ac6-1260-2aaa10cbc851@pimpmybyte.de>
From: Marcel Krause <mk+copyleft@pimpmybyte.de>
Message-ID: <182d290a-86e5-b361-87a1-6860641fc726@pimpmybyte.de>
Date: Tue, 28 Nov 2023 06:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <70125a8e-57ed-2ac6-1260-2aaa10cbc851@pimpmybyte.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Sorry for being slow on understanding your "git worktree add" hint.
I agree that discoverability of that command is at least as important
as discoverability of the syntax. I'll add a line about that, too.
