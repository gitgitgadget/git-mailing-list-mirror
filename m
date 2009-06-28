From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git remote rm non-existant-remote
Date: Sun, 28 Jun 2009 19:04:17 -0400
Message-ID: <C1DD7597-AAFF-4F79-B11C-4D6BE9EB2601@silverinsanity.com>
References: <540FF00B-9DE7-4C89-9EC3-264B5BDD9CDE@silverinsanity.com> <20090628161141.GA7796@sigio.peff.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 29 01:04:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML3QG-0005TM-Q0
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 01:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbZF1XEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 19:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbZF1XEW
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 19:04:22 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51639 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZF1XEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 19:04:22 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 21D511FFC03D; Sun, 28 Jun 2009 23:04:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.3] (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E91D41FFC001;
	Sun, 28 Jun 2009 23:04:09 +0000 (UTC)
In-Reply-To: <20090628161141.GA7796@sigio.peff.net>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122427>


On Jun 28, 2009, at 12:11 PM, Jeff King wrote:

> On Sun, Jun 28, 2009 at 10:47:23AM -0400, Brian Gernhardt wrote:
>
>> I was working on updating the remotes for one of my repositories
>> (adding a variety of forks) and renamed the origin branch.  When I
>> was done, I tried to use "git remote rm origin" to remove the
>> branches for the now dead origin.  What git-remote did was remove all
>> of my remotes and the merge information for my master branch (which
>> was moved off the origin remote).
>>
>> This is a data loss bug.  Very bad.  `git remote rm` should either
>> refuse to remove a non-existent remote or (preferably) simply remove
>> any branches that exist for that remote.
>
> Ouch. That is indeed a serious bug. However, I can't reproduce with
> current 'next'; which version of git are you using?

git version 1.6.3.3.467.g98a79

I believe that's the latest "next".

~~ Brian
