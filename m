From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Fri, 03 Sep 2010 21:45:37 +0200
Message-ID: <m2r5ha7gri.fsf@igel.home>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<20100903192907.GA2978@n2100.arm.linux.org.uk>
	<20100903193309.GC29821@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jonathan Nieder <jrnieder@gmail.com>, linux-sh@vger.kernel.org,
	bug-patch@gnu.org, Magnus Damm <magnus.damm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Sep 03 21:45:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrcCn-0004NL-Uu
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 21:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107Ab0ICTpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 15:45:40 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:32968 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906Ab0ICTpj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 15:45:39 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id A41161C00217;
	Fri,  3 Sep 2010 21:45:37 +0200 (CEST)
Received: from igel.home (ppp-93-104-152-151.dynamic.mnet-online.de [93.104.152.151])
	by mail.mnet-online.de (Postfix) with ESMTP id 93EB41C00166;
	Fri,  3 Sep 2010 21:45:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5B6F1CA29C; Fri,  3 Sep 2010 21:45:37 +0200 (CEST)
X-Yow: ..  ich bin in einem dusenjet ins jahr 53 vor chr...
 ich lande im antiken Rom...  einige gladiatoren spielen scrabble...
 ich rieche PIZZA...
In-Reply-To: <20100903193309.GC29821@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
 =?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Fri, 3 Sep 2010 21:33:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155270>

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Still GNU patch should then already fail in --dry-run mode.

Since --dry-run doesn't actually perform any changes it can easily be
fooled when a file is patched twice.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
