From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-archive: recursive prefix directory creation
Date: Sat, 19 May 2007 11:17:05 -0700
Message-ID: <7vbqggy8ym.fsf@assigned-by-dhcp.cox.net>
References: <464EE169.30306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 19 20:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpTUQ-0001NF-MD
	for gcvg-git@gmane.org; Sat, 19 May 2007 20:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162AbXESSRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 14:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758208AbXESSRK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 14:17:10 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46206 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162AbXESSRJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 14:17:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519181708.ZHHE19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 14:17:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 16H81X0041kojtg0000000; Sat, 19 May 2007 14:17:08 -0400
In-Reply-To: <464EE169.30306@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sat,
	19 May 2007 13:37:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47763>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Currently git-archive only adds a single directory entry for prefixes=
,
> e.g. for --prefix=3Da/b/c/ only the directory a/b/c/ would be added t=
o
> the archive, not a/ nor a/b/.  While tar and unzip don't seem to have
> a problem handling these missing entries, their omission was not
> intended.

Until we start tracking directories (we briefly discussed, and I
think I agree with Linus that it should not be too painful), I'd
rather keep the current behaviour which I feel is more
consistent with what we really are doing.
