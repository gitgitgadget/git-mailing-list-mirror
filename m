From: Tim Chase <git@tim.thechases.com>
Subject: coming from git, understanding mercurial branching
Date: Thu, 5 Sep 2013 21:27:14 -0500
Message-ID: <20130905212714.636db4c4@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 06 04:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHlkS-00062o-0o
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 04:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758724Ab3IFC0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 22:26:07 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:58504 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753732Ab3IFC0G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 22:26:06 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:49828 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1VHlkK-0004D6-Ri
	for git@vger.kernel.org; Thu, 05 Sep 2013 21:26:04 -0500
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234014>

I've got a pretty good grasp on git's rather straightforward
branching, but am trying to wrap my head around Mercurial's
branching.  There seem to be several flavors, some default to
push-public, while others are private; some are tracked in history,
while others seem more ephemeral; often the docs suggest cloning
instead of branching; detached heads seem more normal in the
Mercurial world.

Do any git users here have good "understanding Mercurial branches
for the git user" resources they've found helpful when working with
Mercurial?  Preferably a "for dummies" resource with illustrations &
comparison charts so I can see the big picture.

Thanks

-tkc


PS: I've read a couple Mercurial resources including
http://mercurial.selenic.com/wiki/GitConcepts
but it didn't really dig into comparing the mental models used in
branching.  
