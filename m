From: Junio C Hamano <junkio@cox.net>
Subject: Re: Remove "historical" objects from repository to save place
Date: Sat, 21 Jan 2006 11:58:55 -0800
Message-ID: <7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net>
References: <200601212218.51055.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:59:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Ot2-0000j2-Ax
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWAUT65 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWAUT65
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:58:57 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29846 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932305AbWAUT65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 14:58:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121195642.UMOB26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 14:56:42 -0500
To: Andrey Borzenkov <arvidjaar@mail.ru>
In-Reply-To: <200601212218.51055.arvidjaar@mail.ru> (Andrey Borzenkov's
	message of "Sat, 21 Jan 2006 22:18:50 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15011>

Andrey Borzenkov <arvidjaar@mail.ru> writes:

> Description of git-prune suggests that it may be possible by removing tags 
> from refs/tags

If the documentation suggests that, then it is misleading.

> OTOH I may have commit chain that will prevent them.

Correct.

> Also 
> won't those tags come back after git fetch --tags?

Correct.

You might be able to cauterize the history at a specific commit
and then re-clone.  I've talked about how in "[QUESTION] about
.git/info/grafts file" thread yesterday, so I won't repeat that.
