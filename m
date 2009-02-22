From: Gerd Knops <gerti-git@bitart.com>
Subject: Getting diff in commit-msg hook?
Date: Sun, 22 Feb 2009 21:03:45 +0000 (UTC)
Message-ID: <loom.20090222T205429-30@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 23:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbMhb-00057U-E2
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 23:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbZBVWUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 17:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbZBVWUG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 17:20:06 -0500
Received: from main.gmane.org ([80.91.229.2]:55602 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbZBVWUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 17:20:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LbMg6-0005Kx-Rr
	for git@vger.kernel.org; Sun, 22 Feb 2009 22:20:03 +0000
Received: from 75-146-45-44-Minnesota.hfc.comcastbusiness.net ([75-146-45-44-Minnesota.hfc.comcastbusiness.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:20:02 +0000
Received: from gerti-git by 75-146-45-44-Minnesota.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.146.45.44 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111063>

When I commit certain files, I would like to send a diff via email to
interested parties.

So I added a commit-msg hook, which checks the list of files for that commit.
That part works fine. However in the email I would like to include a
diff of the file(s) in question.

Now when I run "git diff -- '$file'", I get no output, probably because the
file is in some semi-committed state.

So how can I obtain a diff for a file in a commit-msg hook?

Thanks

Gerd
