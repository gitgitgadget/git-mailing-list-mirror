From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Enhance core.logallrefupdates
Date: Sun, 08 Oct 2006 12:52:29 -0700
Message-ID: <7vr6xiio02.fsf@assigned-by-dhcp.cox.net>
References: <7vbqonkzfe.fsf@assigned-by-dhcp.cox.net>
	<egaibi$bb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 21:52:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWehc-00060j-VV
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 21:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWJHTwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 15:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWJHTwb
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 15:52:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17351 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751383AbWJHTwa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 15:52:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061008195230.CPXY21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Oct 2006 15:52:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XvsM1V0061kojtg0000000
	Sun, 08 Oct 2006 15:52:21 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <egaibi$bb$1@sea.gmane.org> (Jakub Narebski's message of "Sun, 08
	Oct 2006 12:03:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28544>

Jakub Narebski <jnareb@gmail.com> writes:

>> =A0 =A0Come to think of it, it might make sense to change the
>> =A0 =A0meaning of "true" to do what this patch does. =A0I do not thi=
nk
>> =A0 =A0of reasons to create missing reflog for tags automatically
>> =A0 =A0anyway.
>
> If we change meaning of "true", perhaps (just in case in case) we
> should add "all" value?

Didn't I just say that I do not think of reasons to do so ;-)?

Saying "just in case" is not enough.  You need to say at least
"this hypothetical workflow which requires to update refs/xxx
and doing automated reflog creation only under refs/heads makes
that workflow less convenient".
