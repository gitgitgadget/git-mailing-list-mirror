From: Petr Baudis <pasky@ucw.cz>
Subject: Re: ia64 git pull
Date: Fri, 22 Apr 2005 00:58:57 +0200
Message-ID: <20050421225857.GB1474@pasky.ji.cz>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com> <Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org> <200504212155.j3LLtho04949@unix-os.sc.intel.com> <Pine.LNX.4.58.0504211520250.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:55:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkZG-0002TM-Og
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVDUW7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDUW7G
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:59:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41354 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261573AbVDUW66 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 18:58:58 -0400
Received: (qmail 19958 invoked by uid 2001); 21 Apr 2005 22:58:57 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504211520250.2344@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 12:29:07AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Thu, 21 Apr 2005 tony.luck@intel.com wrote:
> > 
> > I can't quite see how to manage multiple "heads" in git.  I notice that in
> > your tree on kernel.org that .git/HEAD is a symlink to heads/master ...
> > perhaps that is a clue.
> 
> It's mainly a clue to bad practice, in my opinion. I personally like the 
> "one repository, one head" approach, and if you want multiple heads you 
> just do multiple repositories (and you can then mix just the object 
> database - set your SHA1_FILE_DIRECTORY environment variable to point to 
> the shared object database, and you're good to go). 

There are two points regarding this:

(i) You need to track heads of remote branches anyway.

(ii) I want an easy way for user to refer to head of another working
tree on the same repository (so that you can do just git merge testing).

This is why the multiple heads are there, and it's actually everything
they _do_. There's nothing more behind it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
