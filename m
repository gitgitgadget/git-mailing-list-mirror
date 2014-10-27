From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: flatten-merge history
Date: Mon, 27 Oct 2014 19:45:38 +0100
Message-ID: <874mupbbcd.fsf@igel.home>
References: <544B9839.7000302@gmx.de>
	<CAP8UFD3jyZ+7bk-xrE=TghzFj9UL=+Mtz-CvFWK9azNrRcOU5Q@mail.gmail.com>
	<544D0702.1050907@gmx.de> <8761f65060.fsf@igel.home>
	<CAP8UFD2yjXC6ffCQyTvYNZZ00Ou=YmNgyWxGhbO29nbTHXRD5w@mail.gmail.com>
	<544D878D.6020809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 19:45:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XipIa-0002kG-S9
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 19:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbaJ0Spo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 14:45:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51920 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbaJ0Spo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 14:45:44 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jRQ3S6JDCz3hjH2;
	Mon, 27 Oct 2014 19:45:40 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jRQ3S5RHPzvjDc;
	Mon, 27 Oct 2014 19:45:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 3tzvpiEfMMdh; Mon, 27 Oct 2014 19:45:38 +0100 (CET)
X-Auth-Info: zTanDClaH2bxkcT4JVDU3Z+UsrzrNg1/j4ddIaqzm2kKeBvHkrGRCZGOrey2oJ45
Received: from igel.home (ppp-93-104-153-35.dynamic.mnet-online.de [93.104.153.35])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 27 Oct 2014 19:45:38 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 4CC262C37A8; Mon, 27 Oct 2014 19:45:38 +0100 (CET)
X-Yow: HELLO KITTY gang terrorizes town, family STICKERED to death!
In-Reply-To: <544D878D.6020809@gmx.de> (Henning Moll's message of "Mon, 27 Oct
	2014 00:45:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Moll <newsScott@gmx.de> writes:

> Just a final question: Is it possible to keep the GIT_COMMITTER_DATE in
> all those rebases?

If you want that you need to work with git filter-branch.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
