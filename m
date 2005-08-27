From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 00:08:17 -0700
Message-ID: <7vwtm726xq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 09:08:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8unn-0000Nn-NN
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 09:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVH0HIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 03:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVH0HIT
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 03:08:19 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33476 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030329AbVH0HIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2005 03:08:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827070819.XEWU7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 27 Aug 2005 03:08:19 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508270151590.23242@iabervon.org> (Daniel
	Barkalow's message of "Sat, 27 Aug 2005 02:07:17 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7844>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Part of threeway_merge, however, wants to search the rest of the cache for
> interfering entries in some cases, which would have to happen differently,
> because I won't have the cache completely filled out beforehand. I'm
> trying to figure out what the comments are talking about, and they seem to
> refer to a list of the possible cases. Is that list somewhere convenient?

Please look for END_OF_CASE_TABLE in t/t1000-read-tree-m-3way.sh;
the table talks about some of the (ALT) not implemented, but
some of them are ("git whatchanged t/t1000-read-tree-m-3way"
would tell you which).

Two way cases are described in Documentation/git-read-tree.txt,
if you care.  If you were not touching the three-way case right
now, I'd move/copy the three way cases there as well, but that
can wait until after your changes.
