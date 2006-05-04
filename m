From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WARNING] please stop using git.git "next" for now
Date: Wed, 03 May 2006 17:46:42 -0700
Message-ID: <7vwtd2aa6l.fsf@assigned-by-dhcp.cox.net>
References: <7virombwro.fsf@assigned-by-dhcp.cox.net>
	<7vejzabt2b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 04 02:46:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbRzS-0002hJ-HI
	for gcvg-git@gmane.org; Thu, 04 May 2006 02:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWEDAqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 20:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWEDAqn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 20:46:43 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30647 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750828AbWEDAqn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 20:46:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504004642.MFCW18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 May 2006 20:46:42 -0400
To: git@vger.kernel.org
In-Reply-To: <7vejzabt2b.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 03 May 2006 16:13:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19540>

Junio C Hamano <junkio@cox.net> writes:

>> I will be working on a fix now, but in the meantime please do
>> not use the "next" branch for real work.  Sorry for the
>> breakage.
>
> Two-way merge by read-tree forgot to invalidate the directories
> a new element was added underneath.  The fix is simple and will
> be in the "next" I'll push out tonight.

OK, done.  Will be looking into "binary grep segfault" problem
next.
