Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60BC123
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B75B8
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:26:09 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 5780A20391;
	Thu, 26 Oct 2023 04:26:08 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvvgt-IPi-00; Thu, 26 Oct 2023 10:26:07 +0200
Date: Thu, 26 Oct 2023 10:26:07 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] ci: reorder definitions for grouping functions
Message-ID: <ZToin/fQiZrmUJTS@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <586a8d1003b6559177d238ceda2c6ef2f16cfb8d.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <586a8d1003b6559177d238ceda2c6ef2f16cfb8d.1698305961.git.ps@pks.im>

On Thu, Oct 26, 2023 at 10:00:03AM +0200, Patrick Steinhardt wrote:
> [...]
>_not_ being GitLab Actions, where we define the non-stub logic in the
>
you meant GitHub here.

>else branch.
>
>Reorder the definitions such that we explicitly handle GitHub Actions.
>
i'd say something like "the conditional branches". imo that makes it 
clearer that you're actually talking about code, not some markup or 
whatever.
for that matter, this is my overall impression of the commit message - 
it seems way too detached from the near-trivial fact that you're just 
slightly adjusting the code structure to make it easier to implement a 
cascade (aka a switch).

regards
