From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Importing from a patch-oriented SCM
Date: Fri, 19 Aug 2005 00:49:43 -0700
Message-ID: <7vslx61i3s.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050819000417ed436e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 09:51:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E61dY-00081b-O1
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 09:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVHSHtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 03:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVHSHtp
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 03:49:45 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17808 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964908AbVHSHto (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 03:49:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819074943.YZAV8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 03:49:43 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050819000417ed436e@mail.gmail.com> (Martin Langhoff's
	message of "Fri, 19 Aug 2005 19:04:24 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> If I remember correctly, Junio added some stuff in the merge & rebase
> code that will identify if a particular patch has been seen and
> applied, and skip it even if it's a bit out of order. But I don't know

I think you are talking about git-patch-id.

f97672225b3b1a2ca57cfc16f49239bed1efcd87
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Thu Jun 23 15:06:04 2005 -0700

    Add "git-patch-id" program to generate patch ID's.

    A "patch ID" is nothing but a SHA1 of the diff associated
    with a patch, with whitespace and line numbers ignored.  As
    such, it's "reasonably stable", but at the same time also
    reasonably unique, ie two patches that have the same "patch
    ID" are almost guaranteed to be the same thing.

    IOW, you can use this thing to look for likely duplicate
    commits.
