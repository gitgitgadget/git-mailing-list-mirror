From: Petr Baudis <pasky@ucw.cz>
Subject: Re: ia64 git pull
Date: Fri, 22 Apr 2005 03:53:40 +0200
Message-ID: <20050422015340.GD7443@pasky.ji.cz>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com> <Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org> <200504212155.j3LLtho04949@unix-os.sc.intel.com> <200504212301.j3LN1Do05507@unix-os.sc.intel.com> <20050422012546.GD1474@pasky.ji.cz> <17000.22515.170455.192374@sodium.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tony.luck@intel.com, Linus Torvalds <torvalds@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 03:49:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOnIG-00018c-6A
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 03:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVDVBxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 21:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVDVBxq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 21:53:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10126 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261914AbVDVBxl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 21:53:41 -0400
Received: (qmail 5495 invoked by uid 2001); 22 Apr 2005 01:53:40 -0000
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <17000.22515.170455.192374@sodium.jf.intel.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 03:48:35AM CEST, I got a letter
where Inaky Perez-Gonzalez <inaky@linux.intel.com> told me that...
> >>>>> Petr Baudis <pasky@ucw.cz> writes:
> 
> > I've just added to git-pasky a possibility to refer to branches
> > inside of repositories by a fragment identifier:
> 
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git#testing
> 
> > will refer to your testing branch in that repository.
> 
> Can we use something other than #? we'll have to scape it all the time
> in the shell (or at least also allow some other char, something
> without special meta-character meaning in the shell, like %).

Remember that it's an URL (so you can't use '%'), and '#' is the
canonical URL fragment identifier delimiter. (And fragments are perfect
for this kind of thing, if you look at the RFC, BTW.)

Still, why would you escape it? My shell will not take # as a comment
start if it is immediately after an alphanumeric character.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
