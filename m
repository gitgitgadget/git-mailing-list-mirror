From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: New git commit tool
Date: Tue, 5 Sep 2006 18:46:52 +0200
Message-ID: <20060905164652.GB5547@diku.dk>
References: <17660.4995.977221.767112@cargo.ozlabs.ibm.com> <20060904195736.GB2752@diku.dk> <17660.40934.605502.248266@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Sep 05 18:47:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKe4n-0008J6-13
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 18:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWIEQq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 12:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWIEQq7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 12:46:59 -0400
Received: from [130.225.96.91] ([130.225.96.91]:2433 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030187AbWIEQq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 12:46:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id D13A977001D;
	Tue,  5 Sep 2006 18:46:54 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24633-02; Tue,  5 Sep 2006 18:46:53 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 962EC77001A;
	Tue,  5 Sep 2006 18:46:53 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B4FD46DF89F; Tue,  5 Sep 2006 18:45:20 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2070462A09; Tue,  5 Sep 2006 18:46:53 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17660.40934.605502.248266@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26480>

Paul Mackerras <paulus@samba.org> wrote Tue, Sep 05, 2006:
> Jonas Fonseca writes:
> 
> >     I am a Cogito user, so I am no used to running git-update-index and
> >     this seems to be a problem in this case:
> > 
> > 	can't unset "indexpending(gitool)": no such element in array
> 
> Hmmm, I didn't think that could happen. :) It can only happen if some
> file gets listed twice in the output from "git-diff-index HEAD".
> Could you send me the output of "git-diff-index HEAD" and
> "git-diff-index --cached HEAD" in that repository?

~/gitool > git-diff-index HEAD
fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
~/gitool > git-diff-index --cached HEAD
fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
~/gitool > cat .git/HEAD
ref: refs/heads/master
~/gitool > ls .git/refs/heads/
~/gitool >

> And no, you don't need to run git-update-index, gitool does that for
> you.

Good to hear, but I swear the first time I ran gitool in a repo of mine
it popped up the error dialog with the details saying:

	fileX: needs update

Now, of course, I cannot reproduce it.

-- 
Jonas Fonseca
