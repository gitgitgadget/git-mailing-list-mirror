From: Junio C Hamano <junkio@cox.net>
Subject: Re: I'm missing isofs.h
Date: Wed, 27 Apr 2005 19:02:38 -0700
Message-ID: <7vzmvjbqv5.fsf@assigned-by-dhcp.cox.net>
References: <20050426214338.32e9ac27.akpm@osdl.org>
	<20050427235115.GN22956@pasky.ji.cz>
	<Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org>
	<20050428003246.GV22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:57:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyHH-0007sH-HD
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVD1CCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVD1CCo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:02:44 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44979 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261711AbVD1CCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 22:02:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428020239.MFIU1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 22:02:40 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428003246.GV22956@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 28 Apr 2005 02:32:47 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Dear diary, on Thu, Apr 28, 2005 at 02:19:07AM CEST, I got a letter
PB> where Linus Torvalds <torvalds@osdl.org> told me that...
>> And together with Junio's stuff from today, you can literally just do
>> 
>> diff-cache -p $tree
>> 
>> and you're done - it diffs any release "$tree" against the current state.

PB> Actually, I can't; the patch generator is not on par with mine yet.

That's what GIT_EXTERNAL_DIFF is there for.


