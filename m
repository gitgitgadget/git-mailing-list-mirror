From: Junio C Hamano <junkio@cox.net>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 14:14:58 -0800
Message-ID: <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	<Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
	<Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	<20051031195010.GM11488@ca-server1.us.oracle.com>
	<7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	<20051031213616.GO11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 31 23:15:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWhvn-0000yg-Eq
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 23:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVJaWPD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 17:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVJaWPD
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 17:15:03 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:26811 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964872AbVJaWPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 17:15:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031221500.PVWA9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 17:15:00 -0500
To: git@vger.kernel.org
In-Reply-To: <20051031213616.GO11488@ca-server1.us.oracle.com> (Joel Becker's
	message of "Mon, 31 Oct 2005 13:36:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10895>

Joel Becker <Joel.Becker@oracle.com> writes:

> On Mon, Oct 31, 2005 at 01:00:18PM -0800, Junio C Hamano wrote:
>> Do you think anybody is that perfect?
>
> 	I was being slightly facetious.  Of course everyone makes
> mistakes and corrects them.  But if you _want_ the history, you have to
> take it.  Otherwise, you are required to throw away the history
> completely.  And that -- do you want the whole history or none of it --
> is the crux of my question.

> 	I could care less about preserving my public image.  I'm an
> idiot, I screw up all the time.  I only care that the tip of my tree is
> respectable.
> 	I've seen arguments from folks on both sides -- the intermediate
> history is important, warts and all, vs throw it all out for a clean
> public history.  It seems that you fall into the second camp.
> 	That's fine, but can we make that work model a first-class
> citizen?  Can we get a script that pulls one branch as a single,
> un-historied (sic) commit into the current branch?

I think you read me wrong.  Didn't I say "decompose and make
them into logical stepS", emphasis on plural "S"?

Single big consolidated patch is not what I am advocating for.
It is impossible to review and evaluate.  To be merged into a
public tree, such unhistoried commit is often unacceptable.
