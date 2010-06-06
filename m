From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Moving a branch to a different node
Date: Mon, 07 Jun 2010 00:19:40 +0200
Message-ID: <m2hblfregz.fsf@igel.home>
References: <C831D94B.1D9DF%mikesol@ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Mike Solomon <mikesol@UFL.EDU>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:19:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLOC4-0004tG-4a
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab0FFWTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:19:43 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:48809 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279Ab0FFWTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:19:42 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 99ADB1C002EF;
	Mon,  7 Jun 2010 00:19:40 +0200 (CEST)
Received: from igel.home (ppp-88-217-107-136.dynamic.mnet-online.de [88.217.107.136])
	by mail.mnet-online.de (Postfix) with ESMTP id CBE1E1C002FD;
	Mon,  7 Jun 2010 00:19:40 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 70AA4CA29C; Mon,  7 Jun 2010 00:19:40 +0200 (CEST)
X-Yow: Spreading peanut butter reminds me of opera!!  I wonder why?
In-Reply-To: <C831D94B.1D9DF%mikesol@ufl.edu> (Mike Solomon's message of "Sun,
	06 Jun 2010 23:01:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148556>

Mike Solomon <mikesol@UFL.EDU> writes:

> Hey git users,
>     I am working on a project where I proceeded by the following steps:
>
> starting from master...
> 1) create branch foo
> 2) work in foo, make some commits, then a patch named Foo
> 3) create a branch bar while in foo
> 4) work in bar, make some commits, then a patch named Bar
>
> git show-branch gives me
>
> ! [master] Hello
>  * [foo] Foo
>   ! [bar] Bar
>
> I would like to make bar split off of master instead of foo so that I can
> format a patch that can be applied to master (Bar) without having to first
> apply Foo.  Is there a way to do that?

IIUC you want to rebase the commits in bar that are not in foo onto
master.

$ git rebase --onto master foo bar

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
