From: David Watson <dwatson@mimvista.com>
Subject: Any way to ignore a change to a tracked file when committing/merging?
Date: Wed, 13 Jun 2007 11:47:33 -0400
Message-ID: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 18:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVNF-0006n9-1N
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbXFMQHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758212AbXFMQHH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:07:07 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:39824
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757016AbXFMQHG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 12:07:06 -0400
X-Greylist: delayed 1145 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2007 12:07:05 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 82DFC5213D
	for <git@vger.kernel.org>; Wed, 13 Jun 2007 11:41:18 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Status: No, score=-4.29 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.109, BAYES_00=-2.599]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9xkgFcEAYf1 for <git@vger.kernel.org>;
	Wed, 13 Jun 2007 11:41:18 -0400 (EDT)
Received: from [10.0.10.104] (unknown [10.0.10.104])
	by zimbra.mimvista.com (Postfix) with ESMTP id 461AC51F8D
	for <git@vger.kernel.org>; Wed, 13 Jun 2007 11:41:18 -0400 (EDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50084>

I've got a problem, or maybe annoyance is more the proper term, that  
I haven't seen solved by any SCM system (at least not to my  
knowledge). Basically, I may make some changes, e.g. to a Makefile or  
somesuch, that I want to ignore when looking at what's changed from  
the repository. The only problem is, the file I've modified is  
already under version control, so .gitignore doesn't do anything.

Now, I can commit it, so it will stop bugging me, but then when I  
push out it will include that change, unless I back it out. This is a  
change that I don't want propagated anywhere else, because it's  
specific to my machine or development sandbox.

Is there any way to do this? I'd really love to use git-commit -a in  
this situation, and I could hack up a script to undo my change, run  
git-commit -a, and reapply the change, but makes me a bit squirmy. If  
I could put something in a .git config file to say "commit 237ab  
should not be propagated under any circumstances", that would be  
fantastic.

-Dave Watson
