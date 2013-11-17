From: Tim Chase <git@tim.thechases.com>
Subject: Git -> fossil bridging?
Date: Sun, 17 Nov 2013 15:00:10 -0600
Message-ID: <20131117150010.675971d3@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 17 23:03:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViAR2-0000id-8t
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 23:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab3KQWDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 17:03:01 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:47385 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751267Ab3KQWDA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Nov 2013 17:03:00 -0500
X-Greylist: delayed 3859 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2013 17:03:00 EST
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:33388 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1Vi9QX-0001AI-5Z
	for git@vger.kernel.org; Sun, 17 Nov 2013 14:58:41 -0600
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: authenticated_id: tim@thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237962>

Has there been any development on git<->fossil bridging?  I know one
can spew fastimports between the two for an initial synchronization,
but I'd like to have a continuous bridge; something like git-svn.
I have fossil on one machine (mostly a public machine, for
bug-tracking, wiki, etc that fossil does nicely) while using git
locally and pushing change-sets out to the fossil repo.

Any tips?

My current experimentation just houses both in the same location with
my git "master" branch manually synced with the fossil repo (which is
really all I need which does simplify matters greatly, though it
would be nice to sync multiple branches if the functionality was
there).

Thanks,

-tkc
