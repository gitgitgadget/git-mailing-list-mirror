From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Bug Report: Creating a hardlink to any of the file in git repo cause the source file  to show up in git commit message editor under "Changes not staged for commit" section.
Date: Mon, 18 Jul 2011 22:12:18 +0200
Message-ID: <m28vrvfivx.fsf@igel.home>
References: <6f37875d70623e2b8966653b067a2149@mail.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: git-scm@webhippo.net
X-From: git-owner@vger.kernel.org Mon Jul 18 22:12:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiuB1-0006C5-BX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 22:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab1GRUMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 16:12:22 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55549 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab1GRUMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 16:12:21 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 7E36A186DEC6;
	Mon, 18 Jul 2011 22:12:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 8C7E91C0008D;
	Mon, 18 Jul 2011 22:12:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id GagX-NRtyYih; Mon, 18 Jul 2011 22:12:19 +0200 (CEST)
Received: from igel.home (ppp-88-217-110-34.dynamic.mnet-online.de [88.217.110.34])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 18 Jul 2011 22:12:18 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id B273DCA293; Mon, 18 Jul 2011 22:12:18 +0200 (CEST)
X-Yow: RHAPSODY in Glue!
In-Reply-To: <6f37875d70623e2b8966653b067a2149@mail.mxes.net> (Michael's
	message of "Sun, 17 Jul 2011 20:24:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177404>

Michael <git-scm@webhippo.net> writes:

> In case anyone interested, tor me this happens when I do a python EGG
> build
> which hardlinks files in order to build.

Try "git config core.trustctime false".  Adding a link changes ctime.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
