From: Ari Entlich <atrigent@ccs.neu.edu>
Subject: git-svn: preserve commit dates?
Date: Wed, 24 Apr 2013 15:20:12 -0400 (EDT)
Message-ID: <6130153.1625671366831212710.JavaMail.root@zimbra>
References: <9803206.1625651366831179053.JavaMail.root@zimbra>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 24 21:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5h2-0006sP-HA
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544Ab3DXTtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:49:24 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:44669 "EHLO
	amber.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757514Ab3DXTtX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:49:23 -0400
X-Greylist: delayed 1746 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2013 15:49:23 EDT
Received: from zimbra.ccs.neu.edu ([129.10.116.59])
	by amber.ccs.neu.edu with esmtp (Exim 4.69)
	(envelope-from <atrigent@ccs.neu.edu>)
	id 1UV5En-0004oJ-IC
	for git@vger.kernel.org; Wed, 24 Apr 2013 15:20:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.ccs.neu.edu (Postfix) with ESMTP id 7EB48970032
	for <git@vger.kernel.org>; Wed, 24 Apr 2013 15:20:17 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zimbra.ccs.neu.edu
Received: from zimbra.ccs.neu.edu ([127.0.0.1])
	by localhost (zimbra.ccs.neu.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kXtPGztySDkQ for <git@vger.kernel.org>;
	Wed, 24 Apr 2013 15:20:12 -0400 (EDT)
Received: from zimbra.ccs.neu.edu (zimbra.ccs.neu.edu [129.10.116.59])
	by zimbra.ccs.neu.edu (Postfix) with ESMTP id C5F8B970028
	for <git@vger.kernel.org>; Wed, 24 Apr 2013 15:20:12 -0400 (EDT)
In-Reply-To: <9803206.1625651366831179053.JavaMail.root@zimbra>
X-Originating-IP: [67.189.145.86]
X-Mailer: Zimbra 5.0.22_GA_3210.UBUNTU6 (ZimbraWebClient - FF3.0 (Linux)/5.0.22_GA_3210.UBUNTU6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222310>

Hey all!

When I'm using git-svn, I'm always a bit dismayed that the dates in the git-svn commits are not copied from the original commits. They instead just contain the date of the dcommit. Note that I'm talking about the commits in my git repo here, not the ones in subversion - I know that those have to use the date of the dcommit.

I was looking a little bit at the perl code, and it looks like preserving the original commit dates wouldn't be particularly difficult. Does this seem like a good idea to anybody else? My guess is that none of the actual code is depending on those dates being anything in particular, but I suppose some people might prefer the current behaviour. Therefore, this could be switched on with --preserve-dates or something like that.

Thanks!

Ari
