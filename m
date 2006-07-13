From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: when is "git diff" output suitable for patch?
Date: Thu, 13 Jul 2006 17:21:27 -0400
Message-ID: <20060713212127.GA30770@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 13 23:21:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G18cl-0005nu-Iz
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 23:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWGMVV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 17:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWGMVV2
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 17:21:28 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54717 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030389AbWGMVV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 17:21:28 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1G18ch-0008GH-F8
	for git@vger.kernel.org; Thu, 13 Jul 2006 17:21:27 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23851>

I assume the -C and -M, -c, and -cc options all result in diff output
that can't be correctly applied by "patch" any more?  (Would a patch to
the git-diff-files documentation warning about this be helpful?)

Someone I'm working with is having trouble applying patches that they
created with a simple "git diff".  The patches in question have some
"copy from/copy to" headers.  Should that every happen with just a plain
"git diff"?  Is this a bug in their version of git?  (They're on 1.2.4).

--b.
