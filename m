From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect
 diff.ignoreSubmodules config variable
Date: Mon, 27 Dec 2010 23:06:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1012272256560.1794@bonsai2>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-3-git-send-email-zapped@mail.ru> <4D15E48A.9050805@web.de> <7vd3ooz6qd.fsf@alter.siamese.dyndns.org> <4D187511.3090104@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Zapped <zapped@mail.ru>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 27 23:09:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXLGH-0008Ly-5n
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 23:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab0L0WGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 17:06:42 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:46964 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750846Ab0L0WGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 17:06:41 -0500
Received: (qmail invoked by alias); 27 Dec 2010 22:06:40 -0000
Received: from ppp-93-104-144-209.dynamic.mnet-online.de (EHLO noname) [93.104.144.209]
  by mail.gmx.net (mp035) with SMTP; 27 Dec 2010 23:06:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nlq1Yj0InXqZpO+GdtOFTyvWYX6VHHoFdZCqZSt
	pDCXkvJe2hZszk
X-X-Sender: gene099@bonsai2
In-Reply-To: <4D187511.3090104@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164226>

Hi Jens,

On Mon, 27 Dec 2010, Jens Lehmann wrote:

> [...]
>
> And it looks like the PS1 problem that started this discussion is a
> valid example for mixed usage of porcelain and plumbing commands.

The distinction between porcelain and plumbing commands is not as 
clear-cut as some people would like it to be (just call "git grep 'git 
log'" in a git.git checkout). IMHO the reason is that a distinction 
between porcelain and plumbing makes sense in the world of sanitary 
engineering, but not necessarily in the world of software (a distinction 
between assembler vs source code, or GUI vs library makes sense, but not 
between "programs to be called by humans" and "programs to be called by 
other programs").

Note: I do not think that the "plumbing" concept was not well-intended, 
but I doubt that the concept holds up in the face of reality.

I fear, though, that we cannot simply abolish the notion "plumbing vs 
porcelain" from git.git...

Ciao,
Dscho
