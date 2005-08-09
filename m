From: Junio C Hamano <junkio@cox.net>
Subject: Re: use of temporary refs in resolve
Date: Mon, 08 Aug 2005 19:48:24 -0700
Message-ID: <7v1x53zuyv.fsf@assigned-by-dhcp.cox.net>
References: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
	<tnxk6iwx161.fsf@arm.com> <7vfytkdcgm.fsf@assigned-by-dhcp.cox.net>
	<tnxr7d4vi5v.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 04:48:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2KAH-0006t1-EF
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 04:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVHICs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 22:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHICs1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 22:48:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50941 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932418AbVHICs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 22:48:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809024825.MBYX8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 22:48:25 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> OK, I wasn't that clear. Currently git-fetch-script stores the fetched
> head in the FETCH_HEAD file and git-pull-script uses this file to do
> the merging (by passing its content to git-resolve-script).

Correct.  I was not planning to change that arrangement.

> Anyway, I
> can easily change StGIT to only use git-pull-script directly, without
> the intermediate fetch.

If you are happy then I should not complain ;-), and I am
certainly not complaining, but I still have this feeling that I
do not get what you are getting at.  You can change it to
directly use pull without intermediate fetch, in order to cope
with what?  Could you explain how you currently do things, and
what changes I will be making would break the way you currently
do things please?  I need to know which detail of the current
implementation behaviour people rely on to avoid breaking
things.
