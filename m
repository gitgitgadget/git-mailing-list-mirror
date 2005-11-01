From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 19:25:54 -0500
Message-ID: <20051101002554.GA7634@thunk.org>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 01:27:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWjyZ-0006vx-1N
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 01:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVKAA0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 19:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVKAA0E
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 19:26:04 -0500
Received: from THUNK.ORG ([69.25.196.29]:3490 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964925AbVKAA0C (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 19:26:02 -0500
Received: from root (helo=think.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 3.35 #1 (Debian))
	id 1EWjyO-0002Yk-00; Mon, 31 Oct 2005 19:25:56 -0500
Received: from tytso by think.thunk.org with local (Exim 4.54)
	id 1EWjyM-00020K-9g; Mon, 31 Oct 2005 19:25:54 -0500
To: Joel Becker <Joel.Becker@oracle.com>
Content-Disposition: inline
In-Reply-To: <20051031224246.GP11488@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10908>

On Mon, Oct 31, 2005 at 02:42:46PM -0800, Joel Becker wrote:
> 	As the tools currently stand, I need to hand-diff and patch my
> commits.  Neither git nor cogito have a command to do this first-class
> "the way you should do it" common operation.  It is, in my experience, a
> pain.  Not as large a pain as some things, but certainly second class to
> much of the workflow git/cogito provide.  If it is supposed to be a
> regular part of my workflow, what's wrong with making it a first-class
> operation?

For an example of how to make it a first-class operation, it might be
worthwhile to look at Chris Mason's "Mercurial Queues" extention to
Mercurial:

	http://www.selenic.com/mercurial/wiki/index.cgi/MqExtension

I've used it once or twice, and hg mq is definitely very nice and
convenient, and it makes commits a first-class operation.  On the
other hand, I've found that the combination of quilt and
Mercurial/BK/git works just fine, even for my own internal development
of (for example) the e2fsprogs tree.

						- Ted
