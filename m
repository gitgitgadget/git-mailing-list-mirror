From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: set-upstream for existing branch...?
Date: Thu, 17 Feb 2011 10:41:06 +0100
Message-ID: <4D5CED32.3030507@drmicha.warpmail.net>
References: <buoei77xmpc.fsf@dhlpc061.dev.necel.com> <AANLkTikqj8NjLwR647E1tHUuDO=OitUJ1dm5Fs7gtXXt@mail.gmail.com> <buo8vxfxhhy.fsf@dhlpc061.dev.necel.com> <AANLkTim6HDCaeTDuEtK+3niKKoz6A3KA=m=UCr4DaY-V@mail.gmail.com> <4D5CDB01.9070502@drmicha.warpmail.net> <AANLkTimPYkEczv=suCr02rVb3OSg_h9o88_5CEmonPTR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 10:44:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq0PM-0004JR-I4
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 10:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab1BQJoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 04:44:15 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57908 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752447Ab1BQJoN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 04:44:13 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5DC15205DF;
	Thu, 17 Feb 2011 04:44:13 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 17 Feb 2011 04:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=HhkKcx55KPl3IGODfv+HyURplB4=; b=ZIOdaitfUvW5KjzNhW+ixJaBJ/QM2CFay+lrCDRhrmojomxTyJ8V/N3uzELcEk89LM0y4sh3mhHErgup9Q6dlPc5l14/TtRvwSV9Su7bo8ka1rRJdiqHStdmXH8Z822nn+XB/c5iA+gJLVwsTknvsC5GrmhiJisHd4of0uZD+lQ=
X-Sasl-enc: t2u5rapGqY609z0KEZdv33+O30vCES0w5GYC8OhjvUpy 1297935853
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A25DC408B99;
	Thu, 17 Feb 2011 04:44:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTimPYkEczv=suCr02rVb3OSg_h9o88_5CEmonPTR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167060>

knittl venit, vidit, dixit 17.02.2011 10:25:
> On Thu, Feb 17, 2011 at 9:23 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Miles Bader venit, vidit, dixit 17.02.2011 08:24:
>>> Hmm, on a related note, is there an obvious way to _show_ the current
>>> branch's upstream...?
>>>
>>> [I mean, which just prints out "origin/master" or whatever...]
>>>
>>> Thanks,
>>>
>>> -miles
>>>
>>
>> git for-each-ref --format="%(upstream)" $(git symbolic-ref HEAD)
>>
>> I can't come up with a better way of expanding @{u} without resolving
>> the resulting refname to a SHA1. You could do
> 
> what about
> 
>     git branch -vv
> 
> it will show all local branches with their upstream plus behind/ahead numbers

That's a very nice and useful output, but my impression was that Miles
was more interested in one branch (the current one), and I think Jay
gave the most direct solution. While it does go through the
resolve-describe-circle (compared to for-each-ref) it should still be
efficient.

Michael
