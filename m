From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 22:12:16 +0100
Message-ID: <m28va9duxb.fsf@igel.home>
References: <20121109192336.GA9401@sigill.intra.peff.net>
	<87a9uq5tql.fsf@Niukka.kon.iki.fi>
	<20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
	<871ug15k5c.fsf@Niukka.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sat Nov 10 22:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXILx-0003Ff-Sn
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 22:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab2KJVMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 16:12:20 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41011 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab2KJVMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 16:12:19 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XzWC56VDQz4KK4N;
	Sat, 10 Nov 2012 22:12:17 +0100 (CET)
X-Auth-Info: D+f219Lir9LJJdRK7diQFqE/F93GXojtPC2x7etkKZs=
Received: from igel.home (ppp-88-217-120-210.dynamic.mnet-online.de [88.217.120.210])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XzWC52fjHzbbg0;
	Sat, 10 Nov 2012 22:12:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id BCD7BCA2A4; Sat, 10 Nov 2012 22:12:16 +0100 (CET)
X-Yow: Isn't this my STOP?!
In-Reply-To: <871ug15k5c.fsf@Niukka.kon.iki.fi> (Kalle Olavi Niemitalo's
	message of "Sat, 10 Nov 2012 21:32:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209306>

Kalle Olavi Niemitalo <kon@iki.fi> writes:

> With strace, it looks like CVS sets SIG_IGN as the handler of
> SIGINT and SIGQUIT only in the parent process after forking, not
> in the child process that executes the editor.
>
> CVS also temporarily blocks signals by calling sigprocmask, but
> it undoes that before it forks or waits for the child process.

This emulates what system(3) does.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
