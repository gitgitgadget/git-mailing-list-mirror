From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Tue, 24 May 2005 01:16:59 -0700
Message-ID: <7vll65vy10.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
	<7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
	<Pine.LNX.4.58.0505211137250.2206@ppc970.osdl.org>
	<7vbr71xjyt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505232314510.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:19:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaUce-0004yc-9z
	for gcvg-git@gmane.org; Tue, 24 May 2005 10:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVEXITj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 04:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVEXISX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 04:18:23 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62700 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261446AbVEXIRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 04:17:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524081657.TKOM550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 04:16:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505232314510.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 23:19:49 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Since pretty much all the blobs will be expanded in the working directory
LT> anyway, it sounds like that would be the way to go. 
LT> That said, I don't think -C is that important...

OK, so the short version is, diff-cache like optimization may be
interesting to try out, but practically it would not be much
useful anyway, so I should do it if I am really bored and have
nothing else interesting to do ;-).


