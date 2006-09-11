From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git web view doesn't show short log in chronological order ?
Date: Mon, 11 Sep 2006 10:19:04 +0100
Message-ID: <45052A08.7090304@shadowen.org>
References: <200609111101.00801.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 11:20:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMhy2-0006VO-RE
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 11:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWIKJTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 11 Sep 2006 05:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIKJTe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 05:19:34 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:38928 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751276AbWIKJTd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 05:19:33 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GMhwZ-0000iG-G7; Mon, 11 Sep 2006 10:19:07 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <200609111101.00801.toralf.foerster@gmx.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26846>

Toralf F=F6rster wrote:
> http://www.kernel.org/git/?p=3Dlinux%2Fkernel%2Fgit%2Ftorvalds%2Flinu=
x-2.6.git;a=3Dsummary
> lists the entry from Kirill Korotaev at position 12 (all first 12 pos=
itions are
> 2 days old), but Kirill Korotaev did the latest commit (if I do a "$>=
git log" at
> my local clone of Linus' tree) and therefore should be listed at posi=
tion 1,
> isn't it ?

The dates on commits can always be suspect as they are generally in the
originators local clock.  You also have to remember the date which is
shown is the authors original create time.  Not the time it was commite=
d
to linus' tree.

/me pulls the dates for 11 & 12:

Author: Thomas Gleixner <tglx@linutronix.de>  2006-09-08 17:47:15
Committer: Linus Torvalds <torvalds@g5.osdl.org>  2006-09-08 18:22:50

Author: Kirill Korotaev <dev@openvz.org>  2006-09-07 11:17:04
Committer: Linus Torvalds <torvalds@g5.osdl.org>  2006-09-08 16:40:46

=46rom what I can see both dates here are older in Kirill's change.  So=
 by
any sort they are in the right order (where right is reverse chronologi=
cal).

?

-apw
