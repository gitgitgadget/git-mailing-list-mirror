From: "Steven A. Falco" <sfalco@harris.com>
Subject: cannot pread pack file
Date: Wed, 09 Dec 2009 11:25:37 -0500
Message-ID: <4B1FCF81.2010807@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 17:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIPfq-0005up-HP
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 17:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbZLIQpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 11:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbZLIQpq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 11:45:46 -0500
Received: from mlbe2k1.cs.myharris.net ([137.237.90.88]:49061 "EHLO
	mlbe2k1.cs.myharris.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbZLIQpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 11:45:45 -0500
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2009 11:45:45 EST
Received: from mail pickup service by mlbe2k1.cs.myharris.net with Microsoft SMTPSVC;
	 Wed, 9 Dec 2009 11:25:40 -0500
Received: from saf.cs.myharris.net ([137.237.94.251]) by mlbe2k1.cs.myharris.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 9 Dec 2009 11:25:38 -0500
User-Agent: Thunderbird 2.0.0.19 (X11/20090107)
X-OriginalArrivalTime: 09 Dec 2009 16:25:38.0698 (UTC) FILETIME=[3E56EEA0:01CA78EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134988>

We have been using git for a year or two now, and suddenly, one
of our users got the error message:

fatal: cannot pread pack file: No such file or directory
fatal: index-pack failed

while doing a git-pull.  We are using git version git-1.6.5.5.

I tried doing a "git fsck --full" on his repository and on the
one he is trying to pull from, and neither shows any error.

If I clone his repository, the clone also gets the error message
when trying to pull.

I can pull from him, but if he pulls from me, he gets the error
message.

This is worrying, because the fsck doesn't show an error, but
clearly something is wrong.

Is there anything further I can try to determine why his repo
is unable to pull?

	Thanks,
	Steve

-- 
A: Because it makes the logic of the discussion difficult to follow.
Q: Why shouldn't I top post?
A: No.
Q: Should I top post?
