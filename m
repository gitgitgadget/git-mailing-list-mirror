From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 09:24:55 -0600
Message-ID: <m1eka574c8.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 17:34:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds0Hc-0002a0-VY
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 17:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVGKP2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 11:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVGKPZx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 11:25:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52619 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261984AbVGKPZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 11:25:05 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6BFOt84015286;
	Mon, 11 Jul 2005 09:24:55 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6BFOtm8015285;
	Mon, 11 Jul 2005 09:24:55 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org> (Linus
 Torvalds's message of "Sun, 10 Jul 2005 18:18:25 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, I tagged a "v0.99" thing, and pushed it out. I've also made trial 
> RPM's of it: src, ppc64 and x86. They're build on whatever random machines 
> I had, and on the ppc64 I chose to do it on my FC4 machine that has newer 
> libraries than my YDL one. The x86 thing is FC3, I do believe.
>
> I haven't really verified the RPM's in any other way than a trial 
> installation on one machine, and "gitk" seemed to work. Whoop. The idea 
> being that this is a good way to check whether the rpm target works, _and_ 
> cogito can have something to build against.

A couple of pieces.  The dist target has assumes git-tar-tree is in the
path.  Making it so you have to have git installed to build the rpm.

The man pages are not built. The build dependencies do not call out
the tools necessary to build the man pages.

And it does not pass my torture test of building rpm's on debian,
but that is not a huge problem.

Are you still up for a patch that records who and when made a tag?
I sent one but it seems to have been lost.

Eric
