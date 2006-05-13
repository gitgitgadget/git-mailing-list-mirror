From: Junio C Hamano <junkio@cox.net>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sat, 13 May 2006 13:30:45 -0700
Message-ID: <7v4pztu0p6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 13 22:30:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff0lL-00042G-RU
	for gcvg-git@gmane.org; Sat, 13 May 2006 22:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWEMUar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 16:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWEMUar
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 16:30:47 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:25288 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751013AbWEMUaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 16:30:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060513203046.DOCD27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 May 2006 16:30:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 13 May 2006 13:23:48 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19945>

Linus Torvalds <torvalds@osdl.org> writes:

> We used to parse "-U" and "--unified" as part of the GIT_DIFF_OPTS 
> environment variable, but strangely enough we would _not_ parse them as 
> part of the normal diff command line (where we only accepted "-u").
>
> This adds parsing of -U and --unified, both with an optional numeric 
> argument. So now you can just say
>
> 	git diff --unified=5
>
> [ Maybe this can still hit 1.3.3? ]

I think so.
