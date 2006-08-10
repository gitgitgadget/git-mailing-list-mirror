From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Wed, 09 Aug 2006 22:05:04 -0700
Message-ID: <7vu04lxjsv.fsf@assigned-by-dhcp.cox.net>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
	<20060810033448.GH8776@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 07:05:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB2jQ-0006vx-5t
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 07:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWHJFFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 01:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWHJFFH
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 01:05:07 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39853 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161030AbWHJFFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 01:05:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810050505.RCCK27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 01:05:05 -0400
To: Willy Tarreau <w@1wt.eu>
In-Reply-To: <20060810033448.GH8776@1wt.eu> (Willy Tarreau's message of "Thu,
	10 Aug 2006 05:34:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25153>

Willy Tarreau <w@1wt.eu> writes:

> I encountered a problem in 1.4.1 and 1.4-git about 2 weeks ago
> (I've not tried 1.4.2-rc4 yet). When applying a git patch which
> contains a symlink, the symlink created on the filesystem sometimes
> has a wrong name with some chars appended to its end.

Thanks.  I can reproduce this, and am looking into it.
