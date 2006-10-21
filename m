From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Fri, 20 Oct 2006 22:29:37 -0700
Message-ID: <7vbqo6i6da.fsf@assigned-by-dhcp.cox.net>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net>
	<7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
	<20061021021235.GA29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 07:29:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb9QV-0006j9-8U
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 07:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992796AbWJUF3j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 01:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992826AbWJUF3j
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 01:29:39 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45745 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S2992796AbWJUF3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 01:29:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021052938.DMKQ6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Oct 2006 01:29:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ctVP1V00K1kojtg0000000
	Sat, 21 Oct 2006 01:29:23 -0400
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20061021021235.GA29920@ftp.linux.org.uk> (Al Viro's message of
	"Sat, 21 Oct 2006 03:12:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29581>

Al Viro <viro@ftp.linux.org.uk> writes:

> Speaking of irritations...  There is a major (and AFAICS fixable)
> suckitude in git-cherry.  Basically, what it does is...

Yeah, that sucks big time.  I never realized there are people
who still are using it, though. git-format-patch used to use it,
but the version was retired exactly five months ago, and there
is no in-tree users anymore.

I guess we could separate out the revision filtering logic in
builtin-log.c:cmd_format_patch() and implement git-cherry as a
new built-in.
