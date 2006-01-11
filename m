From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 16:57:06 -0800
Message-ID: <7v8xtn4m59.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849810.11717.518.camel@brick.watson.ibm.com>
	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	<1136900174.11717.537.camel@brick.watson.ibm.com>
	<43C3CC4A.4030805@op5.se>
	<1136910406.11717.579.camel@brick.watson.ibm.com>
	<7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>
	<1136925066.11717.605.camel@brick.watson.ibm.com>
	<Pine.LNX.4.63.0601102200040.31923@wbgn013.biozentrum.uni-wuerzburg.de>
	<43C44CF2.5050808@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 01:57:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwUIb-0004JX-Ix
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 01:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWAKA5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 19:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWAKA5K
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 19:57:10 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12208 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932355AbWAKA5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 19:57:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111005600.HDGX6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 19:56:00 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C44CF2.5050808@op5.se> (Andreas Ericsson's message of "Wed, 11
	Jan 2006 01:10:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14470>

Andreas Ericsson <ae@op5.se> writes:

> Johannes Schindelin wrote:

>> Wouldn't it make much more sense to have a switch in the Makefile,
>> which says *if* we have a libexec/ directory?
>
> No, it wouldn't, because then we can't use a different release of the
> git-tools without re-compiling the potty.

True, but *please* stop calling "git wrapper" a potty.  It gives
me an impression that it is not connected to the plumbing.

I do not do Porcelain, but I do not do plastics nor glass either
;-).

Thanks.
