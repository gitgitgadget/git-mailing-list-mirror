From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add script for patch submission via e-mail.
Date: Tue, 05 Jul 2005 08:20:13 -0700
Message-ID: <7vekadfff6.fsf@assigned-by-dhcp.cox.net>
References: <7vll5h7k5t.fsf@assigned-by-dhcp.cox.net>
	<20050705093441.GD6191@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 17:25:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DppH8-0005JK-4o
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 17:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVGEPXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 11:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVGEPXP
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 11:23:15 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14554 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261838AbVGEPUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 11:20:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050705152014.OXNW12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 5 Jul 2005 11:20:14 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050705093441.GD6191@pasky.ji.cz> (Petr Baudis's message of "Tue, 5 Jul 2005 11:34:41 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@suse.cz> writes:

PB> Any reason why this was not applied? It appears kind of cool.

FYI, the one in <7vll4s47p3.fsf_-_@assigned-by-dhcp.cox.net> is
newer than what you quoted.

One thing _I_ am unhappy about what it does is that it does not
try to be intelligent about merges (I haven't tried the script
on a merged head myself).

When you think about "project lead" vs "individual developer"
modes of operation, the latter is primarily "keep rebasing
commits in my fork and re-throwing them upstream until some of
them stick", so not supporting merges specially would not be so
big a flaw.  However, at least it should use --merge-order to
get the epochs decomposed right, in order to produce anything
remotely useful when dealing with a merged head.
