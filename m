From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Mon, 10 Jul 2006 18:57:15 -0700
Message-ID: <7v4pxo7vk4.fsf@assigned-by-dhcp.cox.net>
References: <20060710130046.GW29115@pasky.or.cz>
	<20060711005354.5911.62525.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 03:58:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G07V4-0006Rs-Nf
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 03:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWGKB5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 21:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWGKB5Q
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 21:57:16 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:10733 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965045AbWGKB5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 21:57:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711015715.VZHP18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 21:57:15 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060711005354.5911.62525.stgit@machine.or.cz> (Petr Baudis's
	message of "Tue, 11 Jul 2006 02:53:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23681>

Petr Baudis <pasky@suse.cz> writes:

> We used just the blessed() routine so steal it from Scalar/Util.pm. ;-)
> (Unfortunately, Scalar::Util is not bundled with older Perl versions.)

Eh, but aren't we going to rip out the try{}catch{} stuff to
avoid extra closures?
