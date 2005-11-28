From: Junio C Hamano <junkio@cox.net>
Subject: Re: keeping remote repo checked out?
Date: Sun, 27 Nov 2005 23:48:26 -0800
Message-ID: <7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 08:49:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgdkX-0001LT-Ob
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 08:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVK1Hs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 02:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVK1Hs2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 02:48:28 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35802 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932111AbVK1Hs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 02:48:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128074829.XSAP25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 02:48:29 -0500
To: James Cloos <cloos@jhcloos.com>
In-Reply-To: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us> (James Cloos's message
	of "Mon, 28 Nov 2005 02:13:31 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12858>

James Cloos <cloos@jhcloos.com> writes:

> Is it possible to arrange that a push does a checkout on the remote
> the same way a pull does on the local?

Creative use of hooks/post-update would solve that.

However, you should be very careful if you sometimes edit on
server and sometimes push from other machine to the server on
the same branch on the server.
