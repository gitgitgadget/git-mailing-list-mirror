From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Show URL in the "Getting <foo> list" http-fetch messages
Date: Fri, 11 Nov 2005 17:17:42 -0800
Message-ID: <7vwtjeis09.fsf@assigned-by-dhcp.cox.net>
References: <20051112004958.21857.95728.stgit@machine.or.cz>
	<20051112005803.GZ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 02:18:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eak1c-0002sR-04
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 02:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVKLBRo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 20:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVKLBRo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 20:17:44 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51593 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750881AbVKLBRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 20:17:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051112011636.JHXA24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 20:16:36 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051112005803.GZ30496@pasky.or.cz> (Petr Baudis's message of
	"Sat, 12 Nov 2005 01:58:03 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11656>

Petr Baudis <pasky@suse.cz> writes:

> By the way, this is only a pathetic remnant of my brave effort to get
> rid of seeing the "Getting alternates list" message on the same
> repository 20 times now since the parallel fetching got introduced.
> I know how to do silence the messages, but doing the _fetching_ itself
> seems as downright stupid thing in the first place.
>
> Therefore, can I somehow stall fetching of an object? The idea is:
>
> 	I want to check the alternates list!
> 	I don't have it yet...
> 	...but a request for it is already queued. Ok, I'll wait.

I agree, and probably this applies when index request is in
transit as well.
