From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Fri, 16 Sep 2005 09:56:41 -0400
Message-ID: <20050916135641.GA13762@thunk.org>
References: <1126674993.5681.9.camel@localhost.localdomain> <1126745323.7199.3.camel@localhost.localdomain> <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org> <43290486.5020301@zytor.com> <7v7jdibwqq.fsf@assigned-by-dhcp.cox.net> <u5tvf12sp1v.fsf@lysator.liu.se> <Pine.LNX.4.58.0509150905070.26803@g5.osdl.org> <u5toe6uql1w.fsf@lysator.liu.se> <Pine.LNX.4.58.0509151106200.26803@g5.osdl.org> <1126822093.27951.74.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	David K?gedal <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Sep 16 15:59:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGGiN-0003qk-Jy
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 15:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbVIPN4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 09:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbVIPN4y
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 09:56:54 -0400
Received: from thunk.org ([69.25.196.29]:6042 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161097AbVIPN4x (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 09:56:53 -0400
Received: from root (helo=think.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 3.35 #1 (Debian))
	id 1EGGhn-0001lW-00; Fri, 16 Sep 2005 09:56:43 -0400
Received: from tytso by think.thunk.org with local (Exim 4.52)
	id 1EGGhl-0003b7-VT; Fri, 16 Sep 2005 09:56:42 -0400
To: Christian Meder <chris@absolutegiganten.org>
Content-Disposition: inline
In-Reply-To: <1126822093.27951.74.camel@localhost>
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8683>

On Fri, Sep 16, 2005 at 12:08:12AM +0200, Christian Meder wrote:
> Debian prefers to call the symlink "pager" and let the sysadmin decide
> where it should point: less, more, whatever. The e2fsprogs upstream
> package for instance supports PAGER->/usr/bin/pager->/usr/bin/less.
> Granted /usr/bin/pager is probably Debian only but every upstream author
> deciding whether to use PAGER:more or PAGER:less is not _that_ much
> better. 

Actually, debugfs uses $DEBUGFS_PAGER:$PAGER:pager:more:less as its
search path, where it looks for each executable in /usr/bin, /bin, and
the current directory.

Overkill, yes; but it was the best way to shut up the whiny debian
users who kept on filing bug reports.  (Yes, yes, I'm softie.
Besides, it's userspace, and compared to GNOME, KDE, or Mozilla, the
bloat involved isn't even measurable.  :-)

							- Ted
