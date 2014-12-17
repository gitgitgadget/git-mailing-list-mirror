From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Improving git branch
Date: Wed, 17 Dec 2014 13:23:11 +0100
Message-ID: <549175AF.7070803@drmicha.warpmail.net>
References: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com> <549168DD.1080906@drmicha.warpmail.net> <CAHQ6N+pjT9zCdbvjJnFTmJEM=btjDxn8LTRV-j1vbqGfqwks5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:23:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1DdO-0001Gb-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 13:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbaLQMXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 07:23:14 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35870 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750953AbaLQMXN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2014 07:23:13 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D061C200D3
	for <git@vger.kernel.org>; Wed, 17 Dec 2014 07:23:12 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 17 Dec 2014 07:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=QMg0VdPrXsMCYnlPgybGeK
	EZLvg=; b=GRnN1eKQ4GjM0tnO0lBrxOXPRw4N/IPVROpk6DocAEFqDLIxvcZLrm
	wEn3TlK8C/kW+K5DCEz1yVVkRXckA2WrMI/8b4QmaMU3hNWtW+XzsFvSTZ/1Vk7F
	9n31hORT7fv4GOrlIXHJxpX6EwWl4OPdbFHm3oejJreCQlwoDB6mI=
X-Sasl-enc: D5W4xTlqGIIu4q28QiAYVrkQzxSOk/F2cv3Jjaw9K6QH 1418818992
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5AD756800DB;
	Wed, 17 Dec 2014 07:23:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAHQ6N+pjT9zCdbvjJnFTmJEM=btjDxn8LTRV-j1vbqGfqwks5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261482>

Also, please don't top-post here.

That would allow everyone to get their favourite listing, just like for
logs.

John Tapsell schrieb am 17.12.2014 um 12:51:
> I don't fully understand - if I did that, then what difference would
> an average user actually see?
> 
> On 17 December 2014 at 11:28, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> John Tapsell schrieb am 17.12.2014 um 12:10:
>>> Hi all,
>>>
>>>   I'm interested in putting in some time and effort into improving the
>>> output of "git branch".
>>>
>>>   What I'm thinking is an output like this:
>>>
>>> $ git branch
>>>
>>> 2014-12-17 * (detached from origin/master)     deaba04 Do stuff
>>> 2014-12-15   john.ta/add_timing_info                6edbcfa  Add timing stuff
>>> 2014-12-14   master                                          8537316
>>> [origin/master: ahead 1, behind 16] Some stuff
>>> 2014-12-12   john.ta/new_reduce_memory       99d84db Reintroduce: memory stuff
>>> 2014-12-05   john.ta/bugfixes                            e15c95e Add stuff
>>> 2014-12-03   john.ta/container                           e9fd4e5 This
>>> branch is a test bed for containers
>>>
>>>
>>> (These columns are supposed to be all aligned nicely..)
>>>
>>> So, features:
>>>
>>> 1. Show the date of the last commit
>>> 2. Sort by date.  Most recently used branches at the top
>>> 3. Show the branch name, including your current "branch", with a * to
>>> indicate that it's checked out.
>>> 4. Show the sha
>>> 5. Show the branch DESCRIPTION - and if that's not available, show the
>>> short-line of the most recent commit.
>>>
>>> There is also a small amount of color here that I can't paste here, to
>>> follow the coloring in the current git branch.
>>>
>>> Before I start making patches etc, what do people think?  Would I have
>>> a chance of getting this in?  Should I change some aspects etc?
>>>
>>> Thanks,
>>>
>>> John Tapsell
>>>
>>
>> I support the general goal, we have quite some way to go there.
>>
>> As to the method: "git branch" in list mode, "git tag" in list mode and
>> "git for-each-ref" all do similar things and are in turn not dissimilar
>> from "git log --no-walk" with appropriate formatting and rev options.
>>
>> Rather than extending "git branch" any further[*], I suggest a bolder
>> strategy:
>>
>> - unify/merge for-each-ref and pretty formats (and code) as far as possible
>> - leverage that for the list modes of branch and tag
>>
>> That would allow everyone to get their favourite listing, just like for
>> logs. Otherwise it would be very difficult to agree on *the* proper
>> format for an extended branch or tag list.
>>
>> Michael
>>
>>
>> [*] I know I'm a sinner, too.
