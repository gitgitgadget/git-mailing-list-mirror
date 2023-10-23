Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485264B
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632F4D7C
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:47:43 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id CFA4024054;
	Mon, 23 Oct 2023 16:47:41 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qv1pt-jjy-00; Mon, 23 Oct 2023 22:47:41 +0200
Date: Mon, 23 Oct 2023 22:47:41 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTbb7bHkFOOyBT6+@ugly>
References: <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
 <xmqqfs21noxx.fsf@gitster.g>
 <18c7b1bea07d5f3878f4466b8e133da1@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <18c7b1bea07d5f3878f4466b8e133da1@manjaro.org>

>On 2023-10-23 21:01, Junio C Hamano wrote:
>> One thing that nobody seems to have raised that disturbs me is that
>> even though there may be educational value in having such a
>> "feature", having to carry the extra code to implement in Git incurs
>> extra cost.
>
that's the case for literally every feature. you're just noticing it  
here, because from your expert perspective it seems redundant with 
pre-existing functionality. so assuming that you actually care about 
newbie UX, you are at least not convinced that it would be a significant 
help.

i'm not totally convinced either, which is why i wrote of "valid 
experiment" upthread. but i don't think that measuring the actual impact 
is all that interesting unless the feature turns out to be actually 
excessively costly in the long run.

On Mon, Oct 23, 2023 at 09:04:49PM +0200, Dragan Simic wrote:
>That's exactly why I already wrote that the original author of the table 
>patches, if those would become accepted, should commit in advance to 
>maintaining that as the new git feature.
>
that's seems just a wee bit unfair (the bar isn't put that high for 
other features), and it's not realistically enforcable anyway.

regards
