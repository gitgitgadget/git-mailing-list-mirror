From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect
 diff.ignoreSubmodules config variable
Date: Sat, 25 Dec 2010 14:08:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1012251407230.1822@bonsai2>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-3-git-send-email-zapped@mail.ru> <4D15E48A.9050805@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zapped <zapped@mail.ru>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 25 14:08:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWTrV-0003Ik-DH
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 14:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833Ab0LYNIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Dec 2010 08:08:09 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:53208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751721Ab0LYNII (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 08:08:08 -0500
Received: (qmail invoked by alias); 25 Dec 2010 13:08:04 -0000
Received: from ppp-88-217-104-185.dynamic.mnet-online.de (EHLO noname) [88.217.104.185]
  by mail.gmx.net (mp058) with SMTP; 25 Dec 2010 14:08:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188mcB6I7M81ZBieclF/rUt7rUHBB7jJnG5M8L3vi
	OrQK6aKkBLjbzv
X-X-Sender: gene099@bonsai2
In-Reply-To: <4D15E48A.9050805@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164176>

Hi,

On Sat, 25 Dec 2010, Jens Lehmann wrote:

> In commit 37aea37 Dscho (CCed) introduced this configuration setting 
> while explicitly stating that it only affects porcelain. As the other 
> config options always influence porcelain and plumbing, it looks like we 
> would want to have this option honored by plumbing too, no?

IIRC Junio was real happy that I did not honor plumbing.

Ciao,
Dscho
