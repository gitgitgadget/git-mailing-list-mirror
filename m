From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 09:40:24 -0800
Message-ID: <7v64oo9gc7.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
	<7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
	<7vzmm0eod1.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP01A07DAA61F181E9D9679EAE260@CEZ.ICE>
	<40b2b7d90601130311v78db741dx7c5eaa57ad300850@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Jan 13 18:42:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExSuc-0004Ob-0p
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 18:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWAMRk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWAMRk1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 12:40:27 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47498 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1422733AbWAMRk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 12:40:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113173923.CHFC20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 12:39:23 -0500
To: Artem Khodush <greenkaa@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14632>

Artem Khodush <greenkaa@gmail.com> writes:

>> $ export GIT_AUTHOR_NAME="$author"
>> $ GIT_AUTHOR_EMAIL="$email" git commit -F .msgfile
>
>> Which is cumbersome and also ends up destroying your defaults if you happen
>> to use that method, so afterward you have to unset them or reset them back
>> to your own author info.
>
> I had a similar problem on cygwin. I agree that setting environment
> variables by hand
> is cumbersome, and modifying global environment is undesirable...

Have you two known that more than one environment variables can
be set for one-shot command execution?

	$ GIT_AUTHOR_NAME="$author" \
	  GIT_AUTHOR_EMAIL="$email" git commit -F .msgfile

would give these environment variables for this "git commit"
without affecting the later commands.

Not that this really matters, since the above example was an
excerpt of my suggestion about how to do this in a script,
somehow made to look as if it was a suggestion about running
things by hand from the command line...
