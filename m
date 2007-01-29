From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-blame --incremental: don't use pager
Date: Mon, 29 Jan 2007 01:32:46 +0100
Message-ID: <45BD40AE.9020603@lsrfire.ath.cx>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>	<20070127080126.GC9966@spearce.org>	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>	<45BCB273.7010601@lsrfire.ath.cx>	<7v4pqbezo9.fsf@assigned-by-dhcp.cox.net> <7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 01:33:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBKSC-0003V8-7P
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 01:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbXA2Acz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 28 Jan 2007 19:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933022AbXA2Acz
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 19:32:55 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:57813
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933026AbXA2Acy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jan 2007 19:32:54 -0500
Received: from [10.0.1.20] (p508E702E.dip.t-dialin.net [80.142.112.46])
	by neapel230.server4you.de (Postfix) with ESMTP id 001A12F00F;
	Mon, 29 Jan 2007 01:32:52 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38058>

Junio C Hamano schrieb:
> Although I'd apply it anyway, strictly speaking, I think this
> patch should not matter because any real Porcelain would be
> using this as an upstream of a pipe to its drawing engine.
>=20
> Well, unless that Porcelain drives --incremental through a pair
> of ptys, but I do not think it is likely ;-).

Ha!, didn't think of that.  I still like it more without a pager
even if run on a terminal, because then you can *see* that it's
really incremental (without needing to unset PAGER).  I'm a
non-believer. ;-)

Ren=E9
