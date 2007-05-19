From: Junio C Hamano <junkio@cox.net>
Subject: Re: Commit ID in exported Tar Ball
Date: Sat, 19 May 2007 14:00:50 -0700
Message-ID: <7vd50wv88t.fsf@assigned-by-dhcp.cox.net>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
	<200705171857.22891.johan@herland.net>
	<20070517171150.GL5272@planck.djpig.de>
	<464F5CA2.3070809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 19 23:01:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpW2w-0001Yf-Dn
	for gcvg-git@gmane.org; Sat, 19 May 2007 23:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759397AbXESVAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 17:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759772AbXESVAz
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 17:00:55 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49255 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759397AbXESVAy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 17:00:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519210054.OLLC15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 17:00:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 190t1X0011kojtg0000000; Sat, 19 May 2007 17:00:53 -0400
In-Reply-To: <464F5CA2.3070809@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Sat, 19 May 2007 22:22:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47775>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Something like the following patch?  Since we're already embedding th=
e
> commit ID in a comment, we might as well offer creating a synthetic f=
ile
> for it, too, if that solves a user's problem that might be difficult =
to
> work around otherwise.

Are you detecting and erroring out if the named file already
exists in the tree being archived?

Should we?  Maybe we should just replace with warning?

Also should we silently ignore the request if the tree-ish is
not a commit-ish, or error out?
