From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: gitk normal use on linux repo and severe memory pressure
Date: Wed, 25 May 2011 19:01:30 +0200
Message-ID: <m2pqn667f9.fsf@igel.home>
References: <BANLkTinrj2AOCMMWazf2F4eKy7Sy56K0vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 19:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPHSi-0001ny-BC
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab1EYRBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 13:01:34 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40478 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab1EYRBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 13:01:33 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id A38EE188B5A1;
	Wed, 25 May 2011 19:01:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id A963B1C00085;
	Wed, 25 May 2011 19:01:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id UFokZKtARr-1; Wed, 25 May 2011 19:01:31 +0200 (CEST)
Received: from igel.home (ppp-88-217-117-194.dynamic.mnet-online.de [88.217.117.194])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 25 May 2011 19:01:30 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 3E6BDCA29C; Wed, 25 May 2011 19:01:30 +0200 (CEST)
X-Yow: It don't mean a THING if you ain't got that SWING!!
In-Reply-To: <BANLkTinrj2AOCMMWazf2F4eKy7Sy56K0vg@mail.gmail.com> (Martin
	Langhoff's message of "Wed, 25 May 2011 11:20:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174430>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I am tempted to set a global config option limiting gitk to a couple
> thousand commits, but it's not really the right solution. If I am
> trawling older history, I'll hit the limit and have to close gitk and
> reopen overriding the parameter.

You can start gitk with --max-count=N and if you need more commits you
can edit the current view to increase that number.  No need to restart
gitk.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
