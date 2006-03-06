From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone does not work with GIT_OBJECT_DIRECTORY set
Date: Sun, 05 Mar 2006 17:33:25 -0800
Message-ID: <7vmzg4cq6y.fsf@assigned-by-dhcp.cox.net>
References: <20060306012115.GG20768@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 02:33:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG4bJ-0005K4-OL
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 02:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWCFBd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 20:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWCFBd1
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 20:33:27 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64411 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751502AbWCFBd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 20:33:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306013210.TEGQ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 20:32:10 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
In-Reply-To: <20060306012115.GG20768@kvack.org> (Benjamin LaHaise's message of
	"Sun, 5 Mar 2006 20:21:15 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17260>

Benjamin LaHaise <bcrl@kvack.org> writes:

> And another bug (linux-2.6.git was created with a clone of git://.../ 
> while GIT_OBJECT_DIRECTORY was set):
>
> $ git clone linux-2.6.git bootcache.git
> fatal: '/home/bcrl/linux-2.6.git/.git': unable to chdir or not a git archive
> fatal: unexpected EOF
> clone-pack from '/home/bcrl/linux-2.6.git/.git' failed.
> $ 

Please try it without GIT_OBJECT_DIRECTORY and see it works
correctly (I think it should).  If that is the case, maybe
git-clone should explicitly unset GIT_OBJECT_DIRECTORY.
