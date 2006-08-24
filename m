From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Wed, 23 Aug 2006 17:17:14 -0700
Message-ID: <7vbqqbgf79.fsf@assigned-by-dhcp.cox.net>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net>
	<115637597423-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 02:17:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG2uQ-0004ZS-W4
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 02:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbWHXARR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 20:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWHXARR
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 20:17:17 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:5564 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965285AbWHXARP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 20:17:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824001714.KOXY21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 Aug 2006 20:17:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DcHE1V00K4Noztg0000000
	Wed, 23 Aug 2006 20:17:14 -0400
To: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <115637597423-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Thu, 24 Aug 2006 01:32:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25937>

Pierre Habouzit <madcoder@debian.org> writes:

> Allow a form of virtualhosting, when %h format is used.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
>     This is intended to be a more flexible solution, that also gives virtual
>     hosting as a bonus. I still see no way to deal with older clients when
>     virtual hosting is used by the admin though, having a "default" hostname
>     won't solve anything at all anyway.

I mildly disagree about the last sentence.  Enabling virtual
hosting does not have to mean all virtual hosts are treated
equal.  It is conceivable that a site hosts the primary,
"collection of public repositories everybody would want to go
to" set, with supplemental ones for specific audiences that are
done via virtual hosting.  General public who would want to
access the primary one can come with older clients that way, and
only the narrower audiences have to be told to upgrade.

The client-side host= support was done post 1.4.0-rc1 timeframe
so we have to be nicer to 1.3 based people, at least give them a
way to slurp newer version with their client ;-).

Haven't looked at the rest of the patch yet.  Will comment
later.
