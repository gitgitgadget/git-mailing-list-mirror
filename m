From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 01:46:06 +0200
Message-ID: <20050529234606.GF12290@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org> <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de> <20050529230240.GB12290@cip.informatik.uni-erlangen.de> <20050529231053.GD12290@cip.informatik.uni-erlangen.de> <20050529231621.GE12290@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:44:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXRt-00011P-0j
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVE2XqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVE2XqU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:46:20 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:53180 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261445AbVE2XqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:46:15 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4TNk6S8005562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 May 2005 23:46:06 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4TNk6Je005561;
	Mon, 30 May 2005 01:46:06 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050529231621.GE12290@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
yet another bug. If there is only one head left after the for loop this
head is *set* not *commitet* as new HEAD because it comes from a 'pull
into empty tree' or from a 'just head ahead'-condition.

	Thomas
