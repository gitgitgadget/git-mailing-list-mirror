From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Thu, 15 Nov 2007 11:04:41 -0500
Message-ID: <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:06:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IshDF-0003wp-Sy
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 17:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609AbXKOQEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 11:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757091AbXKOQEt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 11:04:49 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:60899 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbXKOQEs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 11:04:48 -0500
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 443FC1FFC23A;
	Thu, 15 Nov 2007 16:04:46 +0000 (UTC)
In-Reply-To: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65131>


On Nov 15, 2007, at 8:46 AM, Wincent Colaiuta wrote:

> Was just running the test suite against the master branch and saw  
> that t9101 is currently failing on Leopard, and a review with git- 
> bisect indicates that it has been ever since it was first introduced  
> (in commit 15153451). Not sure if this problem is Leopard-specific  
> or not as I only have one machine.

It is not a Leopard specific problem, as far as I can tell.  I just  
ran the test and had no errors on my Leopard machine.  So perhaps it's  
some other detail of your setup?

> I'm not a git-svn user myself, but if there's anything I can do to  
> help diagnose this problem further on Leopard please let me know.

I just tested it using svn from fink and (after discovering it exists)  
from Leopard.  No problems.  Do you have an old svn package (client,  
admin, or perl binding) installed from Darwin Ports or Fink perhaps?

~~ Brian
