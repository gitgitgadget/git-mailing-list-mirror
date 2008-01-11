From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 21:29:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801112127040.31053@racer.site>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDRSC-0008Fq-Fm
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760450AbYAKV3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760512AbYAKV3c
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:29:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:41831 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760450AbYAKV3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 16:29:31 -0500
Received: (qmail invoked by alias); 11 Jan 2008 21:29:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 11 Jan 2008 22:29:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2+6BRrDG2v0ruXXfUPnBsvVTsQp0uJUHsLlkfJE
	ivAApmKdcp82MC
X-X-Sender: gene099@racer.site
In-Reply-To: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70209>

Hi,

On Fri, 11 Jan 2008, Kevin Ballard wrote:

> Somehow I managed to change the case of a directory without git 
> realizing it. I thought I issued `git mv CS4536 cs4536` but since that 
> won't work in my efforts to reproduce the problem, I must have simply 
> issued the `mv` outside of git and then re-added it.
> 
> Anyway, here's the state of my directory:
> 
> kevin@KBALLARD:~/Documents/School/C07> git ls-tree HEAD
> 040000 tree b47c8103e2e01fcf145bdc237c0e56ffc61f1c47	CS4536
> 040000 tree dbf7fc51ef3effebdf9b4e9172e4c86cae52b163	cs4536
> 040000 tree 15834a7b6534a285bf6930be4e5404b37e1dc718	ece3601
> 040000 tree 62d229b8c4a389b550df20a3752d666c48c767a4	ma2071
> 
> Note that I have both versions of the directory present. Unfortunately, 
> only one of them can be present on the filesystem. If I run `mv cs4536 
> CS4536; git reset --hard` I end up with a different working tree.
> 
> Git should be able to detect this sort of conflict on a case-insensitive 
> system.

Do not blame git for the shortcomings of your setup!

However, as luck has it, I looked into this issue again, as somebody 
raised it with msysgit (for obvious reasons; file systems on Windows are 
case challenged).  If you are serious about this problem, I can give you 
tons of pointers how to go solve it.  (Although I might be disconnected 
this weekend, because of the lack of competence of the IT department 
here.)

Ciao,
Dscho
