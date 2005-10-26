From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git_progname
Date: Tue, 25 Oct 2005 23:07:13 -0700
Message-ID: <7v1x28bylq.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
	<7v1x2cyplw.fsf@assigned-by-dhcp.cox.net> <435DF6DA.6010205@op5.se>
	<20051025093150.GB30889@pasky.or.cz> <435E1307.3090209@op5.se>
	<435E2ABA.8030907@op5.se> <20051025133208.GC30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 08:08:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUeRa-0000uC-13
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 08:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbVJZGHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 02:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVJZGHQ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 02:07:16 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45717 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932551AbVJZGHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 02:07:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026060652.QAOM4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 02:06:52 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051025133208.GC30889@pasky.or.cz> (Petr Baudis's message of
	"Tue, 25 Oct 2005 15:32:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10647>

Petr Baudis <pasky@suse.cz> writes:

> No, I didn't mean the oneliner at all, actually - just the notion that
> you stealthily hijack main(). We'll see what Junio thinks about it. ;)

May I just say "yuck"?

I think what you suggested makes the most sense.

>> So I'd say just add setup_progname("foo") at the start of your main().
