From: Junio C Hamano <junkio@cox.net>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 21:43:10 -0700
Message-ID: <7v4pzchych.fsf@assigned-by-dhcp.cox.net>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
	<20060526193325.d2a530a4.tihirvon@gmail.com>
	<20060526163829.GB10488@pasky.or.cz> <1148697382.5599.1.camel@dv>
	<20060527025750.GM11941@pasky.or.cz>
	<Pine.LNX.4.64.0605262007230.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605262033560.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 06:43:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjqe0-0000ud-DW
	for gcvg-git@gmane.org; Sat, 27 May 2006 06:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWE0EnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 00:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWE0EnM
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 00:43:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22992 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750819AbWE0EnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 00:43:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060527044311.UFBS9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 27 May 2006 00:43:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605262033560.5623@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 26 May 2006 20:36:08 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20835>

Linus Torvalds <torvalds@osdl.org> writes:

>> 	[alias "co"]
>> 		cmd = commit -a
>
> That, of course, would be confusing.
>
> It should be "ci" for commit, and "co" for "checkout".
>
> Duh. Chalk it up to me not having used cvs in the last three or four years 
> or so (we used it at transmeta, although I can hope that they've since 
> seen the light ;).
>
> 			Linus

You are lucky ;-).

The alias would be a nice addition -- I can get rid of the hack
I have for show-branch.  We would need an argument splitter, but
that should be trivial.
