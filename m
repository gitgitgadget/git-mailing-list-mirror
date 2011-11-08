From: Sven Bachmann <dev@mcbachmann.de>
Subject: How to resolve git stash conflict without adding to index?
Date: Tue, 08 Nov 2011 10:10:04 +0100
Message-ID: <20111108101004.Horde.46VbWsL8999OuPHsJOQ2ZrA@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 10:16:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNhna-0007oQ-O0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 10:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1KHJQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 04:16:50 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:58458 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab1KHJQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 04:16:47 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Nov 2011 04:16:47 EST
Received: from [80.67.16.117] (helo=webmailfront01.ispgateway.de)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dev@mcbachmann.de>)
	id 1RNhgy-0002x7-5m
	for git@vger.kernel.org; Tue, 08 Nov 2011 10:10:04 +0100
Received: from business-178-015-016-250.static.arcor-ip.net
 (business-178-015-016-250.static.arcor-ip.net [178.15.16.250]) by
 webmail.df.eu (Horde Framework) with HTTP; Tue, 08 Nov 2011 10:10:04 +0100
User-Agent: Internet Messaging Program (IMP) H4 (5.0.14)
Content-Disposition: inline
X-Df-Sender: c3ZlbkBtY2JhY2htYW5uLmRl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185080>


Hi Git-Group,

from time to time I've got to "git stash" a bunch of files (about 20).
My problem is, sometimes "git stash pop" conflicts and all files are  
added to the index - which is not what I want.

I just want to have the same behavior like "git stash pop" without  
conflict has. Resolving the conflict is okay, but not "git reset HEAD"  
to all other files, which I don't want to commit now.

Is there a possibility that "git stash pop" does not add all files to  
the index when a conflict appears?

I've already asked this question on stackoverflow (  
http://stackoverflow.com/questions/7751555/how-to-resolve-git-stash-conflict-without-commit ) - maybe this helps a bit better to describe the  
problem.

Please add me to CC if possible as I'm not subscribed to this list and  
reading it in the browser.

Thanks a lot in advance!
   Sven
