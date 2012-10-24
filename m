From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git commit-tree man page
Date: Wed, 24 Oct 2012 15:59:41 +0200
Message-ID: <m28vaw7yya.fsf@igel.home>
References: <CAB9Jk9BMndLj_nHW=EQbSS96Gp5+5NA3Vyb0r-EfVd+OPyQhnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 16:00:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR1VF-0007aM-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 16:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934880Ab2JXN7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 09:59:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48574 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934862Ab2JXN7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 09:59:44 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XmtPp2CPCz4KKFt;
	Wed, 24 Oct 2012 15:59:42 +0200 (CEST)
X-Auth-Info: HHqs01LRu1lp6h0Nm9IDp2apMeMuTr9TP7P1nk+KdRc=
Received: from igel.home (ppp-88-217-103-72.dynamic.mnet-online.de [88.217.103.72])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XmtPp1sMvzbbfg;
	Wed, 24 Oct 2012 15:59:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id ECC47CA2A1; Wed, 24 Oct 2012 15:59:41 +0200 (CEST)
X-Yow: Yow!  Is this sexual intercourse yet??  Is it, huh, is it??
In-Reply-To: <CAB9Jk9BMndLj_nHW=EQbSS96Gp5+5NA3Vyb0r-EfVd+OPyQhnA@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 24 Oct 2012 14:45:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208306>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Hello,
>
> the man page of git commit-tree SYNOPSIS is:
>
>     git commit-tree <tree> [(-p <parent>)...] < changelog
>     git commit-tree [(-p <parent>)...] [(-m <message>)...] [(-F
> <file>)...] <tree>
>
> The second form is incorrect: the <tree> must be specified before the options.
> E.g.
>
> $ git commit-tree -m B 88f7dbd47
> fatal: Not a valid object name -m

This has been fixed in 1.7.11.4:

 * "git commit-tree" learned a more natural "-p <parent> <tree>" order
   of arguments long time ago, but recently forgot it by mistake.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
