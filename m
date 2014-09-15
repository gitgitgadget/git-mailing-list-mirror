From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git merge --abort deletes unstaged files
Date: Mon, 15 Sep 2014 19:16:42 +0200
Message-ID: <87k354x0qt.fsf@igel.home>
References: <04af01cfd0fb$d077e200$7167a600$@webkr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?B?QW5kcsOpIEjDpG5zZWw=?= <andre@webkr.de>
X-From: git-owner@vger.kernel.org Mon Sep 15 19:16:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTZtR-0006XJ-VV
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 19:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbaIORQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2014 13:16:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49021 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbaIORQp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 13:16:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3hxZ4C3Xyyz3hjKQ;
	Mon, 15 Sep 2014 19:16:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3hxZ4C1yxCzvhRn;
	Mon, 15 Sep 2014 19:16:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id wnEhTl9NpDDC; Mon, 15 Sep 2014 19:16:42 +0200 (CEST)
X-Auth-Info: KtoVLJkjPFv8gv7A0klN3zZYFMLqk6u4Ze4nLLgaJjA+7Teumn/f3ggZQf11siZi
Received: from igel.home (host-188-174-223-9.customer.m-online.net [188.174.223.9])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 15 Sep 2014 19:16:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 353242C1CEB; Mon, 15 Sep 2014 19:16:42 +0200 (CEST)
X-Yow: If Robert Di Niro assassinates Walter Slezak, will
 Jodie Foster marry Bonzo??
In-Reply-To: <04af01cfd0fb$d077e200$7167a600$@webkr.de> (=?utf-8?Q?=22Andr?=
 =?utf-8?Q?=C3=A9_H=C3=A4nsel=22's?=
	message of "Mon, 15 Sep 2014 17:43:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257056>

Andr=C3=A9 H=C3=A4nsel <andre@webkr.de> writes:

> I ran git merge to merge a branch. There were some conflicted files.
> Although they were automatically resolved by git rerere, I still had =
to add
> them.

If you want them to be added automatically, set rerere.autoupdate=3Dtru=
e.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
