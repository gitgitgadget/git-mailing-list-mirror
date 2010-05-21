From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Fri, 21 May 2010 19:54:25 +0200
Message-ID: <m2tyq1qgxa.fsf@igel.home>
References: <ht3194$1vc$1@dough.gmane.org>
	<7vy6fe7ldo.fsf@alter.siamese.dyndns.org>
	<AANLkTilctjct-a911H14XMnaBydYR1I6lPbEuFThTJ99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Fri May 21 19:54:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFWQc-0005gy-GM
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 19:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590Ab0EURya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 13:54:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58048 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757596Ab0EURy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 13:54:28 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 1482A1C15552;
	Fri, 21 May 2010 19:54:27 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 0A55D9023C;
	Fri, 21 May 2010 19:54:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id XKI-HitBPMqh; Fri, 21 May 2010 19:54:26 +0200 (CEST)
Received: from igel.home (ppp-88-217-123-22.dynamic.mnet-online.de [88.217.123.22])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 21 May 2010 19:54:26 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C7F65CA297; Fri, 21 May 2010 19:54:25 +0200 (CEST)
X-Yow: Hey, waiter!  I want a NEW SHIRT and a PONY TAIL with lemon sauce!
In-Reply-To: <AANLkTilctjct-a911H14XMnaBydYR1I6lPbEuFThTJ99@mail.gmail.com>
	(Leo Razoumov's message of "Fri, 21 May 2010 08:52:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147490>

Leo Razoumov <slonik.az@gmail.com> writes:

> Speaking of .gitignore and untracked files. Explicitly mentioning all
> such untracked files in .gitignore is often unpractical. For example,
> during build process some large projects autogenerate many temporary
> *.c  *.h *.cpp files. Hunting all of them down and adding to
> .gitignore is a waste of time and one cannot use globs *.c *.h for
> obvious reasons.

You can actually, since tracked files are never ignored.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
