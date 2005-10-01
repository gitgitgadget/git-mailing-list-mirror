From: Junio C Hamano <junkio@cox.net>
Subject: Re: [COGITO] cg-status in an empty repo spits out git-diff-index usage info
Date: Sat, 01 Oct 2005 00:17:13 -0700
Message-ID: <7vpsqp905i.fsf@assigned-by-dhcp.cox.net>
References: <20050930181809.GB13582@emcb.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 09:18:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELbcU-0003Bf-I4
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 09:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVJAHRQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 03:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVJAHRQ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 03:17:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10153 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750764AbVJAHRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 03:17:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051001071710.JWQI776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Oct 2005 03:17:10 -0400
To: Elfyn McBratney <beu@gentoo.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9590>

Elfyn McBratney <beu@gentoo.org> writes:

> which I'm guessing isn't expected behaviour ;)  `git status` does the
> same, FWIW.

Yes, I noticed 'git status' did it that some time ago, and I
thought "gee, that was ugly".  But then I imagined what any
other realist maintainer would have said if I reported it as a
bug.

    Lbh xabj lbh'ir whfg perngrq lbhe ercb naq vg vf rzcgl.
    Jung qvq lbh rkcrpg sebz 'fgnghf' bhgchg?  Jub pnerf!  Naq
    ubj bsgra jbhyq lbh rkcrpg gb eha 'tvg fgnghf' va n arjyl
    perngrq ercbfvgbel sebz abj ba, abj lbh xabj jung lbh jbhyq
    frr?  Trg hfrq gb vg.

But I fixed it anyway, exactly a month ago.
