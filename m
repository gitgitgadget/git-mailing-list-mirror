From: Junio C Hamano <junkio@cox.net>
Subject: Re: Adding color to git diff output.
Date: Tue, 11 Apr 2006 16:12:59 -0700
Message-ID: <7virpf4sg4.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 01:13:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTS2l-0008AF-JJ
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 01:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDKXNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 19:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDKXNE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 19:13:04 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:2207 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751266AbWDKXND (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Apr 2006 19:13:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060411231301.ORLA26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Apr 2006 19:13:01 -0400
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Tue, 11 Apr 2006 18:32:45 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18622>

sean <seanlkml@sympatico.ca> writes:

> Linus posted a colorize program a while back[1] but it wasn't taken into git.  
> The patch below takes a different approach, adding a GIT_DIFF_PAGER variable.
> You can use it by assigning a filter to the environment variable, like so:
>
> export GIT_DIFF_PAGER="colordiff | less -RS"

Sounds like a nice idea, even maybe suitable in a FAQ.
Unfortunately colordiff does not seem to grok diff --cc output,
but that is fine ;-).
