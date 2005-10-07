From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] embedded TAB and LF in pathnames
Date: Fri, 07 Oct 2005 16:44:48 -0700
Message-ID: <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 01:46:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO1tY-0007VD-2v
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 01:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVJGXox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 19:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVJGXox
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 19:44:53 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63397 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964881AbVJGXox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 19:44:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007234444.ZBWI4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 19:44:44 -0400
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9829>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Fri, Oct 07, 2005 21:35:19 +0200:
>> I have not made up my mind on the exact choice of the quoting
>> convention.  We could say '///' instead of '//', for example, or
>> even '//{LF}//' instead of '//0A' proposed above.  One thing I
>> am trying to avoid is "foo\nbar", which I suspect would be
>> unfriendly to the Cygwin folks.
>
> Being unhappy one of them, I think I'd better manage (even if by
> postprocessing the output).
>
> Please, don't make the common case ugly just because of that platform
> (insanely broken anyway).

You really have to realize that having LF and TAB in filenames
are *NOT* the common case, no matter which platform you are
talking about.
