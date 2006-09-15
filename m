From: Junio C Hamano <junkio@cox.net>
Subject: Re: bare repositories: packing and fetching
Date: Fri, 15 Sep 2006 13:44:15 -0700
Message-ID: <7vzmd0g8rk.fsf@assigned-by-dhcp.cox.net>
References: <450AEB37.3090909@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 22:44:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOKXx-0003C9-UH
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 22:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWIOUoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 16:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWIOUoS
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 16:44:18 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23237 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932239AbWIOUoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 16:44:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060915204416.CMDL2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 15 Sep 2006 16:44:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Nkk41V00P1kojtg0000000
	Fri, 15 Sep 2006 16:44:04 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <450AEB37.3090909@shadowen.org> (Andy Whitcroft's message of
	"Fri, 15 Sep 2006 19:04:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27099>

Andy Whitcroft <apw@shadowen.org> writes:

> I was trying to make a bare repo to stage linus' main tree.  As this was
> only to be a local tree for others to pull from I thought that I could
> clone his tree 'bare' and then fetch into that on a regular basis.  That
> does not appear to be the case?  Both git fetch and git repack say 'not
> a git repository .git' and bail.
>
> Is this expected behaviour.  Do I have to have all the checked out files?

cd $that_repository && GIT_DIR=. git fetch
