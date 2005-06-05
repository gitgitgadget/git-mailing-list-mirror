From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile for 1.0
Date: Sun, 05 Jun 2005 16:45:54 -0700
Message-ID: <7vzmu4weod.fsf@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
	<7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 01:43:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df4lF-0001I8-FN
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 01:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVFEXqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 19:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVFEXqB
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 19:46:01 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43209 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261635AbVFEXp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 19:45:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605234553.QNGN8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 19:45:53 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 05 Jun 2005 16:21:06 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I did not mention git-sync by Jason McMullan on my list of "what
I want to have in 1.0", but that was not because I object to the
idea of having a sync mechanism that knows and takes advantage
of how GIT works.  Quite the contrary.

I would like to see such a GIT specific smart sync mechanism
some day.  git-http-pull lets us use a dumb server and cannot
assume server-side smarts, git-local-pull operates in an
environment where latency does not matter, but git-ssh-pull and
git-sync are solutions for the real network environment where
latency matters, and having a smart sync mechanism is a big win.

I just do not feel, judging from its current protocol command
set, it offers enough improvements over what git-ssh-push/pull
pairs already give us; I'd be happy to be corrected, of course,
if this is a misconception.

