From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 16:35:48 -0700
Message-ID: <7v8xjlksyz.fsf@assigned-by-dhcp.cox.net>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
	<egmdkv$k33$1@sea.gmane.org> <20061012224727.GU20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 01:36:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYA5n-00019U-KH
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 01:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWJLXfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJLXfu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 19:35:50 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63200 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751319AbWJLXfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 19:35:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012233549.JGMK26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 19:35:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zbbe1V00M1kojtg0000000
	Thu, 12 Oct 2006 19:35:39 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061012224727.GU20017@pasky.or.cz> (Petr Baudis's message of
	"Fri, 13 Oct 2006 00:47:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28820>

Petr Baudis <pasky@suse.cz> writes:

> But please, let's not go right back to the git-annotate / git-blame
> situation. It's just confusing to have two tools that do the same thing,
> perhaps subtly differently. If it's gonna replace git-blame, it should
> either do that right away or live as git-blame2 for some time, but not
> play any confusing games with the names.

Actually the plan is to make it do _true_ pickaxe, although it
will most likely end up either in dustbin or replace blame.
