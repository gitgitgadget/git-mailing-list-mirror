From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] checkout-cache fix
Date: Thu, 12 May 2005 12:54:17 -0700
Message-ID: <7vekccfceu.fsf@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	<20050510230357.GF26384@pasky.ji.cz>
	<7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
	<118833cc050511113122e2d17d@mail.gmail.com>
	<7vpsvxqwab.fsf@assigned-by-dhcp.cox.net>
	<7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
	<20050511224044.GI22686@pasky.ji.cz>
	<7voebhnwey.fsf_-_@assigned-by-dhcp.cox.net>
	<20050512193838.GE324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 21:47:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJe9-0000Kr-8J
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVELTyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVELTyq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:54:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3530 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262016AbVELTyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 15:54:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512195419.HLHB22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 15:54:19 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050512193838.GE324@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 12 May 2005 21:38:38 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> ... I've already seen something like this
PB> in one commit merged from git-jc (IIRC some of the Ingo Molnar's leak
PB> fixes),...

Yes, I am very unhappy about that commit, too.  I was mucking
with jit-commit command at the time, and apparently used a buggy
one to make that commit---I realized what happened much later
when I reviewed the commit log and it was already too late (I
told everybody that the tree is published and pullable by then).

Sorry about that.

