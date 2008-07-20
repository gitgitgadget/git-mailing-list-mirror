From: Paul Mackerras <paulus@samba.org>
Subject: git cvsimport and deleted files
Date: Sun, 20 Jul 2008 22:09:07 +1000
Message-ID: <18563.10979.379533.580413@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 14:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKXk2-0003DU-6G
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbYGTMJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756396AbYGTMJS
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:09:18 -0400
Received: from ozlabs.org ([203.10.76.45]:59569 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756349AbYGTMJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:09:17 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id ACD9CDDE08; Sun, 20 Jul 2008 22:09:15 +1000 (EST)
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (powerpc-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89190>

I just tried importing the CVS repository for a long-running project
(ppp) into git using git cvsimport.  It looks like git cvsimport
doesn't notice when files have been deleted, so files that used to be
present and were subsequently deleted are present in the git tree for
the most recent commit.

Is this a known problem?  Is it a limitation of cvsps?  I know that
cvs doesn't represent deletions explicitly anywhere, so I guess it's
not surprising, but it is a bit annoying.

Paul.
