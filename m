From: Junio C Hamano <junkio@cox.net>
Subject: Re: Can GIT_EXEC_PATH behave more like PATH?
Date: Wed, 07 Dec 2005 11:21:14 -0800
Message-ID: <7vzmncpvbp.fsf@assigned-by-dhcp.cox.net>
References: <20051207141218.GA721@igloo.ds.co.ug>
	<7v4q5kra80.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 20:23:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek4qz-0004aL-Gn
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 20:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbVLGTVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 14:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbVLGTVR
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 14:21:17 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:51652 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030316AbVLGTVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 14:21:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207192040.ZWHL3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 14:20:40 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q5kra80.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 07 Dec 2005 11:14:07 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13341>

Junio C Hamano <junkio@cox.net> writes:

> When users use "git frotz", the git command internally knows
> where the right version of subcommands are stored.  When reason
> you would want to override that, you would exactly know one
> directory with which you want to override it.  You do not want
> GIT_EXEC_PATH="/usr/lib/git-1.02:/usr/lib/git" in such a case,
> either.

OOPS.  That did not parse so well.  "... When you would want to
override that for whatever reason, you would..."
