From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Use stringbuf to clean up some string handling code.
Date: Sun, 20 May 2007 03:04:59 -0700
Message-ID: <7v646nq08k.fsf@assigned-by-dhcp.cox.net>
References: <1179627942.32181.1288.camel@hurina>
	<20070520095623.GA3106@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Sirainen <tss@iki.fi>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 12:05:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpiHl-0002sc-B9
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbXETKFD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbXETKFD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:05:03 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39801 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156AbXETKFB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:05:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520100500.WPMR2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 06:05:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1N501X0011kojtg0000000; Sun, 20 May 2007 06:05:00 -0400
In-Reply-To: <20070520095623.GA3106@steel.home> (Alex Riesen's message of
	"Sun, 20 May 2007 11:56:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47812>

Alex Riesen <raa.lkml@gmail.com> writes:

> Timo Sirainen, Sun, May 20, 2007 04:25:42 +0200:
>> ---
>>  commit.c      |   30 +++++++++++++-----------------
>>  local-fetch.c |   34 ++++++++++++++++------------------
>>  2 files changed, 29 insertions(+), 35 deletions(-)
>
> I find it hard to believe that it actually was a cleanup.
>
> It is a nicer code, but... it is bigger, heavier on stack, and it does
> not actually fix anything.
>
> In my experience, such changes are seldom worth the effort. It may be
> a nice code (and I actually like str.[hc]), but its use _must_ be
> justified. I.e. it must simplify a complex formatting routine, or fix
> a bug, which otherwise would be too hard or ugly to fix. It is
> definitely not the case in this patch.

Thanks.  I was kind of waiting for somebody to say that for me
;-)
