From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 14:42:46 -0800
Message-ID: <20051031224246.GP11488@ca-server1.us.oracle.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg> <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org> <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 00:34:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWj97-00081p-Vh
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 00:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVJaXcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 18:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVJaXcv
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 18:32:51 -0500
Received: from rgminet02.oracle.com ([148.87.122.31]:18010 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1751298AbVJaXcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 18:32:50 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet02.oracle.com (Switch-3.1.6/Switch-3.1.7) with ESMTP id j9VNWfAR009979;
	Mon, 31 Oct 2005 16:32:45 -0700
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VMgkj6012592;
	Mon, 31 Oct 2005 15:42:47 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j9VMgkcd012584
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 15:42:46 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.53)
	id 1EWiMY-0006Wn-5N; Mon, 31 Oct 2005 14:42:46 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10898>

On Mon, Oct 31, 2005 at 02:14:58PM -0800, Junio C Hamano wrote:
> I think you read me wrong.  Didn't I say "decompose and make
> them into logical stepS", emphasis on plural "S"?
> 
> Single big consolidated patch is not what I am advocating for.
> It is impossible to review and evaluate.  To be merged into a
> public tree, such unhistoried commit is often unacceptable.

	No, you're reading me wrong, but I wasn't clear enough either.
At the end of my message, I'm noting that I'm considering smaller
changes here, not huge features.
	Basically, I'm not talking about merging with Linus.  I'm
talking about merging with myself.  Let's assume we're all going with
the clean-up-your-history model.  It is quite clear that you and Linus
agree on that model, and I wasn't so much arguing against it as querying
everyone's opinion on it.
	So, I have a git repository that is my For-Linus repository.
It's got a clean history.  What's my workflow?

	1) Clone the repo to a Work tree.
	2) Create and test fix X, with perhaps some >1 number of commits.
	3) Bring that fix back to the For-Linus repository.

	This is a small change.  It's not something that needs stepS, as
you put them.  But my history in the Work tree is "dirty," so I cannot
just pull from Work to For-Linus.
	As the tools currently stand, I need to hand-diff and patch my
commits.  Neither git nor cogito have a command to do this first-class
"the way you should do it" common operation.  It is, in my experience, a
pain.  Not as large a pain as some things, but certainly second class to
much of the workflow git/cogito provide.  If it is supposed to be a
regular part of my workflow, what's wrong with making it a first-class
operation?
	Obviously, large features should and do have logical steps.  I'm
never going to be against that.

Joel

-- 

Life's Little Instruction Book #15

	"Own a great stereo system."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
