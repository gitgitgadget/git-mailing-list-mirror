From: Junio C Hamano <junkio@cox.net>
Subject: Re: Couple of read-tree questions
Date: Wed, 31 Aug 2005 22:52:51 -0700
Message-ID: <7vzmqx1gi4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509010009350.23242@iabervon.org>
	<7vll2h4bc8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 07:54:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAi0y-0006zT-Hn
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 07:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVIAFw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 01:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVIAFw6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 01:52:58 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:9876 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964912AbVIAFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 01:52:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050901055254.CZQP18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Sep 2005 01:52:54 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7vll2h4bc8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 31 Aug 2005 22:16:07 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7991>

Junio C Hamano <junkio@cox.net> writes:

>> Why does --emu23 use I+H for stage 2, rather than just I? Wouldn't this 
>> just reintroduce removed files?
>
> They are not "removed files", at least in the original context.
>
> The original intention was...

Gmane turns out to be better remembering things than my faulty
memory.  The thread beginning here is a good summary of the
thinking behind the current design:

	http://article.gmane.org/gmane.comp.version-control.git/4737
