From: Hannu Koivisto <azure@iki.fi>
Subject: Errors when updating an old git.git repository
Date: Tue, 26 Dec 2006 16:49:28 +0200
Organization: NOYB
Message-ID: <87d566ww3r.fsf@trews52.bothi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 26 15:50:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzDco-0007UW-FT
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 15:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWLZOtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 09:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWLZOtv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 09:49:51 -0500
Received: from main.gmane.org ([80.91.229.2]:42437 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932642AbWLZOtu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 09:49:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GzDcZ-0005OQ-B5
	for git@vger.kernel.org; Tue, 26 Dec 2006 15:49:39 +0100
Received: from her-gw.ionific.com ([195.197.73.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 15:49:39 +0100
Received: from azure by her-gw.ionific.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 15:49:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: her-gw.ionific.com
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/22.0.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:oFT9ZTKiPPkub/g3/bUqvb1uSgU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35420>

Greetings,

I just did "git-clone git://git.kernel.org/pub/scm/git/git.git".
git-pull in the resulting repository gives "Already up-to-date."
and "git-pull --tags" does the same.  Just what I'd expect.

Before I did that, I had an old (several months) git.git repository
laying on the hard drive and I updated it with "git pull".  It
complained something tag related and I tried again with "git pull
--tags".  Now I'm in a situation where "git-pull --tags" gives "No
changes." but plain "git-pull" gives me this:

-------------------------------------------------------------------
remote: Generating pack...
remote: Done counting 293 objects.
remote: Result has 214 objects.
remote: Deltifying 214 objects.
remote: 14/214) done14) done
Unpacking 214 objects
remote: Total 214, written 214 (delta 156), reused 181 (delta 123)
 100% (214/214) done
error: no such remote ref refs/heads/jc/bind
error: no such remote ref refs/heads/jc/bind-2
error: no such remote ref refs/heads/gb/diffdelta
* refs/heads/pu: not updating to non-fast forward branch 'pu' of git://git.kernel.org/pub/scm/git/git
  old...new: 0c9951a...f959571
Already up-to-date.
-------------------------------------------------------------------

If I run either git-pull or "git-pull --tags" again, I get the same
results.

Since updating a freshly cloned repository doesn't result to such
an odd behaviour, I assume this old repository is broken somehow.
If someone wants to inspect it, I can make it available via web.

I'm using git 1.4.4.3 on Debian GNU/Linux.

-- 
Hannu
