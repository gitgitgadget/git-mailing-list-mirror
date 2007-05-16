From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Opinions on bug fix organisation
Date: Wed, 16 May 2007 10:46:00 -0400
Message-ID: <5C14809D-14D9-4FC9-B8D5-FDBFDA89A369@silverinsanity.com>
References: <200705161138.30134.andyparkins@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 16:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoKlZ-0005yj-TE
	for gcvg-git@gmane.org; Wed, 16 May 2007 16:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbXEPOqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 10:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbXEPOqG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 10:46:06 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:40161 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043AbXEPOqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 10:46:05 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 5D6AF1FFC01F;
	Wed, 16 May 2007 14:46:04 +0000 (UTC)
In-Reply-To: <200705161138.30134.andyparkins@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47441>


On May 16, 2007, at 6:38 AM, Andy Parkins wrote:

> That is - just commit a fix or, commit the fix, "F", directly on  
> "B" then
> merge that fix back to HEAD with "M".
>
> I quite like option 2 because it records intent - i.e. "I wish I  
> could have
> gone back and changed this revision, but I can't", but it makes a more
> complicated history.
>
> What do people think?

I just encountered this myself with one of my repos.  I'm developing  
solo so I could just rebase if I felt like it, but don't like  
developing that habit, so I'm probably going with the second one.   
But that's because of how I'm developing it.  My master has undergone  
serious changes recently (since the bug commit), so I'm going back  
and checking out the bug commit to focus on that issue without  
anything else that's been changed since then.

My personal feeling is that the commit should reflect how the fix was  
developed.  If it's simple fix that you simply wrote on top of the  
full branch, commit it that way.  If you had to (or wanted to) go  
back and develop on top of the original commit, commit it that way.   
Usually I'll just commit on top of master, but if either I need to  
remove other complications from the fix or need to introduce the fix  
(but not everything else) into multiple branches, I'll do the merge.

~~ Brian
