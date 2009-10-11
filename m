From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: combine git repo historically
Date: Sun, 11 Oct 2009 11:34:48 +0200
Message-ID: <m2bpkes287.fsf@igel.home>
References: <20091009012254.GA3980@debian.b2j>
	<4ACED204.3000907@viscovery.net> <20091010140358.GA3924@debian.b2j>
	<200910110436.52653.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bill lam <cbill.lam@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 11:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwurO-0003HU-Cx
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 11:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbZJKJfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 05:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbZJKJfj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 05:35:39 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52015 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZJKJfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 05:35:38 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 973B71C15497;
	Sun, 11 Oct 2009 11:34:50 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 79E4D901B7;
	Sun, 11 Oct 2009 11:34:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id YiYclCw1zuiK; Sun, 11 Oct 2009 11:34:49 +0200 (CEST)
Received: from igel.home (DSL01.83.171.184.49.ip-pool.NEFkom.net [83.171.184.49])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 11 Oct 2009 11:34:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id DF9C110C5C0; Sun, 11 Oct 2009 11:34:48 +0200 (CEST)
X-Yow: HAIR TONICS, please!!
In-Reply-To: <200910110436.52653.chriscool@tuxfamily.org> (Christian Couder's
	message of "Sun, 11 Oct 2009 04:36:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129910>

Christian Couder <chriscool@tuxfamily.org> writes:

> You want N' to have the same content as N but to have M as parent. So you 
> could do something like the following:
>
> (We suppose that commits A to M are in branch1 and that you are in the root 
> directory of your repo2 working directory.)
>
> $ git checkout -b repo1-branch1 remote/repo1/branch1
> $ git checkout N -- .
> $ export GIT_AUTHOR_NAME=<author name of commit N>
> $ export GIT_AUTHOR_EMAIL=<author email of commit N>
> $ export GIT_AUTHOR_DATE=<date of commit N>
> $ git commit -a

Isn't that what git cherry-pick does?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
