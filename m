From: Pavel Roskin <proski@gnu.org>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Sat, 29 Oct 2005 00:23:57 -0400
Message-ID: <20051029002357.iq88cg8gcsogk4kc@webmail.spamcop.net>
References: <1130434230.19641.21.camel@dv>
	<7vslum3l2w.fsf@assigned-by-dhcp.cox.net> <1130463389.2186.14.camel@dv>
	<7v4q72xavz.fsf@assigned-by-dhcp.cox.net> <1130539503.10531.43.camel@dv>
	<7vslul2g29.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510282003360.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 06:24:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EViGN-00053y-6S
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVJ2EX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVJ2EX6
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:23:58 -0400
Received: from c62.cesmail.net ([216.154.195.54]:39470 "EHLO c62.cesmail.net")
	by vger.kernel.org with ESMTP id S1751124AbVJ2EX6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Oct 2005 00:23:58 -0400
Received: from unknown (HELO gamma.cesmail.net) ([192.168.1.20])
  by c62.cesmail.net with SMTP; 29 Oct 2005 00:23:57 -0400
Received: (qmail 32274 invoked by uid 99); 29 Oct 2005 04:23:57 -0000
Received: from static-68-161-241-229.ny325.east.verizon.net
	(static-68-161-241-229.ny325.east.verizon.net [68.161.241.229]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Sat, 29 Oct 2005 00:23:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510282003360.3348@g5.osdl.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10791>

Quoting Linus Torvalds <torvalds@osdl.org>:

> Note that git-patch-id will happily take a patch without the commit ID at
> the head, it just won't have a commit ID to match it up with. For such
> patches it will just spit it out with an all-zero commit-object-name.
>
> And that's very much by design.
[snip]

OK, if it's by design, I'll fix gitk only.

I understand the default behavior of git-diff-tree won't change, so I'll simply
strip the first line.

--
Regards,
Pavel Roskin
