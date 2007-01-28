From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-blame --incremental: don't use pager
Date: Sun, 28 Jan 2007 11:14:03 -0800
Message-ID: <7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<45BCB273.7010601@lsrfire.ath.cx>
	<7v4pqbezo9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 28 20:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBFTk-0003Q5-75
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 20:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbXA1TOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 28 Jan 2007 14:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbXA1TOI
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 14:14:08 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53774 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437AbXA1TOH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jan 2007 14:14:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128191405.LBII20530.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 14:14:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GjD61W00F1kojtg0000000; Sun, 28 Jan 2007 14:13:07 -0500
In-Reply-To: <7v4pqbezo9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 28 Jan 2007 11:09:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38040>

Junio C Hamano <junkio@cox.net> writes:

> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Starting a pager defeats the purpose of the incremental output
>> mode.  This changes git-blame to only paginate if --incremental
>> was not given.
>
> I should have done this myself when I applied Linus's patch.
> Thanks for catching.

Although I'd apply it anyway, strictly speaking, I think this
patch should not matter because any real Porcelain would be
using this as an upstream of a pipe to its drawing engine.

Well, unless that Porcelain drives --incremental through a pair
of ptys, but I do not think it is likely ;-).
