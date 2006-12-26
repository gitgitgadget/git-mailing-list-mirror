From: Hannu Koivisto <azure@iki.fi>
Subject: git-cvsimport and git-checkout problem
Date: Tue, 26 Dec 2006 16:13:55 +0200
Organization: NOYB
Message-ID: <87fyb2wxr0.fsf@trews52.bothi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 26 15:30:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzDJn-00058F-Da
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 15:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWLZOaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 09:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWLZOaJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 09:30:09 -0500
Received: from main.gmane.org ([80.91.229.2]:55043 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932626AbWLZOaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 09:30:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GzDJZ-0001qr-UK
	for git@vger.kernel.org; Tue, 26 Dec 2006 15:30:02 +0100
Received: from her-gw.ionific.com ([195.197.73.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 15:30:01 +0100
Received: from azure by her-gw.ionific.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 15:30:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: her-gw.ionific.com
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/22.0.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:4XbJZl3HaHVruufZCIyR+zVpudE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35419>

Greetings,

I'm learning git and decided to try importing a small CVS module
into a git repository (before attempting a really big one).
Existence of -i in git-cvsimport would seem to imply that it
checkouts by default but it didn't seem to do that.  That is, I did
"git-cvsimport -d ~/.cvs_root -C module module" and I got a
"module" directory that contains ".git" directory but nothing else.
And saying "git checkout master" in "module" doesn't seem to do
anything.

Finally I realized to try "git-checkout -f master" and that
worked.  By reading git-checkout(1) I just cannot see why -f was
needed in this case or even what it generally does ("re-read of
everything" -- um, what everything and why would you explicitly
want to re-read that everything?).

I'm using git 1.4.4.3 and cvsps 2.1 (from a git repository
recommended by some web page) on Debian GNU/Linux.

-- 
Hannu
