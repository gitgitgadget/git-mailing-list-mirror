From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-blame --incremental: don't use pager
Date: Sun, 28 Jan 2007 11:09:26 -0800
Message-ID: <7v4pqbezo9.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<45BCB273.7010601@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 28 20:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBFP9-0000yc-NR
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 20:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbXA1TJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 28 Jan 2007 14:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbXA1TJ3
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 14:09:29 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60670 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932749AbXA1TJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jan 2007 14:09:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128190928.IDB15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 14:09:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Gj8V1W0091kojtg0000000; Sun, 28 Jan 2007 14:08:29 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38039>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Starting a pager defeats the purpose of the incremental output
> mode.  This changes git-blame to only paginate if --incremental
> was not given.

I should have done this myself when I applied Linus's patch.
Thanks for catching.
