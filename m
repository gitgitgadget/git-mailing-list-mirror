From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Mon, 09 Oct 2006 15:52:11 -0700
Message-ID: <7vslhx9k6c.fsf@assigned-by-dhcp.cox.net>
References: <20061007141043.16912.73982.stgit@rover>
	<20061007184418.64881.qmail@web31812.mail.mud.yahoo.com>
	<eg8tpu$drj$1@sea.gmane.org> <20061007191246.GF20017@pasky.or.cz>
	<20061009205551.GO20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 00:52:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX3z2-0004kQ-VL
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 00:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWJIWwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWJIWwQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 18:52:16 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:16530 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751899AbWJIWwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 18:52:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009225212.DNQH16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 18:52:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YNsE1V00S1kojtg0000000
	Mon, 09 Oct 2006 18:52:15 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061009205551.GO20017@pasky.or.cz> (Petr Baudis's message of
	"Mon, 9 Oct 2006 22:55:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28583>

Petr Baudis <pasky@suse.cz> writes:

> This is the count of actions invoked from the tree, commit and
> commitdiff view (using the referer information):
>
>     blame  blob   total requests containing 'a='
> #2  1      18     264
> #1  31     23     399
> #0  4      6      50
>
> The disparation between #2 and #1,#0 is quite apparent. If we want more
> exact results, I will let #0 accumulate data for a week and then revert
> the removal of the links and start another sample.

I am not sure -- you are certainly counting me looking at your
blame output while working on the slimmed down blame output (you
may remember that I noted that while your output gives names and
dates for each line which is busier I kind of liked it in one of
my previous messages), and we talked about gitweb blame lot
recently on the list so that might have spurred people's
curiosity.
