From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git rebase: unexpected conflict
Date: Sun, 4 Feb 2007 22:53:41 +0200
Message-ID: <20070204205341.GD29029@mellanox.co.il>
References: <eq5cc6$al2$1@sea.gmane.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 21:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDoMT-0007AD-4z
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 21:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbXBDUxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 15:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbXBDUxP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 15:53:15 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:56927 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbXBDUxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 15:53:14 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id ab746c54.2680806320.23132.00-001.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 04 Feb 2007 13:53:14 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 4 Feb 2007 22:55:16 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun,  4 Feb 2007 22:53:10 +0200
Content-Disposition: inline
In-Reply-To: <eq5cc6$al2$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 04 Feb 2007 20:55:16.0846 (UTC) FILETIME=[C61228E0:01C7489E]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14974.000
X-TM-AS-Result: No--6.318100-4.000000-31
X-Spam: [F=0.0116652951; S=0.011(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38708>

> Quoting Jakub Narebski <jnareb@gmail.com>:
> Subject: Re: git rebase: unexpected conflict
> 
> Michael S. Tsirkin wrote:
> 
> > git rebase seems to see conflicts where there shouldn't be any.
> 
> Were you on a branch that you wanted to rebase?

Yes: I did not specify the <branch> parameter at all.
However note that there were merges since the commit
that I wanted to skip.

> I had made this error once.
> git rebase --onto <newbase> <upstream> <branch> moves <upstream>..<branch>
> into <newbase>.

I really just did
git-rebase --onto $1~1 $1

and the commit I gave 9b3bfe5696aa417d38ce903eb345a03d65743dd2
actually as a parent of the current branch.


-- 
MST
