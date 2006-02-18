From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rev-parse: Fix --short= option parsing
Date: Fri, 17 Feb 2006 22:50:20 -0800
Message-ID: <7v7j7tupn7.fsf@assigned-by-dhcp.cox.net>
References: <20060218011053.GB2562@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 07:50:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FALvI-0007CT-4N
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 07:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWBRGuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 01:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWBRGuW
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 01:50:22 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35503 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750919AbWBRGuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 01:50:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218064733.TBQL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 01:47:33 -0500
To: Jonas Fonseca <fonseca@diku.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16390>

Thanks.  I queued the two fixes from you.

They will first appear in "next" and also in 1.2.2.

> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>
> ---
> commit 013b99654ee464856d266a72f0203d0fee2b0d11
> tree 3c961d6ebb8b9805ee3950ec081679de15f5a9ba
> parent 16e2efc524d181cf46dcb252532139a0aff4a28f
> author Jonas Fonseca <fonseca@diku.dk> Sat, 18 Feb 2006 02:05:11 +0100
> committer Jonas Fonseca <fonseca@antimatter.localdomain> Sat, 18 Feb 2006 02:05:11 +0100

BTW, what git-based tool do you use to spit out this ugly format?
Full object name of the parent commit is useful only if the
recipient has that object, and it is not one of mine, so it is
unlikely nobody but you would have it.  Name of the tree is what
you would get _after_ applying this patch, so it also is not
very useful for e-mail communication.
