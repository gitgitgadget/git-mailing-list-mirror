From: Junio C Hamano <junkio@cox.net>
Subject: Re: rebasing trouble
Date: Thu, 29 Jun 2006 13:04:25 -0700
Message-ID: <7vd5crranq.fsf@assigned-by-dhcp.cox.net>
References: <20060629194723.GD14287@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 22:05:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw2ka-0008Re-SP
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWF2UE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWF2UE3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:04:29 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:57073 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932354AbWF2UE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 16:04:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629200426.JWOU8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 16:04:26 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060629194723.GD14287@fieldses.org> (J. Bruce Fields's message
	of "Thu, 29 Jun 2006 15:47:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22896>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> I must be missing something obvious:
>
> bfields@puzzle:linux-2.6$ git checkout -b TMP nfs-client-stable^^^
> bfields@puzzle:linux-2.6$ git-describe
> v2.6.17-rc6-g28df955
> bfields@puzzle:linux-2.6$ git-rebase --onto v2.6.17 origin
> Nothing to do.
> bfields@puzzle:linux-2.6$ git-describe
> v2.6.17
>
> So the git-rebase just reset TMP to v2.6.17.  But I know that nfs-client-stable
> isn't a subset of origin, so this doesn't make sense to me.
>
> The tree in question is actually at git://linux-nfs.org/~bfields/linux.git, if
> it matters.

It matters of course.  Where is the "origin"?
 
