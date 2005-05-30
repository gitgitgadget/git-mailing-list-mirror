From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 03:33:30 +0200
Message-ID: <20050530013330.GI12290@cip.informatik.uni-erlangen.de>
References: <20050527195552.GA6541@cip.informatik.uni-erlangen.de> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de> <20050529230240.GB12290@cip.informatik.uni-erlangen.de> <20050529231053.GD12290@cip.informatik.uni-erlangen.de> <20050529231621.GE12290@cip.informatik.uni-erlangen.de> <20050529234606.GF12290@cip.informatik.uni-erlangen.de> <20050529235630.GG12290@cip.informatik.uni-erlangen.de> <7vsm05bkps.fsf@assigned-by-dhcp.cox.net> <7voeatbkey.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 03:31:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcZ7Y-0002Yo-M2
	for gcvg-git@gmane.org; Mon, 30 May 2005 03:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVE3Bdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 21:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVE3Bdk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 21:33:40 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:17608 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261493AbVE3Bdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 21:33:38 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4U1XUS8016647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 May 2005 01:33:30 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4U1XUAH016646;
	Mon, 30 May 2005 03:33:30 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voeatbkey.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> JCH>    - If MB is either BASE or H1, then you have a fast forward.
> JCH>      Take either BASE or H1 that is not MB and update variable
> JCH>      BASE with it, and update variable T with the tree
> JCH>      associated with it.  Continue with the loop (i.e. Perl
> JCH>      "next").

> Chuck this part please.  I was not thinking.

No, I don't because I think this exactly what I have to do here. And
yes, there can be fast forwards. :-)

But note: On a fast forward condition we have to remove a element from
COMMIT_HEADS: the (last) or (last - 1). Depending on if 'local' ==
MERGE_BASE or 'remote' == MERGE_BASE.

	Thomas
