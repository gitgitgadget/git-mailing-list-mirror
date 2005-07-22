From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 14:20:15 -0700
Message-ID: <7vhdempmgg.fsf@assigned-by-dhcp.cox.net>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
	<20050722181800.GU20369@mythryan2.michonline.com>
	<7vsly6vd2b.fsf@assigned-by-dhcp.cox.net> <42E1571B.8070108@gmail.com>
	<Pine.LNX.4.58.0507221340450.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:34:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4x5-0003RE-Nn
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVGVVU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVGVVU3
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:20:29 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56016 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262185AbVGVVUU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 17:20:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722212015.THUA18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 17:20:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507221340450.6074@g5.osdl.org> (Linus Torvalds's message of "Fri, 22 Jul 2005 13:43:17 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Just teach "parse_commit()" to look at a ".git/fake_parents" file, and 
> insert fake extra parents for commits that way - you can graft any tree on 
> top of any other tree that way, and it's probably a nice idea for testing 
> things out.

Nicely put, thanks.  That was exactly what I meant by
"grafting".

And the file would obviously be per-project, so according to
Pasky's suggestion that would be ".gitinfo/fake_parents" ;-).
