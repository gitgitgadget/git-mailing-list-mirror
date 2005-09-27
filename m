From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 00:46:36 -0700
Message-ID: <7vll1j2bs3.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 09:47:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKAAk-0001ur-RE
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 09:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVI0Hqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 03:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVI0Hqi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 03:46:38 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36787 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964852AbVI0Hqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 03:46:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927074636.PYPQ2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 03:46:36 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926212536.GF26340@pasky.or.cz> (Petr Baudis's message of
	"Mon, 26 Sep 2005 23:25:36 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9379>

Petr Baudis <pasky@suse.cz> writes:

> If it's NOT a commit, well, that's a question.  On the assumption that
> it won't be a great deal of data and it's likely to be assumed that we
> have it, I would be inclined to fetching it, but I don't feel strongly
> about it.

v2.6.11 tag is not a commit but presumably it would slurp in a
lot of data.
