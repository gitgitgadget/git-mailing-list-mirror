From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Opera release Git-splitter, a sub-modularizing tool for Git
Date: Fri, 21 Dec 2012 14:49:26 +0100
Message-ID: <50D468E6.2090900@drmicha.warpmail.net>
References: <op.wpiovoj5qrq7tp@acorna.invalid.invalid> <50D454D2.5030403@drmicha.warpmail.net> <op.wpn2xz07vqd7e2@damia.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yngve Nysaeter Pettersen <yngve@opera.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 14:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm2yv-0001BO-Ua
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 14:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab2LUNt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 08:49:29 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49799 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105Ab2LUNt1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 08:49:27 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 31EF620BC6;
	Fri, 21 Dec 2012 08:49:27 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 21 Dec 2012 08:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=jYThdbNG21ubFI6SLkp4TV
	tEXm0=; b=a8S2ZpeFUFyrcxa3oYmIXnd8twtH4ZAJeBhLD8SaINVc+480BspnN4
	oQ1Eo8BonX7Xzmjsao7RyOFvOW/KZXslxA1Lqewfoy5RuVSXhXxjfm2tmIw/V1zg
	EaCKwEtSL4P/ciXmXEltD8oGIyrAJ3gHLQQFlnUTD0Gs+uXri634M=
X-Sasl-enc: 6UXZH8YlV5o4OTSLQNKAdvLHrAULLjDqVt4FbDvArH4M 1356097766
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A63AA8E064D;
	Fri, 21 Dec 2012 08:49:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <op.wpn2xz07vqd7e2@damia.oslo.osa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211970>

Yngve Nysaeter Pettersen venit, vidit, dixit 21.12.2012 13:43:
> Hi,
> 
> On Fri, 21 Dec 2012 13:23:46 +0100, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> 
>> Yngve N. Pettersen (Developer Opera Software ASA) venit, vidit, dixit
>> 18.12.2012 15:51:
>>> Hello all,
>>>
>>> Today Opera Software released the "Git-splitter", a small tool for
>>> sub-modularizing code in a git repo, with complete commit history, under
>>> the Apache 2.0 license.
>>>
>>> It's functionality is similar to "git-subtree", but also include a  
>>> command
>>> for reversing the process.
>>
>> Is there something keeping you technically from adding a join command to
>> git-subtree?
> 
> Probably not, but within the process I was working I did not want to merge
> the branch with the recreated history for that path into the existing
> codebase (I don't like duplicate histories) so I used rebasing to move the
> new commits over, instead, and therefore did not need a join command.
> 
> Feel free to add a join command, if you want one.

Im sorry, but that was a total misunderstanding. You said git-splitter
is like git-subtree but adds a command for reversing the process. My
question was: What kept you from adding that to git-subtree (rather than
redoing stiff that git-subtree does)?

I just assumed that reversing the process of splitting must be joining.

It may very well be that git-splitter does things differently, i.e. that
there are more differences than just added functionality (compared to
git-subtree), but that is not clear from the announcement.

>>> The code is hosted on GitHub:
>>> <https://github.com/operasoftware/git-splitter>
>>>
>>> We have announced the release as part of another announcement of  
>>> released
>>> code at the Opera Security Group home page:
>>> <http://my.opera.com/securitygroup/blog/2012/12/18/tls-prober-source-released-under-apache-2-0-license>
>>>
> 
> 
