From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 09 Sep 2011 10:06:08 +0200
Message-ID: <4E69C8F0.9070204@drmicha.warpmail.net>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com> <4E6769E3.4070003@drmicha.warpmail.net> <20110908191053.GA16064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kyle Neath <kneath@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 10:06:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1w6k-000845-6v
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 10:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758576Ab1IIIGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 04:06:35 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58150 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758461Ab1IIIGL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 04:06:11 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 969732ACC8;
	Fri,  9 Sep 2011 04:06:10 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 09 Sep 2011 04:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=RO6LGrvxmrsMjRfhIy5Kwq
	gVL0o=; b=tGI5o0hvqEfes8bbUma/xGrayxMHq7UYSXVmaUWmesbXb3UG/T0Gjg
	VHyU2pjEuaN1DCw4eIyyiHWos4gWFmhQeePjMO2DYkJCfbGDjmL/1q4AaOGO8uL6
	/M/DyJBe6WOpp5jxy003kd0ror7oUTbagbMcZDtDX/sMxEYygEfk0=
X-Sasl-enc: q8OH2cXpS1DdUAAbPx3GLTmESkl+5AFo7lfvpefEaRx2 1315555570
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D5CB0760270;
	Fri,  9 Sep 2011 04:06:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110908191053.GA16064@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181031>

Jeff King venit, vidit, dixit 08.09.2011 21:10:
> On Wed, Sep 07, 2011 at 02:56:03PM +0200, Michael J Gruber wrote:
> 
>> So, it's been a year or more that you've been aware of the importance
>> of this issue (from your/github's perspective), and we hear about it
>> now, at the end of the rc phase. I don't know whether
>> jk/http-auth-keyring has been done on github payroll or during spare
>> time.
> 
> To be absolutely clear here, this feature was 100% paid for by GitHub
> (which isn't to say that I don't think it's a good idea. On the
> contrary, I think it's awesome; but GitHub money is what provided the
> time for me to work on it).
> 
> When I started at GitHub in January, I was given a giant list of things
> that GitHub felt would make core git better, but that they hadn't the
> personnel to improve. And I was told to use my own judgement in adding
> or removing items from the list based on what I thought git needed, and
> to prioritize as I saw fit. The fact that it took six months for me to
> come up with credential patches is because that's how long it took me to
> figure out what I wanted to write, and to clear my backlog of other git
> tasks.
> 
> So I think the wheels have been turning on this for quite a while from
> GitHub's perspective.

Thanks for clarifying. While it should make no difference for the
acceptance of patches, it's great to see GitHub invest into scratching
their Git itches, and thus contribute back. That's how open source works
as a business model :)

...
> In the meantime, the best thing we can do to push it forward is to write
> helpers. I implemented some basic ones that should work anywhere, but
> aren't as nice as integration with existing keychains. Some people are
> working on Linux ones. The single best thing GitHub can do to push this
> forward right now is to provide a well-written OS X Keychain helper, and
> to provide feedback on whether git's end of the API is good enough.

... and one for Git on Windows? It seems we're lacking both Win and OS X
developers here.

... continuing in the other subthread...
