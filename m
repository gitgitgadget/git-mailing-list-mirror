From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-blame: Use the same tests for git-blame as for git-annotate
Date: Sun, 05 Mar 2006 16:19:52 -0800
Message-ID: <7vzmk4ctlj.fsf@assigned-by-dhcp.cox.net>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
	<440B751F.5000801@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 01:20:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG3S9-0006wu-Gq
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 01:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWCFATy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 19:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWCFATy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 19:19:54 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:55281 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750802AbWCFATy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 19:19:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306001838.SHDU3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 19:18:38 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <440B751F.5000801@michonline.com> (Ryan Anderson's message of
	"Sun, 05 Mar 2006 18:32:47 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17253>

Ryan Anderson <ryan@michonline.com> writes:

> Along these lines, if anyone can pin down the complicated cases that
> annotate and blame get differently, adding them as a test would be
> *exceedingly* appreciated, even if it makes annotate (or blame) fail for
> a bit, it gives us something to work against.

In the t/trash repository, "git-annotate file master" and
"git-annotate file master^" behaves funkily.

OTOH "git-blame file master" assigns everything to that commit
while only the last two lines are attributable to it.  Needs a
bit more work on both sides ;-).
