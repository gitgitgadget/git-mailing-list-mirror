From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] very small cleanup: #undef a macro that isn't used
 anywhere else
Date: Mon, 10 Nov 2008 20:09:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811102008330.30769@pacific.mpi-cbg.de>
References: <200811101928.27207.fg@one2team.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:03:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzc2p-0002bs-Gy
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbYKJTCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbYKJTCM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:02:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:56356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753926AbYKJTCL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:02:11 -0500
Received: (qmail invoked by alias); 10 Nov 2008 19:02:05 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 10 Nov 2008 20:02:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gBi5dsFwg3qbFfVTDVBfd/WXpmkkWj1Yn3MBJmm
	XDR3NGsHLGZzZr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200811101928.27207.fg@one2team.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100543>

Hi,

On Mon, 10 Nov 2008, Francis Galiegue wrote:

> In xdiff-interface.c, the FIRST_FEW_BYTES macro is defined, is never 
> used anwhere else, so we might as well undefine it after we're done with 
> it.

Would not the consequence be that we end up with a ton of #undefines all 
over the place, reducing readability incredibly?

Ciao,
Dscho
