From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make git-sh-setup-script do what it was supposed to do
Date: Sat, 06 Aug 2005 10:18:16 -0700
Message-ID: <7vll3f9e7b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508061002370.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 19:19:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1SJX-0005GT-5L
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 19:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbVHFRST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 13:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbVHFRST
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 13:18:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:55194 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S263282AbVHFRSS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 13:18:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806171817.MLRU16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 13:18:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508061002370.3258@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 6 Aug 2005 10:04:50 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Duh. A missing && meant that half the tests that git-sh-setup-script were
> _meant_ to do were actually totally ignored.
>
> In particular, the git sanity checking ended up only testing that the 
> GIT_OBJECT_DIRECTORY was sane, not that GIT_DIR itself was..

Ouch.  Thanks.
