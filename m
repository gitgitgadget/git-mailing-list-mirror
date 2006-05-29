From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-diff-tree indicate when it flushes
Date: Mon, 29 May 2006 11:38:31 -0700
Message-ID: <7vejyc8ymw.fsf@assigned-by-dhcp.cox.net>
References: <17530.59395.5611.931858@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 20:38:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkmdX-0001NQ-GY
	for gcvg-git@gmane.org; Mon, 29 May 2006 20:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWE2Sid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 14:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWE2Sid
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 14:38:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38652 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751144AbWE2Sid (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 14:38:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529183832.ZKSG554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 14:38:32 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17530.59395.5611.931858@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Mon, 29 May 2006 22:24:35 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20954>

Paul Mackerras <paulus@samba.org> writes:

> There are times when gitk needs to know that the commits it has sent
> to git-diff-tree --stdin did not match, and it needs to know in a
> timely fashion even if none of them match.  At the moment,
> git-diff-tree outputs nothing for non-matching commits, so it is
> impossible for gitk to distinguish between git-diff-tree being slow
> and git-diff-tree saying no.

Wouldn't this help?

	$ git-diff-tree --stdin --always
