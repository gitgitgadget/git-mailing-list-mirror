From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Fri, 20 Jan 2012 15:13:58 +0100
Message-ID: <m2ehuu8nrt.fsf@igel.home>
References: <201201201433.30267.brian.foster@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@maxim-ic.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 15:14:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoFEd-0006cG-8u
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 15:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab2ATOOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 09:14:05 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41919 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2ATOOD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 09:14:03 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 5DB5E1C1DA09;
	Fri, 20 Jan 2012 15:13:58 +0100 (CET)
X-Auth-Info: j/nPlVgtL/8u8V1RYbAR/BS9cau7OO7YrNfDMfBnT6k=
Received: from igel.home (ppp-93-104-154-113.dynamic.mnet-online.de [93.104.154.113])
	by mail.mnet-online.de (Postfix) with ESMTPA id 941AD1C0005A;
	Fri, 20 Jan 2012 15:13:58 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 4A0D5CA299; Fri, 20 Jan 2012 15:13:58 +0100 (CET)
X-Yow: HELLO, little boys!   Gimme a MINT TULIP!!  Let's do the BOSSA NOVA!!
In-Reply-To: <201201201433.30267.brian.foster@maxim-ic.com> (Brian Foster's
	message of "Fri, 20 Jan 2012 14:33:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188880>

Brian Foster <brian.foster@maxim-ic.com> writes:

>  In a script, how can I determine commit Y is reachable
>  from the current HEAD ?

test $(git merge-base HEAD Y) = $(git rev-parse Y)

>  And, much more importantly
>  for my purposes, that commit N is _not_-reachable from
>  the current HEAD ?

test $(git merge-base HEAD N) != $(git rev-parse N)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
