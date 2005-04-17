From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Yet another base64 patch
Date: Sun, 17 Apr 2005 20:19:36 +0200
Message-ID: <20050417181935.GD1461@pasky.ji.cz>
References: <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org> <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com> <20050414214756.GA31249@outpost.ds9a.nl> <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org> <425F13C9.5090109@zytor.com> <20050414205831.01039ee8.pj@engr.sgi.com> <4261DDBC.3050706@dwheeler.com> <20050416210513.1ba26967.pj@sgi.com> <42620452.4080809@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Jackson <pj@sgi.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 20:16:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEJB-0003z3-Fc
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVDQSTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVDQSTj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:19:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54420 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261393AbVDQSTh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:19:37 -0400
Received: (qmail 5148 invoked by uid 2001); 17 Apr 2005 18:19:36 -0000
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Content-Disposition: inline
In-Reply-To: <42620452.4080809@dwheeler.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 08:38:10AM CEST, I got a letter
where "David A. Wheeler" <dwheeler@dwheeler.com> told me that...
> I'd look at some of the more constraining, yet still
> common cases, and make sure it worked reasonably
> well without requiring magic. My list would be:
> ext2, ext3, NFS, and Windows' NTFS (stupid short filenames,
> case-insensitive/case-preserving).  Samba shouldn't be
> more constraining than NTFS, and I would expect ReiserFS
> wouldn't be a constraining case.  Bonus points if the
> names lengths are inside POSIX guarantees, but I bet the
> POSIX limits are so tiny as to be laughable.  Bonus points for
> CD-ROM format with the Rock Ridge extensions (I _think_ DVDs
> and later use that format too, yes?), though if that
> didn't work tar files are an easy workaround. Imagine a full
> Linux kernel source repository, for 30+ (pick a number) years..
> can the filesystems handle the number of objects in those cases?
> If it works, your infrastructure should be sufficiently
> portable to "just work" on others too.

I personally don't mind getting it work on more places, if it doesn't
make git work (measurably) worse on modern Linux systems, the code will
not go to hell, you tell me what needs to be done and preferably give me
the patches. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
