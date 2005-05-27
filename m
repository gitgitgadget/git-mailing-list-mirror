From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 21:55:52 +0200
Message-ID: <20050527195552.GA6541@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 21:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbkuG-00086C-RR
	for gcvg-git@gmane.org; Fri, 27 May 2005 21:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVE0T4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVE0T4I
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 15:56:08 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:8375 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262564AbVE0T4C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 15:56:02 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4RJtrS8007542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 19:55:53 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4RJtqmD007541;
	Fri, 27 May 2005 21:55:52 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> You merge by hand and resolve if they have conflicts, just like
> what you already do in two head merge case.

I see. Does that mean that 'git-ls-files --unmerged' will report upto 9
stages per file?

> Octopus is only about how you record the results.  Instead of
> making 7 consecutive "merge from A" "merge from B" to record two
> head merges, you just say "I merged these 8 heads" in a single
> commit.

I got that part. :-)

	Thomas
