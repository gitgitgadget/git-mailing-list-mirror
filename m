Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EAF26E3C
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75511189
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:34:12 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 5199024051;
	Thu, 26 Oct 2023 04:34:11 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvvog-IRm-00; Thu, 26 Oct 2023 10:34:10 +0200
Date: Thu, 26 Oct 2023 10:34:10 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: group installation of Docker dependencies
Message-ID: <ZTokgo1mQ7ZVH7GU@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <a65d235dd3c14df4945b9753507d9cdab777966c.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a65d235dd3c14df4945b9753507d9cdab777966c.1698305961.git.ps@pks.im>

On Thu, Oct 26, 2023 at 10:00:12AM +0200, Patrick Steinhardt wrote:
>Pull in "lib.sh" into "install-docker-dependencies.sh" such that we can
>set up proper groups for those dependencise. This allows the reader to
					  ^^ !!!
>collapse sections in the CI output on GitHub Actions (and later on on
>GitLab CI).
>
the structure of the text is kind of backwards - the fact that you need 
to pull in a lib is just a consequence, not the intent, which imo should 
come first. tough it mostly doesn't matter, as it's just one short 
paragraph.

regards
