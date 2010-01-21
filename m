From: Felipe Balbi <me@felipebalbi.com>
Subject: cherry picking several patches at once
Date: Thu, 21 Jan 2010 18:11:57 +0200
Message-ID: <20100121161157.GA3628@gandalf>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 17:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzxb-0000kK-8n
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 17:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab0AUQc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 11:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133Ab0AUQc1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 11:32:27 -0500
Received: from ns1.siteground211.com ([209.62.36.12]:34285 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab0AUQcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 11:32:24 -0500
X-Greylist: delayed 1218 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2010 11:32:24 EST
Received: from [91.154.126.168] (port=26511 helo=gandalf)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1NXzdb-0003Zv-Kc
	for git@vger.kernel.org; Thu, 21 Jan 2010 10:12:04 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground211.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - felipebalbi.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137667>

Hi,

I wonder if it's possible to cherry several patches at once ?
Can't find anything on any docs, but something like:

$ git cherry-pick <commit_id_start>..<commit_id_end> -- \
	/path/to/directory

I want to do that because I keep patches to the musb driver (on linux
kernel) based on top of linus' mainline tree and on top of internal
tree.

The internal tree is outdated (not following mainline), but the musb
driver is basically in sync, so cherry picking works, but it's a bit
painful when I have to pick patches from community and manually
cherry-pick to the other branch based on my internal tree.

If there's a way (besides git rebase --onto) to do that I would very
much like to know.

Another thing that would be nice to have, is to pass the HEAD to which
we want to cherry-pick, so we can cherry-pick to not-checked-out
branches. Something like:

$ git cherry-pick <commit_id> <my_branch_name>

and combining both, of course:

$ git cherry-pick <commit_id_start>..<commit_id_end> \
	<my_branch_name> -- /path/to/directory

-- 
balbi
