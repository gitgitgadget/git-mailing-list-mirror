From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] parse_date(): fix parsing 03/10/2006
Date: Tue, 04 Apr 2006 23:26:36 -0700
Message-ID: <7virpo4jxf.fsf@assigned-by-dhcp.cox.net>
References: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net>
	<20060404231606.219a4cc5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 08:27:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR1Tv-0001ds-3i
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 08:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWDEG0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 02:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWDEG0l
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 02:26:41 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55478 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751005AbWDEG0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 02:26:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405062638.MCBF25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 02:26:38 -0400
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060404231606.219a4cc5.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 4 Apr 2006 23:16:06 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18417>

Andrew Morton <akpm@osdl.org> writes:

> But there was a second problem.  Once the parsing had misbehaved, Len
> managed to create a commit which was six months in the future:
>
> commit 8313524a0d466f451a62709aaedf988d8257b21c
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Tue Oct 3 00:00:00 2006 -0400
>
>     ACPI: ACPICA 20060310
>
> Will your fix prevent that from happening?  If not, perhaps some basic
> sanity checking might be appropriate.

You _might_ get an e-mail to fix kernel problems from yourself
in the future, in which case you would want to commit with
future author date, like this ;-).

People would often deal with dates in the past (way in the past
when talking about importing foreign SCM history), but probably
it would never make sense to do dates way into the future.  I'll
think about it.
