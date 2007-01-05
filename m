From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default "tar" umask..
Date: Fri, 05 Jan 2007 14:40:58 -0800
Message-ID: <7vejq9drlx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>
	<7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>
	<459EB78B.60000@lsrfire.ath.cx>
	<7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
	<459ED17E.2080101@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 23:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2xkH-0003Xh-0D
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 23:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbXAEWlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Jan 2007 17:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbXAEWlB
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 17:41:01 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62037 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXAEWlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 17:41:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105224059.FNPA15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 17:40:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7agA1W00a1kojtg0000000; Fri, 05 Jan 2007 17:40:11 -0500
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <459ED17E.2080101@lsrfire.ath.cx> (=?iso-8859-1?Q?Ren=E9?=
 Scharfe's message of
	"Fri, 05 Jan 2007 23:30:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36035>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> [Junio: Sorry for resending, I somehow dropped the CC:'s the first ti=
me.]

I think that was my fault.  I somehow dropped the CC:'s and
resent without you to the list, and you responded to the first
one.

> ...  Err, unless the target system has a group named git, which
> would then be used instead.  Come to think of it, having this "git"
> group name in there is a bit strange and unnecessary.  How about the
> following patch?

It is a very good point.  I think this patch is sane, regardless
of 002 vs 022 issue.
