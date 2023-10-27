Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F08489
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C00129
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 03:49:21 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 62FC023F67;
	Fri, 27 Oct 2023 06:49:19 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwKP1-bUg-00; Fri, 27 Oct 2023 12:49:19 +0200
Date: Fri, 27 Oct 2023 12:49:19 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Message-ID: <ZTuVr54KxhdaIf+F@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly>
 <ZTtyHScKkMg4qnMH@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZTtyHScKkMg4qnMH@tanuki>

On Fri, Oct 27, 2023 at 10:17:33AM +0200, Patrick Steinhardt wrote:
>On Thu, Oct 26, 2023 at 11:07:08AM +0200, Oswald Buddenhagen wrote:
>> you should probably choose a less generic name for the jobs, at least
>> debian-*.
>
>The names are all preexisting, so I cannot change them.
>
aren't they coming from the yml file? would adjusting them in the 
company setup be an unreasonable effort?

>I don't quite know what you mean by counter-intuitive patch structure.
>
it looked like you're adding the function to the github branch, not to 
the freshly added gitlab branch. of course that's just a diffing 
artifact.

regards
