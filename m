From: Paul Mackerras <paulus@samba.org>
Subject: New gitk feature - show where a line came from
Date: Mon, 27 Oct 2008 22:47:55 +1100
Message-ID: <18693.43627.381786.934151@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 12:49:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuQaz-0006CM-6A
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 12:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbYJ0LsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 07:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYJ0LsC
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 07:48:02 -0400
Received: from ozlabs.org ([203.10.76.45]:47675 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbYJ0LsB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 07:48:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 37D16DDDE0; Mon, 27 Oct 2008 22:47:59 +1100 (EST)
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99228>

I have just pushed out some commits for gitk which add a feature that
I have wanted for a long time - a way to point at a line in gitk and
say "where did that come from" and have gitk show you the answer.  You
can now right-click on a line in the diff/file display pane (bottom
left) and select "Show origin of this line".  Gitk will run a one-line
git blame on that line, and once the answer comes back, it will select
the commit that added that line, highlight the line with a light-blue
background, and scroll so that the line is visible.  This works both
when displaying diffs and when displaying files.

There are still some minor rough edges, but I'd be interested in
hearing whether it's useful to people, or if people have problems
using it.

This builds on the work done by Alexander Gavrilov, who added the
context menu for the diff/file display pane and a menu item to start
an external git gui blame on a file.

Paul.
