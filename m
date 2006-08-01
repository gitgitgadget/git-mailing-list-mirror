From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why I love GIT but use Subversion
Date: Mon, 31 Jul 2006 21:42:14 -0700
Message-ID: <7virld2hjt.fsf@assigned-by-dhcp.cox.net>
References: <4d8e3fd30607230123m459aa1cle2ab8c1c1dd0fcd2@mail.gmail.com>
	<4d8e3fd30607300248m36b4038dv1fcd1f3716503905@mail.gmail.com>
	<1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 06:42:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7m5E-0006wS-48
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 06:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWHAEmR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 Aug 2006 00:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWHAEmQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 00:42:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:32140 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751255AbWHAEmQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 00:42:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801044215.KIJS554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 00:42:15 -0400
To: =?iso-8859-1?Q?J=F6rg?= W Mittag <Joerg.Mittag@Web.De>
In-Reply-To: <1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de> (=?iso-8859-1?Q?J=F6?=
 =?iso-8859-1?Q?rg?= W. Mittag's
	message of "Tue, 1 Aug 2006 03:45:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24572>

J=F6rg W Mittag <Joerg.Mittag@Web.De> writes:

> Please, make those reasons go away.

These are all reasonable wishes.

The core level of git (which is written in C) is designed to be
usable as a building block for platform native IDE.  The primary
audience of git so far has been POSIX envirnoment, and the
command line interface we have in core git was one acceptable
form of "platform native IDE".  I know that is not a usual form
of IDE in some other world (most notably in MS circles).

I do not speak for others on this mailing list, but given the
background of how git came about into existence, which pretty
much defines the majority of the habitants of this mailing list,
I doubt there are many people who know git well enough and have
enough experience and motivation to implement "platform native
IDE" for MS platform.  Certainly I cannot imagine Linus and/or
myself doing Windows GUI programming to make git integrate into
MS environment seamlessly.  You probably are a lot more familiar
and qualified to implement such than myself.

So please step forward, enlist MS comrades, and start hacking,
if you want MS native git.  If you need help in understanding
the core git data structures, algorithms, and functions, I may
well be able to help you.  If you have difficulties interfacing
with Visual Studio on the other hand that is not something I can
help you with, although some others on the list might.

> Thank you for bearing with me through this long rant.

Thank *you* for sharing these thoughts.
