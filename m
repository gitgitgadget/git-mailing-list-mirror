From: Junio C Hamano <junkio@cox.net>
Subject: Re: Checking git-cherry-pick Use Case
Date: Wed, 11 Jan 2006 11:29:58 -0800
Message-ID: <7v3bjuv9zd.fsf@assigned-by-dhcp.cox.net>
References: <1136997967.29751.198.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:35:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewlfa-0008T6-HB
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWAKTaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWAKTaA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:30:00 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53688 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932440AbWAKT37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 14:29:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111192807.ZHYA17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 14:28:07 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1136997967.29751.198.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Wed, 11 Jan 2006 10:46:07 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14500>

Jon Loeliger <jdl@freescale.com> writes:

> My first question is that I expected to see 
> something more like this (hand edited):
>
> 	! [dev] Stuff jdl made up and committed
>          * [jdl] Early stuff jdl made up
>           ! [origin] Original stuff
>         ---
>         ++  [dev] Stuff jdl made up and committed
>         +   [dev^] Merge branch 'jdl'
>         ++  [jdl^] Early stuff jdl made up
>         +++ [origin] Original stuff
>
> That is, the _same_ commit is now in both the "dev"
> and "jdl" branches, so why does it have two lines here?

Because they are not the same commit; they are two separate
commits, that happen to have the same commit log message and
authorship information, and perhaps even result to show the same
"diff" if asked by 1-parameter git-diff-tree, but they are
different commit objects nevertheless.

Funnily enough, I think I sent out almost exactly the same
message as yours the last couple of days regarding workflows,
after I hacked a bit on gitweb ;-).
