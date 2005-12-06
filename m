From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Mon, 05 Dec 2005 19:17:58 -0800
Message-ID: <7vacfe9amx.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	<7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	<7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	<20051205231203.GG22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 04:20:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjTLR-00082g-7V
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 04:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbVLFDSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 22:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbVLFDSE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 22:18:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40587 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751543AbVLFDSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 22:18:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206031803.XOGB25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 22:18:03 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13250>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Mon, Dec 05, 2005 at 09:22:42PM CET, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> new file mode 100644
>
> What about compat/util.h or something? Nicer, shorter, and takes
> advantage of this fancy hierarchical namespace "directories" invention.
> ;-)

While I would appreciate a better name, I am afraid that is not a
particularly good one.  It is not "compatibility utilities", but
compat things and util things mixed together, so it does not
belong to compat/ directory to begin with.  die() and friends
are not about compatibility at all.
