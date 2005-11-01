From: Petr Baudis <pasky@suse.cz>
Subject: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 10:08:04 +0100
Message-ID: <20051101090804.GA11618@pasky.or.cz>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <20051101002554.GA7634@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, mason@suse.com,
	catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 10:09:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWs7z-00070A-SZ
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 10:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVKAJIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 04:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVKAJIN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 04:08:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:1176 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964992AbVKAJIN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 04:08:13 -0500
Received: (qmail 17815 invoked by uid 2001); 1 Nov 2005 10:08:05 +0100
To: Theodore Ts'o <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <20051101002554.GA7634@thunk.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10926>

Dear diary, on Tue, Nov 01, 2005 at 01:25:54AM CET, I got a letter
where Theodore Ts'o <tytso@mit.edu> told me that...
> For an example of how to make it a first-class operation, it might be
> worthwhile to look at Chris Mason's "Mercurial Queues" extention to
> Mercurial:
> 
> 	http://www.selenic.com/mercurial/wiki/index.cgi/MqExtension
> 
> I've used it once or twice, and hg mq is definitely very nice and
> convenient, and it makes commits a first-class operation.  On the
> other hand, I've found that the combination of quilt and
> Mercurial/BK/git works just fine, even for my own internal development
> of (for example) the e2fsprogs tree.

Did anyone do any current detailed comparison between hg mq and StGIT?

I'm very happy with StGIT, modulo few UI gripes I'm still not getting
around to fix, and the fact that I cannot version my changes to patches
- this is one advantage of having quilt stuff tracked by GIT, I think,
but that feels ugly.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
