From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git branch -M" regression in 1.7.7?
Date: Sun, 27 Nov 2011 00:09:21 +0100
Message-ID: <m2bory5vmm.fsf@igel.home>
References: <CALxtSbRbwkVDKJcXiKY9rHYCjA3XGgCytbXQnRhQvbEnY8SpjA@mail.gmail.com>
	<20111126023002.GA17652@elie.hsd1.il.comcast.net>
	<CAOTq_pv4dyAkbqye+diK9mTTsrTg9OKg0tExKcfDgs8RfiTwTQ@mail.gmail.com>
	<20111126085455.GB22656@elie.hsd1.il.comcast.net>
	<7v39day0fb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Conrad Irwin <conrad.irwin@gmail.com>,
	=?utf-8?B?4piCSm9zaCBDaGlhICjosKLku7vkuK0p?= <joshchia@gmail.com>,
	git@vger.kernel.org, Soeren Sonnenburg <sonne@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 00:14:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RURS4-0006Ld-Ps
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 00:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab1KZXO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 18:14:28 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45272 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab1KZXO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 18:14:27 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 766441C1DA09;
	Sun, 27 Nov 2011 00:14:24 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id E4A131C000FA;
	Sun, 27 Nov 2011 00:14:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id PrU+NXwya3qi; Sun, 27 Nov 2011 00:09:23 +0100 (CET)
Received: from igel.home (ppp-93-104-150-139.dynamic.mnet-online.de [93.104.150.139])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 27 Nov 2011 00:09:23 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id A689ECA29C; Sun, 27 Nov 2011 00:09:22 +0100 (CET)
X-Yow: Am I elected yet?
In-Reply-To: <7v39day0fb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 26 Nov 2011 14:38:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185960>

Junio C Hamano <gitster@pobox.com> writes:

> I havn't look at the patch (not a regression between 1.7.7 and 1.7.8 so
> not a candidate for the remainder of this cycle), but I like the above
> description quite a lot. I think Linus's "git reset --sane" which was
> initially called "git reset --merge" but ended up as "git reset --keep"
> should have been spelled as "checkout -B <current-branch>" from the
> beginning.

It is more convenient if you don't have to spell out the name of the
current branch (which fails if you aren't on a branch).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
