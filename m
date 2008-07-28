From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-verify-tag: fix -v option parsing
Date: Mon, 28 Jul 2008 14:10:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281408270.2725@eeepc-johanness>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-2-git-send-email-barra_cuda@katamail.com> <4888B4E3.9000504@free.fr> <alpine.DEB.1.00.0807241807550.8986@racer> <4889EF22.6020604@free.fr> <488DA40C.8020400@free.fr>
 <alpine.DEB.1.00.0807281306090.2725@eeepc-johanness> <488DB0BD.2060406@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-302588541-1217247023=:2725"
Cc: Junio C Hamano <gitster@pobox.com>,
	Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNRYP-0000W2-RK
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 14:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYG1MJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 08:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYG1MJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 08:09:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:54732 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751496AbYG1MJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 08:09:16 -0400
Received: (qmail invoked by alias); 28 Jul 2008 12:09:14 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp047) with SMTP; 28 Jul 2008 14:09:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MYehQUVPMVYgi3xjh0D2iE1U6mmoqcDO33vPZy4
	RdvAIEJ7CKXAR0
X-X-Sender: user@eeepc-johanness
In-Reply-To: <488DB0BD.2060406@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90449>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-302588541-1217247023=:2725
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Jul 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> >>
> >> Since the C rewrite, "git verify-tag -v" just does nothing instead of 
> >> printing the usage message with an error. This patch fix the 
> >> regression.
> > 
> > Maybe a better solution would be to convert (trivially) to 
> > parse-options...
> 
> I am very puzzled.
> 
> You first asked me to do a separate commit with just the fix and now you 
> seem to want the fix with the conversion...

Sorry.  It was not obvious to myself when I asked for a separate patch 
that the fix would fall out of the conversion to parse-options.

My fault,
Dscho
--658432-302588541-1217247023=:2725--
