From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] .gitignore git-rerere and config.mak
Date: Tue, 07 Feb 2006 21:34:28 -0800
Message-ID: <7vlkwmquqj.fsf@assigned-by-dhcp.cox.net>
References: <7vk6c7uj21.fsf@assigned-by-dhcp.cox.net>
	<1303.1139370931@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 06:34:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6hyP-000360-3s
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 06:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWBHFec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 00:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWBHFec
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 00:34:32 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62937 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030452AbWBHFec (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 00:34:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208053126.BBZK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 00:31:26 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <1303.1139370931@lotus.CS.Berkeley.EDU> (Jason Riedy's message of
	"Tue, 07 Feb 2006 19:55:31 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15731>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> And Junio C Hamano writes:
>  - I am not sure about this part.  It is plausible that somebody
>  - who privately uses config.mak has it in _his_ repository under
>  - version control.
>
> Like me.  That way I don't have to worry about conflicts in the
> Makefile.  But I can change .gitignore in those branches...

Or you can leave that as is.  .gitignore is used to sift
untracked files into two categories - ignored and unknown.  So
my initial worry was unfounded.

Sorry for the noise.
