From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb "tag" display
Date: Sat, 06 Aug 2005 11:49:13 -0700
Message-ID: <7vpssq7vfa.fsf@assigned-by-dhcp.cox.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
	<20050806033654.GA27953@vrfy.org>
	<7vacju9az9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 20:50:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1Tjh-0005Ow-4V
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 20:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVHFStQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 14:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbVHFStQ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 14:49:16 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:41414 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261185AbVHFStP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 14:49:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806184913.ITXF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 14:49:13 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <7vacju9az9.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 06 Aug 2005 11:27:54 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> A git tag object can have its own text contents, but I do not
> see how I can get to it from gitweb.  

I just realized that this is also unavailable in gitk, so please
consider this as a feature request to gitk as well.

If you can pop-up a temporary window that shows the tag contents
when I hover over a tag icon for 2 seconds, and remove that
temporary window when step outside it would be ideal.  It is up
to you to implement the part to show my wife's picture, reading
"object-content-type: image/jpeg" thing ;-).  That one was not a
serious request.

I have two more requests to gitk, which are related to each
other but not related to the "tag contents" one above:

 - if "gitk --all" slurped not just refs/heads and refs/tags but
   everything under refs/* recursively, that would help
   visualizing the bisect status.  bisect creates bunch of
   commit object names in refs/bisect.

 - I have not looked at the code closely enough, but I cannot
   find how to re-read references.  I would appreciate it if it
   allowed it.  This relates to the bisect status visualization,
   where the set of references changes _after_ the user started
   gitk.
