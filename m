From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git rebase --edit
Date: Fri, 12 Feb 2010 10:29:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002121026380.20986@pacific.mpi-cbg.de>
References: <be6fef0d1002120044w5f14d061t52863fbc8b0bd304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfrkj-0005xS-3E
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840Ab0BLJWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:22:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:59979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718Ab0BLJWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 04:22:49 -0500
Received: (qmail invoked by alias); 12 Feb 2010 09:22:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 12 Feb 2010 10:22:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VtNldfTMVnCWqNhy+swV36Dl6Y2uWn78LsXSIYd
	UOk/98slDQ88rR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d1002120044w5f14d061t52863fbc8b0bd304@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139668>

Hi,

On Fri, 12 Feb 2010, Tay Ray Chuan wrote:

> [description how to amend a single commit that is not HEAD]
>
> Perhaps git-rebase --interactive could learn an option, say, --edit
> <commit>, that
> 
>   1. determines where to start the rebase (instead of saying <commit>^ above),
>   2. marks <commit> as 'e' in git-rebase-todo,
>   3. start the edit process ("You can amend the commit now...").
> 
> The user would then proceed with the usual git-rebase --continue.
> 
> Is this a workable suggestion?

Sure!

Note that the current workflow for such things is to make a temporary 
commit which is then handled by the new "fixup" command. But of course, 
this only works if your history is not messy, i.e. has too many changes in 
the same place (because then the fixup commit does not apply cleanly to 
the commit in question).

Ciao,
Dscho
