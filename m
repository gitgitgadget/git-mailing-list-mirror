From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 17:42:35 +0200
Message-ID: <m2d31ba0lw.fsf@igel.home>
References: <5060097F.9050203@drmicha.warpmail.net>
	<20120924144929.GA10349@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 17:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGAo6-0003Rk-Ss
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 17:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab2IXPmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 11:42:42 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46644 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756536Ab2IXPml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 11:42:41 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XQV6N63Hjz3hhZv;
	Mon, 24 Sep 2012 17:42:36 +0200 (CEST)
X-Auth-Info: 1TTzxoauZacuSt9RwVttR4b7cxJ/yARS0zyN0cSnk70=
Received: from igel.home (ppp-88-217-96-163.dynamic.mnet-online.de [88.217.96.163])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XQV6N2qgQzbbrK;
	Mon, 24 Sep 2012 17:42:36 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id E5592CA2A3; Mon, 24 Sep 2012 17:42:35 +0200 (CEST)
X-Yow: Give them RADAR-GUIDED SKEE-BALL LANES and VELVEETA BURRITOS!!
In-Reply-To: <20120924144929.GA10349@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Sep 2012 10:49:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206287>

Jeff King <peff@peff.net> writes:

> Bash is even weirder than you might think. Try this:
>
>   $ echo ~/foo
>   /home/peff/foo
>
>   $ echo arg=~/foo
>   arg=/home/peff/foo
>
>   $ echo --arg=~/foo
>   --arg=~/foo

Bash expands all arguments that look like variable assignments.  That
lets you write "export arg=~/foo" even though a POSIX shell wouldn't
tilde expand it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
