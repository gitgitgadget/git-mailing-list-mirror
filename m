From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-zip-tree to .gitignore
Date: Sun, 27 Aug 2006 15:57:48 -0700
Message-ID: <7vhczxvlar.fsf@assigned-by-dhcp.cox.net>
References: <44F17FD5.2030000@lsrfire.ath.cx>
	<7vlkp9x2b9.fsf@assigned-by-dhcp.cox.net>
	<44F21E0B.9010600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 00:57:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHTZZ-0005Ve-4M
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 00:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWH0W5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 18:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWH0W5S
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 18:57:18 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42157 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750787AbWH0W5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 18:57:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827225716.DTOU21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 Aug 2006 18:57:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FAxE1V0034Noztg0000000
	Sun, 27 Aug 2006 18:57:14 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44F21E0B.9010600@lsrfire.ath.cx> (Rene Scharfe's message of
	"Mon, 28 Aug 2006 00:34:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26126>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> Although it was my fault applying it already to "master" without 
>> asking this question first, I started to wonder how many more archive
>> format people would want, and if it might make more sense to
>> consolidate git-*-tree into a single frontend with an option to
>> specify the archiver.
>> 
>> We would obviously need to keep git-tar-tree as a backward 
>> compatibility alias for "git archive-tree -f tar", but doing things
>> that way we do not have to introduce unbounded number of new
>> git-{zip,rar,...}-tree programs.
>
> That thought occurred to me, too.  I guess there are not that many more
> interesting archive formats, though.  Can we defer adding
> git-archive-tree until a third archive format command appears?  I won't
> submit another one, I promise. ;-)

I was more worried about possibly having to do --remote once in
each for tar-tree and zip-tree in git-daemon.  The version of
daemon currently in "pu" can allow git-tar-tree to be accessed
from the client via git:// URL.
