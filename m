From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: modifying the commits before push
Date: Wed, 18 Jan 2012 23:01:39 +0100
Message-ID: <m262g8r7p8.fsf@igel.home>
References: <87wr8o3nq0.fsf@gnu.org> <4F17291A.8020600@dirk.my1.cc>
	<87sjjc3cpj.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Wed Jan 18 23:01:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RndZm-0008Sp-1g
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab2ARWBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:01:45 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:35301 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab2ARWBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 17:01:45 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 281B318001E4;
	Wed, 18 Jan 2012 23:01:41 +0100 (CET)
X-Auth-Info: zHA3l2xbaLoNYEjvti7NqYdfzvSg66ff/dAV78hu9RM=
Received: from igel.home (ppp-88-217-119-99.dynamic.mnet-online.de [88.217.119.99])
	by mail.mnet-online.de (Postfix) with ESMTPA id 377861C0008A;
	Wed, 18 Jan 2012 23:01:41 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id A1D4BCA29A; Wed, 18 Jan 2012 23:01:40 +0100 (CET)
X-Yow: I'm having a BIG BANG THEORY!!
In-Reply-To: <87sjjc3cpj.fsf@gnu.org> (Sam Steingold's message of "Wed, 18 Jan
	2012 16:47:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188766>

Sam Steingold <sds@gnu.org> writes:

> alas, I could not push because the remote tree was modified in the
> meantime, I pulled and now:
>
> # On branch master
> # Your branch is ahead of 'origin/master' by 23 commits.

What exactly did you do to get the additional 19 commits?

> is there a way for me to get back my original 4 patches, reset my tree
> (maybe by rm-rf+clone) and then re-apply them?

You can find them in the reflog (git log -g).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
