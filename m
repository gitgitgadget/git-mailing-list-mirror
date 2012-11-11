From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sun, 11 Nov 2012 09:58:51 +0100
Message-ID: <m2ehk0tt10.fsf@linux-m68k.org>
References: <20121109192336.GA9401@sigill.intra.peff.net>
	<87a9uq5tql.fsf@Niukka.kon.iki.fi>
	<20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
	<871ug15k5c.fsf@Niukka.kon.iki.fi>
	<20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us>
	<87wqxs4o6f.fsf@Niukka.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:59:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXTNv-0006g9-8q
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 09:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab2KKI66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 03:58:58 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:54365 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2KKI6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 03:58:55 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XzptP2Lkvz3hhdv;
	Sun, 11 Nov 2012 09:58:52 +0100 (CET)
X-Auth-Info: WgaQE3iGa6ACIllm2q5Pgr7wFI7L+5zPuQfgZUmXdJ4=
Received: from linux.local (ppp-93-104-148-16.dynamic.mnet-online.de [93.104.148.16])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XzptN4t8GzbbfX;
	Sun, 11 Nov 2012 09:58:52 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id CCF8C14EC0E; Sun, 11 Nov 2012 09:58:51 +0100 (CET)
X-Yow: Yow!  Am I cleansed yet?!
In-Reply-To: <87wqxs4o6f.fsf@Niukka.kon.iki.fi> (Kalle Olavi Niemitalo's
	message of "Sun, 11 Nov 2012 09:02:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209327>

Kalle Olavi Niemitalo <kon@iki.fi> writes:

> and neither process blocked any signals (not even SIGCHLD as system(3)
> would).

If you don't have a SIGCHLD handler it won't matter anyway.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
