Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="fRZ+9Og0"
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC710D0
	for <git@vger.kernel.org>; Fri,  1 Dec 2023 13:24:24 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C907C1F406;
	Fri,  1 Dec 2023 21:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1701465863;
	bh=E44NJtJkKSotpaDahX8VV3TU8x4LQHskdyq2uzHGGHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRZ+9Og08bZDyGQ3uvZR4L3LKpCSBdJJ9fOaZeVRKtcJXo8/uxRv25R/9A7V5JQEe
	 VKlYUdRSqMHT+zF065JOZwX+5LWkdOWvEB8T/vnlwKX2vygE+0/7HjVktzyO431tOT
	 y+o6WIClFmwSv/1fM7+EvpsTDj3o3EJOA4A3G8lM=
Date: Fri, 1 Dec 2023 21:24:23 +0000
From: Eric Wong <e@80x24.org>
To: Jonny Grant <jg@jguk.org>
Cc: git@vger.kernel.org
Subject: Re: git:// warn as connection not secure
Message-ID: <20231201212423.M738201@dcvr>
References: <b6e0f49a-34ff-4e8e-9c3e-b8fd41d59f68@jguk.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6e0f49a-34ff-4e8e-9c3e-b8fd41d59f68@jguk.org>

Jonny Grant <jg@jguk.org> wrote:
> Hello
> May I ask if anyone has suggested adding a default warning that git:// is not a secure connection?
> 
> ie "warning: git:// is not a secure connection. https and ssh are secure."

To be accurate, that would need an exclusion list of hosts behind
already-encrypted and trusted networks.  So stuff like .onion hostnames
for Tor, and a user-configurable list of hosts in a private LAN/VPN.
