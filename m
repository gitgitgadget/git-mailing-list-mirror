From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] git-daemon support for user-relative paths.
Date: Wed, 02 Nov 2005 01:30:12 -0800
Message-ID: <7v1x1zv1ln.fsf@assigned-by-dhcp.cox.net>
References: <20051101225921.3E7455BF74@nox.op5.se>
	<7vvezb6h4c.fsf@assigned-by-dhcp.cox.net> <4368760E.6030208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 10:31:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXEwl-0004YB-Ht
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 10:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVKBJaP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 04:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVKBJaP
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 04:30:15 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22521 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964888AbVKBJaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 04:30:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102092933.DEDR29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 04:29:33 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4368760E.6030208@op5.se> (Andreas Ericsson's message of "Wed, 02
	Nov 2005 09:17:18 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11017>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>>> -static int log_syslog;
>>>+static int log_syslog = 0;
>> I'd drop this.
>
> No can do. It has to be set either here or down in main. It's nice to 
> have the default in the declaration.

Isn't "static int log_syslog" in BSS to be initialized to zero anyway?

>> I like the general direction this set is taking, but let's let
>> it simmer for a while.
>
> Ok. I'll take that to mean "hold off on the --server-root and --userdir 
> patch for a while" then.

I do not mind keeping it in the proposed updates branch for
people to see and experiment with, but not in the master branch,
at least for now.
