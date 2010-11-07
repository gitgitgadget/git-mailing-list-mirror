From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a file or directory
Date: Sun, 07 Nov 2010 11:19:44 +0100
Message-ID: <m239rdv3jz.fsf@igel.home>
References: <20101104125641.2ef90853@cortex>
	<AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
	<20101104151637.076ac021@cortex>
	<AANLkTi=cydcB2yRpWbSH7qZGHdjXEPjNvfBCJny7JcwJ@mail.gmail.com>
	<20101104181537.5f866d42@cortex>
	<AANLkTimDWM69qvY5wdyzFu=g6htg12-K542PRR4bdDYq@mail.gmail.com>
	<AANLkTi=aGHvQhG3bOcqS-U04UjFeB7PVw9GTsSuf3UFA@mail.gmail.com>
	<20101107104209.3e497c5b@cortex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Nick <oinksocket@letterboxes.org>, git <git@vger.kernel.org>
To: Camille Moncelier <moncelier@devlife.org>
X-From: git-owner@vger.kernel.org Sun Nov 07 11:20:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF2Lw-0006D0-IG
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 11:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab0KGKTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 05:19:48 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:53676 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab0KGKTr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 05:19:47 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 44D451C001E6;
	Sun,  7 Nov 2010 11:19:44 +0100 (CET)
Received: from igel.home (ppp-88-217-124-121.dynamic.mnet-online.de [88.217.124.121])
	by mail.mnet-online.de (Postfix) with ESMTP id C1F491C00351;
	Sun,  7 Nov 2010 11:19:44 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 49117CA2A0; Sun,  7 Nov 2010 11:19:44 +0100 (CET)
X-Yow: Vote for ME -- I'm well-tapered, half-cocked, ill-conceived and
 TAX-DEFERRED!
In-Reply-To: <20101107104209.3e497c5b@cortex> (Camille Moncelier's message of
	"Sun, 7 Nov 2010 10:42:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160873>

Camille Moncelier <moncelier@devlife.org> writes:

> BTW, Is there a way using git bisect to find the "last bad commit",
> or maybe the "first good one" ?

It works the same as "find first bad one", you just have to exchange
"good" and "bad" (they really mean "before" and "after").

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
