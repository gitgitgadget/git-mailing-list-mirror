From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 03 Jun 2005 10:00:46 -0700
Message-ID: <7vr7fjml35.fsf@assigned-by-dhcp.cox.net>
References: <20050603152212.GA4598@jmcmullan.timesys>
	<Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason McMullan <jason.mcmullan@timesys.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:58:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeFUQ-0003E2-Lj
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 18:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVFCRAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVFCRAw
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 13:00:52 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3796 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261395AbVFCRAs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 13:00:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603170047.MATO550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 13:00:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 3 Jun 2005 09:02:10 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> ie it wouldn't be a deamon at all, it would be a foreground server. So I'd 
LT> call it just "git-server" or something.

That particular name risks conflicting name with other
git-servers offering different service for git; gitweb is a
git-server isn't it?  git-sync might be better fit.

LT> Anyway, technically this looks ok,...

I'd address them in a separate message later today.

