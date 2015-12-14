From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git bisect with temporary commits
Date: Mon, 14 Dec 2015 21:17:37 +0100
Message-ID: <87lh8whjj2.fsf@igel.home>
References: <20151214163726.GY13519@tonks> <87si34hphr.fsf@igel.home>
	<20151214182255.GB13519@tonks>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, r.seitz@beh.ch
To: Florian Bruhin <me@the-compiler.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:17:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ZZ4-0006c4-1I
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbbLNURl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:17:41 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55920 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbLNURk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:17:40 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3pKDXy57Nfz3hjZ1;
	Mon, 14 Dec 2015 21:17:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3pKDXy3sjwzvh2C;
	Mon, 14 Dec 2015 21:17:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id EuQeNsQdqlst; Mon, 14 Dec 2015 21:17:37 +0100 (CET)
X-Auth-Info: mw3TCX4M84HTn1M4e7JVCPmHqjcvszpwFYfuVSbA0Q4LuEQchrGQMwYZ9mFuTgCV
Received: from igel.home (ppp-88-217-8-172.dynamic.mnet-online.de [88.217.8.172])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 14 Dec 2015 21:17:37 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 31D172C44E0; Mon, 14 Dec 2015 21:17:37 +0100 (CET)
X-Yow: I represent a sardine!!
In-Reply-To: <20151214182255.GB13519@tonks> (Florian Bruhin's message of "Mon,
	14 Dec 2015 19:22:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282398>

Florian Bruhin <me@the-compiler.org> writes:

> I see - but wouldn't it make more sense for a "git bisect good" (or
> bad, respectively) without arguments to assume I mean the commit
> bisect checked out for me, not HEAD?

The problem is that there is nothing that marks the originally checked
out commit except by being pointed to by HEAD.  Also, testing a
different commit as the one suggested by git can be useful when skipping
over commits that are known to fail for unrelated reasons (see "Avoiding
testing a commit" in git-bisect(1)).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
