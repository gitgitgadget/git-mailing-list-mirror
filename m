From: Yoann Padioleau <padator@wanadoo.fr>
Subject: merging git repositories history for full history of linux
Date: Mon, 24 Mar 2008 13:56:24 -0500
Message-ID: <87iqzcne7b.fsf@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 20:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdsEM-0008Ge-HA
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 20:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759559AbYCXTUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 15:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758262AbYCXTUd
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:20:33 -0400
Received: from expredir5.cites.uiuc.edu ([128.174.5.96]:43292 "EHLO
	expredir5.cites.uiuc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578AbYCXTUd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 15:20:33 -0400
X-Greylist: delayed 1275 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Mar 2008 15:20:32 EDT
Received: from axyr (aryx.cs.uiuc.edu [128.174.236.106])
	by expredir5.cites.uiuc.edu (8.14.2/8.14.2) with ESMTP id m2OIxGKs003507;
	Mon, 24 Mar 2008 13:59:17 -0500 (CDT)
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78081>


Hi, 

I would like to merge the 3 git repositories of the history
of linux, the one by Dave Jones from linux 0.01 to linux 2.4.0, 
the one by tglx from 2.4.0 to 2.6.12 and the one from 2.6.12
by torvalds until the last version of Linux.

Right now there are 3 repos and I would like only one. I made
some scripts to create a fresh repo, and incorporate each
commit from the 3 repositories mentionned above
(getting the changelog, setting the date), but it takes lots of time
because for instance I can not use the git log -p commitid because
the patch can not be applied as is. So I usually do a checkout
for each commitid and do a manual diff to generate a patch
and apply it to my fresh repo.

Is there a magic command that makes this possible efficiently ?
