From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 03:20:14 -0700
Message-ID: <7vhdgl2ext.fsf@assigned-by-dhcp.cox.net>
References: <20050527203227.GA11139@cip.informatik.uni-erlangen.de>
	<20050529230240.GB12290@cip.informatik.uni-erlangen.de>
	<20050529231053.GD12290@cip.informatik.uni-erlangen.de>
	<20050529231621.GE12290@cip.informatik.uni-erlangen.de>
	<20050529234606.GF12290@cip.informatik.uni-erlangen.de>
	<20050529235630.GG12290@cip.informatik.uni-erlangen.de>
	<7vsm05bkps.fsf@assigned-by-dhcp.cox.net>
	<20050530013056.GH12290@cip.informatik.uni-erlangen.de>
	<7vmzqd4041.fsf@assigned-by-dhcp.cox.net>
	<20050530083653.GL12290@cip.informatik.uni-erlangen.de>
	<20050530092140.GQ12290@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 12:18:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DchLL-0005tW-FA
	for gcvg-git@gmane.org; Mon, 30 May 2005 12:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVE3KUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 06:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVE3KUW
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 06:20:22 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62660 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261593AbVE3KUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 06:20:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530102016.PPIB8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 06:20:16 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050530092140.GQ12290@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Mon, 30 May 2005 11:21:40 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> Hello,
TG> I also have to strip duplicate HEADs out. So we do the following:

TG> run 0: kill dups
TG> run 1: kill HEADs which are referenced in the history of other HEADs

I think merge-base between A and A is always A, so the second
pass would eliminate the dups anyway...

