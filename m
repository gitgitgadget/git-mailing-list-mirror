From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 7/7] cleanups: remove unused variable from exec_cmd.c
Date: Mon, 17 Apr 2006 14:42:35 -0700
Message-ID: <7vzmijkhf8.fsf@assigned-by-dhcp.cox.net>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
	<20060417151448.3130F19B914@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 23:42:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVbUW-0004QG-9J
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 23:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWDQVmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 17:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDQVmh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 17:42:37 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:22931 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751332AbWDQVmh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 17:42:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417214236.JVQJ15986.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 17:42:36 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18838>

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Not sure whether it should be removed, or whether
> execv_git_cmd() should return it rather than -1 at bottom.

The only one that does not just die() upon failure is git.c but
it checks errno itself, so I think removal is fine.
