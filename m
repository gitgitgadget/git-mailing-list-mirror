From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Tie it all together: "git log"
Date: Tue, 28 Feb 2006 14:22:50 -0800
Message-ID: <7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 23:22:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEDF8-0002yw-N2
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 23:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWB1WWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWB1WWx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 17:22:53 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26327 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932531AbWB1WWw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 17:22:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228222121.YZAP20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Feb 2006 17:21:21 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602281251390.22647@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 28 Feb 2006 12:59:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16956>

Linus Torvalds <torvalds@osdl.org> writes:

> Anyway, apart from that issue (which I think should be trivial to sort out 
> if we accept breaking --merge-order), the rest looks like it should just 
> get more testing and handling of the few missing flags from rev-parse in 
> revision.c, and it should be good.

I would say we should just rip merge-order out.  Who uses it,
and why does it not work with topo-order, again?
