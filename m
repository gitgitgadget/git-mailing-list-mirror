From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support username and password inside URL
Date: Thu, 24 Nov 2005 14:14:15 -0800
Message-ID: <7vbr09n16w.fsf@assigned-by-dhcp.cox.net>
References: <87u0e71zpx.fsf@litku.valo.iki.fi>
	<873blriqh0.fsf@litku.valo.iki.fi>
	<7vwtj3xe72.fsf@assigned-by-dhcp.cox.net>
	<87d5kraxsr.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 23:16:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfPMV-0004Wh-Sn
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 23:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbVKXWOS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 17:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbVKXWOS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 17:14:18 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:3555 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161052AbVKXWOS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 17:14:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124221307.JAVK26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 17:13:07 -0500
To: Kalle Valo <Kalle.Valo@iki.fi>
In-Reply-To: <87d5kraxsr.fsf@litku.valo.iki.fi> (Kalle Valo's message of "Wed,
	23 Nov 2005 22:56:04 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12718>

Kalle Valo <Kalle.Valo@iki.fi> writes:

> Actually I'm going to be only user of the private git repository and
> it's going to be permanent. I have multiple computers in different
> locations (servers, workstations, laptops) and I would like to
> distribute my private files (configuration files, scripts etc.) to all
> of them using git.

Fair enough.  Is "git-push ssh://these.machines/" (or from
these.machines "git-fetch ssh://mother.ship/") more trouble than
having HTTP server on your mother ship machine?

> ... The problem with randomized URL (like you
> suggested) is that if some person or a search engine finds the URL
> somehow, then there's nothing stopping the information leak.

Hmph.  I had an impression that the obscure URL scheme like in
my example http://members.cox.net/junkio/r0ZIEF/5S54m/ is as
robot safe as auth embedding URL.  That is, if somebody feeds
auth-embedding URL to robots I suspect they can follow it just
fine.  Of course obscure URL needs to be protected by forbidding
dirindex at higher level directories and not posting it to
public forum [*1*], for the same reason you have to keep the
auth embedding URL from public.

[Footnote]

*1* I suspect some robots have already tried to harvest what is
found at that URL since I posted the message to the list.
