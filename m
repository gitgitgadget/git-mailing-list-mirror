From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Thu, 06 Oct 2005 17:51:53 -0700
Message-ID: <7virwa5ety.fsf@assigned-by-dhcp.cox.net>
References: <20051005214447.GF15593@reactrix.com>
	<Pine.LNX.4.63.0510061550510.23242@iabervon.org>
	<20051007000041.GH15593@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 02:55:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENgV5-00013a-Cg
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 02:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVJGAwU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 20:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJGAwU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 20:52:20 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60301 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751266AbVJGAwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 20:52:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007005143.PYFF29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 20:51:43 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051007000041.GH15593@reactrix.com> (Nick Hengeveld's message
	of "Thu, 6 Oct 2005 17:00:41 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9793>

Nick Hengeveld <nickh@reactrix.com> writes:

> About that "-r" arg - seems like it should be something else as -r is
> used elsewhere in git to enable recursion.  "-c" was my first thought,
> but that's used to fetch commit objects.

Well, I'd suggest just to hardcode a reasonable value to be a
good net citizen, and not make it configurable.  Four, perhaps?

OTOH, we may want to have an option to disable parallel from the
command line (I think -r 1 would mean that with yours).

If we really want to have the number of parallel configurable,
and -r implies recursive as you say, maybe '-j' to mimic
parallel make?
