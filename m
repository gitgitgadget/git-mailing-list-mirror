From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Tue, 27 Apr 2010 22:13:02 +0200
Message-ID: <m2iq7cejsh.fsf@igel.home>
References: <20100427135708.258636000@mlists.thewrittenword.com>
	<4BD7032D.9050508@drmicha.warpmail.net>
	<20100427175442.GB13626@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 27 22:13:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6r9e-0005wN-8j
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab0D0UNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:13:09 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57205 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab0D0UNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:13:07 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 245551C1561D;
	Tue, 27 Apr 2010 22:13:03 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id CF72D9023A;
	Tue, 27 Apr 2010 22:13:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 1KTdTZmzLjAu; Tue, 27 Apr 2010 22:13:03 +0200 (CEST)
Received: from igel.home (ppp-88-217-105-240.dynamic.mnet-online.de [88.217.105.240])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 27 Apr 2010 22:13:03 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id CFA45CA297; Tue, 27 Apr 2010 22:13:02 +0200 (CEST)
X-Yow: Everybody gets free BORSCHT!
In-Reply-To: <20100427175442.GB13626@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 27 Apr 2010 13:54:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145943>

Jeff King <peff@peff.net> writes:

> Furthermore, if we do take such changes, how are we going to manage
> portability going forward? Some constructs (like non-constant
> initializers) make the code much easier to read. People _will_ submit
> patches that use them. Is somebody going to be auto-building on all of
> these platforms with vendor compilers to confirm that nothing is broken?

You can use "gcc -pedantic" to find these portability problems.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
