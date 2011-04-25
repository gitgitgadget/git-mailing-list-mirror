From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: "git clone --depth=2 git://git.sv.gnu.org/gnulib" hangs
Date: Mon, 25 Apr 2011 23:16:03 +0200
Message-ID: <m2ipu2f2wc.fsf@igel.home>
References: <87aafedqjp.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QET8h-0006cT-Ad
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 23:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab1DYVQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 17:16:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57021 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab1DYVQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 17:16:07 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DAC3B186DEE6;
	Mon, 25 Apr 2011 23:16:04 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 22BA01C00142;
	Mon, 25 Apr 2011 23:16:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id R21ywIXsO1YK; Mon, 25 Apr 2011 23:16:04 +0200 (CEST)
Received: from igel.home (ppp-88-217-126-29.dynamic.mnet-online.de [88.217.126.29])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 25 Apr 2011 23:16:04 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id D3112CA29C; Mon, 25 Apr 2011 23:16:03 +0200 (CEST)
X-Yow: ..The TENSION mounts as I MASSAGE your RIGHT ANKLE according to
 ancient Tibetan ACCOUNTING PROCEDURES..are you NEUROTIC yet??
In-Reply-To: <87aafedqjp.fsf@rho.meyering.net> (Jim Meyering's message of
	"Mon, 25 Apr 2011 22:28:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172048>

Jim Meyering <jim@meyering.net> writes:

> We've had a report that this command is hanging:
>
>     git clone --depth=2 git://git.sv.gnu.org/gnulib
>
> cloning without --depth=N works, as well as when using an ssh:// URL,
> but most people can use ssh:// URLs.

When cloing without --depth I see the resolving deltas phase busy for a
minute at 50%.  Perhaps related?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
