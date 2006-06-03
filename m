From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sat, 03 Jun 2006 09:50:46 -0700
Message-ID: <7vy7wedvyx.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<17537.32585.260926.48759@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 18:50:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmZKt-0007Xz-8J
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 18:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWFCQus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 12:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWFCQus
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 12:50:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21377 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751731AbWFCQur (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jun 2006 12:50:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060603165046.ZKR19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Jun 2006 12:50:46 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17537.32585.260926.48759@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sat, 3 Jun 2006 22:23:37 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21200>

Paul Mackerras <paulus@samba.org> writes:

> ...  I think that with heads, you
> would want to see all the descendent heads, rather than just the
> nearest ones (those that aren't descendents of another descendent
> head) as I do with tags.  What do you think?  If one head is a
> descendent of another, and both are descendents of the selected
> commit, should I show both?

That would be useful I think.

>> BTW, what's the maintenance/rewind policy on the "new" branch of
>> gitk.git?  If you are never going to rewind it, I could pull it
>> in "next" (and keep pulling your "master" in my "master") for
>> wider exposure if you like.
>
> I intend to pull "new" into "master" shortly, assuming I don't get any
> bug reports for the "new" branch. :)
>
> If you pull my "new" into your "next", and you then pull your "next"
> into your "master", and I pull my "new" into my "master", and you pull
> my "master" into your "master", won't we end up with duplicate merges?

Yes, but I rarely if ever pull "next" as a whole into "master".
