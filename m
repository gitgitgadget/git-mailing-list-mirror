From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-archive: recursive prefix directory creation
Date: Sat, 19 May 2007 13:22:17 -0700
Message-ID: <7vtzu8va12.fsf@assigned-by-dhcp.cox.net>
References: <464EE169.30306@lsrfire.ath.cx>
	<7vbqggy8ym.fsf@assigned-by-dhcp.cox.net>
	<464F568B.9030308@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 19 22:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpVRZ-00035t-48
	for gcvg-git@gmane.org; Sat, 19 May 2007 22:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759720AbXESUWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 16:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759714AbXESUWU
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 16:22:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36144 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759337AbXESUWU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 16:22:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519202219.XORN22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 16:22:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 18NJ1X00K1kojtg0000000; Sat, 19 May 2007 16:22:19 -0400
In-Reply-To: <464F568B.9030308@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Sat, 19 May 2007 21:56:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47771>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>=20
>>> Currently git-archive only adds a single directory entry for prefix=
es,
>>> e.g. for --prefix=3Da/b/c/ only the directory a/b/c/ would be added=
 to
>>> the archive, not a/ nor a/b/.  While tar and unzip don't seem to ha=
ve
>>> a problem handling these missing entries, their omission was not
>>> intended.
>>=20
>> Until we start tracking directories (we briefly discussed, and I
>> think I agree with Linus that it should not be too painful), I'd
>> rather keep the current behaviour which I feel is more
>> consistent with what we really are doing.
>
> Hmm, fair enough.  I started out with a simple cleanup and then I gue=
ss
> went a bit overboard with that overblown path walker. :-]

Well, I take that back -- I did not realize you were primarily
talking about the LEADING part of the path.
