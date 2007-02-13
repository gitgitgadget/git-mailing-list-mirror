From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Including the release notes in the git-1.5.0 release?
Date: Tue, 13 Feb 2007 09:13:51 -0500
Message-ID: <E1HGyPn-0003Te-9s@candygram.thunk.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 15:14:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGyPw-0008Nh-EU
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 15:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbXBMON5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 09:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXBMON5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 09:13:57 -0500
Received: from thunk.org ([69.25.196.29]:41735 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbXBMON5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 09:13:57 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HGyV3-0001gY-FJ; Tue, 13 Feb 2007 09:19:17 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HGyPn-0003Te-9s; Tue, 13 Feb 2007 09:13:51 -0500
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39523>

Junio,

I noticed that the file v1.5.0.txt is still in the todo branch, but not
in the actual main git branch.  I assume that this means you were
planning on including the v1.5.0.txt in the git announcement, but not
necessarily including it in the actual git 1.5.0 tarball?

As a suggestion, maybe it would be a good idea to actually include it as
RELEASE-NOTES in the top-level source tree of git.   This will make it
much more likely that people packaging git will include in
/usr/share/doc/git.  

Or better yet, maybe we should include it in the Documentation directory
and set it up to be built as a manpage, git-release-notes.  This will
make it much more likely that end users who are getting git from their
Fedora, Debian, Red Hat, et. al distribution will actually see the
release notes when they install the new package.

What do you think?

						- Ted
