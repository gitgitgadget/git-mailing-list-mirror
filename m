From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: permissions
Date: Sat, 05 Jun 2010 11:50:03 +0200
Message-ID: <m27hmdn704.fsf@igel.home>
References: <4C0A19FE.1020802@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 11:50:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKq17-0006LI-I2
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 11:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702Ab0FEJuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 05:50:06 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52871 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688Ab0FEJuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 05:50:05 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 189821C005EE;
	Sat,  5 Jun 2010 11:50:04 +0200 (CEST)
Received: from igel.home (ppp-88-217-114-32.dynamic.mnet-online.de [88.217.114.32])
	by mail.mnet-online.de (Postfix) with ESMTP id 0C4771C0020B;
	Sat,  5 Jun 2010 11:50:04 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id D0CFCCA297; Sat,  5 Jun 2010 11:50:03 +0200 (CEST)
X-Yow: I'm not an Iranian!!  I voted for Dianne Feinstein!!
In-Reply-To: <4C0A19FE.1020802@wpursell.net> (William Pursell's message of
	"Fri, 04 Jun 2010 23:33:50 -1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148465>

William Pursell <bill.pursell@gmail.com> writes:

> After all, it is a git repository, so "Not a git repository"
> is not accurate.

A valid git repository requires more than a .git directory.

$ git init
Initialized empty Git repository in /tmp/x/.git/
$ rm .git/HEAD 
$ git status
fatal: Not a git repository (or any of the parent directories): .git

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
