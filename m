From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/12] Diff updates
Date: Fri, 27 May 2005 16:03:26 -0700
Message-ID: <7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 01:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbnpT-0002vJ-Km
	for gcvg-git@gmane.org; Sat, 28 May 2005 01:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVE0XDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 19:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVE0XDa
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 19:03:30 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35804 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262650AbVE0XD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 19:03:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527230327.RPUQ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 19:03:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've said "I am done with diff" twice on this list already.
Aside from unevitable bug reports ;-) I think this time I am
done.  At least the major ones I wanted to do.

Except one thing.  What do you think about the current behaviour
of "diff-cache -p (uncached") in a work tree which was freshly
checked-out, unmodified but you "touch"ed some files to make
them stat-dirty?

I think ancient diff-cache did not report those files, but with
the new "diff --git" headers it will show the "diff --git"
header mentioning those files followed by no content nor mode
changes.  Admittedly this matches the diff-raw output behaviour
more closely, but I find it a bit distracting.  Do you care
about cleaning this up?


