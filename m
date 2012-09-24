From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 15:37:18 +0200
Message-ID: <m2zk4fa6ep.fsf@igel.home>
References: <5060097F.9050203@drmicha.warpmail.net>
	<CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com>
	<50601274.80506@drmicha.warpmail.net>
	<CACsJy8ChOd-684V8Dsbwf2nOsW8UMnYn_vo5MAZ6ixyq_QvMkw@mail.gmail.com>
	<5060588D.3080202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 15:37:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG8qp-0006ss-JJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 15:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab2IXNhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 09:37:22 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40185 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab2IXNhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 09:37:21 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XQRKr1cclz4KK84;
	Mon, 24 Sep 2012 15:37:19 +0200 (CEST)
X-Auth-Info: 0hEPyq20fs5WRzpUPGtPYV7Kz2iyFwgct4Psc3DGPg4=
Received: from igel.home (ppp-88-217-96-163.dynamic.mnet-online.de [88.217.96.163])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XQRKq67H0zbblq;
	Mon, 24 Sep 2012 15:37:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 2606CCA2A3; Mon, 24 Sep 2012 15:37:18 +0200 (CEST)
X-Yow: I FORGOT to do the DISHES!!
In-Reply-To: <5060588D.3080202@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 24 Sep 2012 14:56:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206269>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> But that argument applies to config files in exactly the same way as it
> applies to command line arguments. Git is the only one reading them. So
> why not leave it up to Git to decide about expansion?

Command line arguments are first processed by the shell, handling
expansions like $HOME.  It is part of the Unix philosophy that expansion
of command lines is left to the shell.

> On the other hand: If Git expanding arguments is surprising, why is it
> unsurprising if Git expands config values?

The config file is not processed by the shell.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
