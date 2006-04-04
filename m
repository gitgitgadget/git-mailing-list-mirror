From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Solaris needs strings.h when using index().
Date: Tue, 04 Apr 2006 11:18:20 -0700
Message-ID: <7vwte56w7n.fsf@assigned-by-dhcp.cox.net>
References: <20060404123603.GA14071@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 20:18:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQq6m-0001zO-G9
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 20:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDDSSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWDDSSX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 14:18:23 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7837 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750786AbWDDSSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 14:18:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404181822.IFMW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 14:18:22 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20060404123603.GA14071@bohr.gbar.dtu.dk> (Peter Eriksen's
	message of "Tue, 4 Apr 2006 14:36:03 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18400>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> From: Peter Eriksen <s022018@student.dtu.dk>
> Date: Tue Apr 4 14:33:14 2006 +0200
> Subject: [PATCH] Solaris needs strings.h when using index().
>
> Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>

I think somebody else noticed this the other day but I'm
undecided if it is easier to replace use of index with strchr,
since we include <string.h> and use strchr() everywhere.
