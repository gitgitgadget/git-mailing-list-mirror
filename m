From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 5 Oct 2009 22:50:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910052248500.4985@pacific.mpi-cbg.de>
References: <4AC8F22F.5070101@gmail.com> <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de> <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com> <alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de> <fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com>
 <6672d0160910050910x3a9aa6a3w742c09e7f2f42187@mail.gmail.com> <87ab05r5hg.fsf@dylle.kalibalik.dk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1847559614-1254775806=:4985"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Anders Melchiorsen <mail@spoon.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuuXG-0003Lx-Q1
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 22:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbZJEUsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 16:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbZJEUs3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 16:48:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:53242 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754594AbZJEUs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 16:48:29 -0400
Received: (qmail invoked by alias); 05 Oct 2009 20:47:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 05 Oct 2009 22:47:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zVyM18NdzR9p15DVWIJXOkc1niS57Fs+XNFdiAI
	F95NiIG8vxuVmd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87ab05r5hg.fsf@dylle.kalibalik.dk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129586>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1847559614-1254775806=:4985
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 5 Oct 2009, Anders Melchiorsen wrote:

> Björn Gustavsson <bgustavsson@gmail.com> writes:
> 
> > Thanks for the comments. "reword" it will be then. I'll send a new patch soon.
> 
> If you could also make it possible to edit the commit summary line
> right in the git-rebase-todo buffer, that would be great.
> 
> Being in an editor but still not able to fix typos is a nuisance.

NAK.

Supporting that would be totally out of line with the way rebase -i is 
supposed to work.

Besides, if you already have typos in the commit subject, you _better_ 
check the whole commit message, so: double NAK.

Ciao,
Dscho

--8323328-1847559614-1254775806=:4985--
