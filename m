From: Junio C Hamano <junkio@cox.net>
Subject: Re: Howto get the merge-base ?
Date: Sun, 14 May 2006 10:44:53 -0700
Message-ID: <7v3bfc33hm.fsf@assigned-by-dhcp.cox.net>
References: <4fb292fa0605141021r20cefaa0he592b9c713ede333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 19:44:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfKeE-0007nA-1P
	for gcvg-git@gmane.org; Sun, 14 May 2006 19:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWENRov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 13:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWENRov
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 13:44:51 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:23444 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751499AbWENRou (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 13:44:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514174449.GEVF15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 13:44:49 -0400
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605141021r20cefaa0he592b9c713ede333@mail.gmail.com>
	(Bertrand Jacquin's message of "Sun, 14 May 2006 19:21:01 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19973>

"Bertrand Jacquin" <beber.mailing@gmail.com> writes:

> I'm trying to know which commit it the parent of a merge.
> For exemple if I do that :
>
>   o Merge
>  / \
> /   \
> |   |
> |   o Commit D
> |   |
> |   o Commit C
> |   |
> o   | Commit B
> \  /
>  \/
>  o Commit A
>  |
>  o Init
>
> How could I know that ``Commit A'' is the merge-base of ``Merge'' ?

> I try to get this git-merge-base but result is strange and quiet
> mysterious as he return me always second args I passed to.

It is mysterious to me because you did not say what you gave as
arguments ;-).

If I am reading you correctly, you already have a "Merge"
commit, made by you or somebody else, and are trying to figure
out where the merge base was.  If that is the case:

	git-merge-base Merge^1 Merge^2

in other words

	git-merge-base CommitB CommitD        

is what you are looking for?

But what do you need that information for?  To reproduce
somebody else's merge?
