From: Eric Wong <normalperson@yhbt.net>
Subject: git-svn updates
Date: Sun, 18 Jan 2009 20:06:15 -0800
Message-ID: <20090119040615.GA11306@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 05:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOlQJ-00053E-NK
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 05:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZASEGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 23:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbZASEGQ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 23:06:16 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33243 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbZASEGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 23:06:16 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACAFE1F7AD;
	Mon, 19 Jan 2009 04:06:15 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106318>

Hi all,

I've acked a few patches and pushed out several fixes of my own to
  git://git.bogomips.org/git-svn.git

They should be reasonably safe to run, but I haven't been doing much
hacking in recent months so I may be a bit rusty.  Extra eyes and
testing would be very much appreciated.

Eric Wong (4):
      git-svn: handle empty files marked as symlinks in SVN
      git-svn: better attempt to handle broken symlink updates
      git-svn: fix SVN 1.1.x compatibility
      git-svn: avoid importing nested git repos

Marcel Koeppen (1):
      git-svn: Show UUID in svn info for added directories with svn 1.5.5

Pete Harlan (1):
      git-svn: Add --localtime option to "fetch"


I'll try to get to splitting out the monster git-svn.perl file by next
weekend.

I also got a private bug report about EDITOR/VISUAL usage with `git svn
dcommit -e' when there was a space in the command.  Perhaps introducing
a Git::Editor Perl module that emulates editor.c would be a start?

-- 
Eric Wong
