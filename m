From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on "status -v"
Date: Fri, 10 Feb 2006 14:12:21 -0800
Message-ID: <7v7j82vp6i.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602081726390.2458@g5.osdl.org>
	<7vmzgzy46f.fsf@assigned-by-dhcp.cox.net>
	<87u0b7uf91.wl%cworth@cworth.org>
	<7vaccyx6ne.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602101333570.19172@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 23:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7gVJ-0007Tt-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 23:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWBJWMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 17:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWBJWMX
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 17:12:23 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48793 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932223AbWBJWMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 17:12:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210221114.DYNW15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 17:11:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101333570.19172@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 10 Feb 2006 13:35:05 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15892>

Linus Torvalds <torvalds@osdl.org> writes:

> I think I agree. Especially if doing "git commit -v", the _top_ of the 
> status message is what you'd normally be most aware of. I think. 

Well the exactly same reasoning on my part, who keeps tons of
untracked files in his repository, left the patch output there.
Otherwise I have to scroll off a long "untracked files" list to
get to the patch ;-).

But even with that gripe, I'd agree that patch at the end would
be a better choice.  The user asked for a patch so she wouldn't
fail to see it even if many '#' lines precede the patch.  With
the current ordering, '#' lines will most likely be ignored.
