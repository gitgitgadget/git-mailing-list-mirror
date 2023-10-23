Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAD13AFF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E847B8E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:16:44 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 9678F242BF;
	Mon, 23 Oct 2023 14:16:42 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1quzTm-gJa-00; Mon, 23 Oct 2023 20:16:42 +0200
Date: Mon, 23 Oct 2023 20:16:42 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTa4iqe0lqn/Yg5L@ugly>
References: <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>

On Mon, Oct 23, 2023 at 10:30:54AM -0700, Jacob Stopak wrote:
>On Mon, Oct 23, 2023 at 04:34:15PM +0200, Dragan Simic wrote:
>> On 2023-10-23 12:52, Oswald Buddenhagen wrote:
>> > i for one think that it would be a perfectly valid experiment to go
>> > all-in and beyond with jacob's proposal - _and make it the default_
>> 
>> I'd never support that, FWIW.
>
>FWIW, I'd _never suggest_ that.
>
why, though?
doing that would extend the feature's reach about two orders of 
magnitude among newbies, which is where it matters most.

>I very much value Git's current usage and wouldn't dream to make this 
>the default.
>
making the default output format somewhat more verbose wouldn't really 
"change the usage", though. and being able to permanently get rid of it 
with a single command should alleviate any _reasonable_ concerns about 
habit disruption.

regards
