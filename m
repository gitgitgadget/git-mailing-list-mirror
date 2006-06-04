From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 04 Jun 2006 02:25:24 -0700
Message-ID: <7vk67xclx7.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	<17538.16015.53244.876090@cargo.ozlabs.ibm.com>
	<e5bfff550606040008m4dbf02bdga4f4e6bc2d2fe9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Jun 04 11:25:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmorS-0000XP-HO
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 11:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWFDJZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 05:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFDJZ1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 05:25:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11984 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751104AbWFDJZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 05:25:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604092525.OJEQ19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 05:25:25 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606040008m4dbf02bdga4f4e6bc2d2fe9d@mail.gmail.com>
	(Marco Costalba's message of "Sun, 4 Jun 2006 09:08:24 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21254>

"Marco Costalba" <mcostalba@gmail.com> writes:

> What you suggest we need it's a kind of history of tags.

I do not understand what you mean by "history of tags".  Are you
talking about "tag v1.0.0 was pointing at X commit yesterday but
now today it points at Y commit"?

> And, according to Paul suggestions, not only tags, but merge revisions
> between tags.
>
> A more general and IMHO very powerful tool could be something like
>
> git-rev-list --top-order --parents --selected-only HEAD -- <sha 1>
> <sha 2> .....  <sha n>
>
> Where git rev list gives the history, with modified parents, of the
> given revisions _only_ plus the merging revisions among them.

You completely lost me here.  The '--' markers are to mean "from
here on the parameters are not revisions but are path limiters",
so you are doing something else.  What are these <sha1#1>, <sha1#2>,...
in this?  Are they revisions (i.e. commit object names)?
