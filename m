From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Mistake in git-reset documentation
Date: Sun, 28 Oct 2012 14:39:49 +0100
Message-ID: <m2zk36hg0q.fsf@igel.home>
References: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
	<20121028083610.GA26374@shrek.podlesie.net>
	<20121028110715.GB11434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Bojan =?utf-8?Q?Petrovi?= =?utf-8?Q?=C4=87?= 
	<bojan85@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 14:40:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TST5y-0006j2-Oc
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 14:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab2J1Njy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 09:39:54 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35661 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab2J1Njy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 09:39:54 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XqKn313Qmz3hhZw;
	Sun, 28 Oct 2012 14:39:51 +0100 (CET)
X-Auth-Info: YdlIXJHjUSXKmuIWISdYS1TNjbFaFClzw0+7mw5iphE=
Received: from igel.home (ppp-93-104-156-214.dynamic.mnet-online.de [93.104.156.214])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XqKn30fC2zbbcM;
	Sun, 28 Oct 2012 14:39:51 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9EF6DCA2A1; Sun, 28 Oct 2012 14:39:50 +0100 (CET)
X-Yow: I need "RONDO".
In-Reply-To: <20121028110715.GB11434@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 28 Oct 2012 07:07:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208545>

Jeff King <peff@peff.net> writes:

> On Sun, Oct 28, 2012 at 09:36:10AM +0100, Krzysztof Mazur wrote:
>
>>  DESCRIPTION
>>  -----------
>> @@ -43,7 +43,7 @@ This means that `git reset -p` is the opposite of `git add -p`, i.e.
>>  you can use it to selectively reset hunks. See the ``Interactive Mode''
>>  section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
>>  
>> -'git reset' --<mode> [<commit>]::
>> +'git reset' [--<mode>] [<commit>]::
>>  	This form resets the current branch head to <commit> and
>>  	possibly updates the index (resetting it to the tree of <commit>) and
>>  	the working tree depending on <mode>, which
>
> Should we say something like "if --<mode> is omitted, defaults to
> "--mixed"?

Under --mixed it already says "This is the default action", though.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
