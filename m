From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-update-cache: allow dot-files
Date: Tue, 24 May 2005 18:11:42 -0700
Message-ID: <7v3bscrtwx.fsf@assigned-by-dhcp.cox.net>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org>
	<7v8y24taai.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241748520.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 03:10:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DakPN-00078N-IG
	for gcvg-git@gmane.org; Wed, 25 May 2005 03:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVEYBLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 21:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVEYBLp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 21:11:45 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:22400 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262223AbVEYBLo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 21:11:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525011142.MJWK23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 21:11:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241748520.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 17:52:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Heh. There's a difference between being anal, and allowing people to shoot 
LT> themselves in the foot.

How about we do something like this:

 (1) we keep hardcoded .git refusing as you did;
 (2) we forbid GIT_DIR to be set to anything other than what
     ends with "/.git", unless it is literally ".git";


