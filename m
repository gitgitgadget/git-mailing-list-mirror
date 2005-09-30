From: Junio C Hamano <junkio@cox.net>
Subject: Re: Edit log message after commit
Date: Fri, 30 Sep 2005 01:24:29 -0700
Message-ID: <7vfyrn6k02.fsf@assigned-by-dhcp.cox.net>
References: <dhfjcu$36f$1@sea.gmane.org> <dhg5vl$9ac$1@sea.gmane.org>
	<87br2bq2ot.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 10:26:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELGC7-0001bo-EU
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 10:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVI3IYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 04:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVI3IYb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 04:24:31 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55708 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932471AbVI3IYb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 04:24:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930082426.JTJH29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 04:24:26 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87br2bq2ot.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Fri, 30 Sep 2005 01:05:54 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9548>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> first, create new branch at where you wanna change the message
>
>     git checkout -b temp HEAD^^^   # hmm... HEAD^3 doesn't work

Because it should be spelled HEAD~3.  HEAD^3 is "the third
parent of HEAD" and usually does not exist, unless you are
talking about an Octopus merge of three or more branches.
