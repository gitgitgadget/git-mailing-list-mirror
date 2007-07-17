From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: I never want to push a given change
Date: Mon, 16 Jul 2007 23:12:53 -0400
Message-ID: <76ACB85D-2969-406A-AA11-EAF2A104B9E7@silverinsanity.com>
References: <916b88c10707160918n7a4948g5fb55a9d8ace9833@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: nathan bullock <nathanbullock@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAdUi-00084V-G0
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 05:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbXGQDM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 23:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756011AbXGQDM4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 23:12:56 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41410 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbXGQDMz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 23:12:55 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id CFF2E1FFC243;
	Tue, 17 Jul 2007 03:12:54 +0000 (UTC)
In-Reply-To: <916b88c10707160918n7a4948g5fb55a9d8ace9833@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52734>


On Jul 16, 2007, at 12:18 PM, nathan bullock wrote:

> I have been using git for a little while and one thing that I would  
> like to
> be able to do is never push a given change, or set of changes.
>
> So lets say I clone a .git repository. Then I make a couple of changes
> that I don't want anyone else to see, do a commit. Then I make some
> other changes that I want everyone else to see and do another commit.
>
> How do I push just the second commit?
> And how do I make it so that every other time I do a push after  
> this that
> first commit will never be sent?

Generally the way I do such things is multiple branches.  Have a  
branch "local" (or a more descriptive name) that isn't pushed out  
anywhere.  Place any changes you do NOT want shared on that brach.   
Place changes to be shared on the master or appropriate topic  
branch.  Instead of committing changes to be shared on top of the  
local ones, use "git rebase" to keep the local branch on top of the  
shared ones.

~~ B
