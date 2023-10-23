Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6CA22EE7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E44D6E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:19:49 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B8E8523FE5;
	Mon, 23 Oct 2023 16:19:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qv1Ot-jTP-00; Mon, 23 Oct 2023 22:19:47 +0200
Date: Mon, 23 Oct 2023 22:19:47 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTbVY7Nf+DTYqHky@ugly>
References: <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
 <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io>

On Mon, Oct 23, 2023 at 12:29:12PM -0700, Jacob Stopak wrote:
>Those arrows showing how things move only really apply to "simulating"
>(dry runs) for specific commands like add, restore, rm, commit, stash,
>etc, so making the --table proposal a default status output would still
>miss those scenarios.
>
you're too focused on the status quo of your own tool. :-)
there is really nothing that would speak against the real commands 
reporting what they just *actually did*. this would seem rather helpful 
for noobs and other insecure users.
if one really wanted, "you can also use this with --dry-run" could be 
part of the hint that would say how to turn off the extra verbosity (or 
just the hint itself, if one likes the verbosity).

one could even go one step further and put at least the destructive 
commands into interactive/confirmation mode by default. but that's 
probably a bridge too far, as it would be potentially habit-forming in a 
bad way.

regards
