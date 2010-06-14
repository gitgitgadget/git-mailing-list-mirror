From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix strcat() on uninitialized memory
Date: Mon, 14 Jun 2010 19:05:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1006141856030.2689@bonsai2>
References: <alpine.DEB.1.00.1006141032250.2689@bonsai2> <AANLkTimSFwn1yykyEOTRdHHBYTFUEhxqj2AinjRv9ECC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 19:06:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOD6v-0006AH-2R
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 19:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab0FNRGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 13:06:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:49894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755952Ab0FNRGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 13:06:01 -0400
Received: (qmail invoked by alias); 14 Jun 2010 17:05:48 -0000
Received: from ASt-Lambert-153-1-65-129.w83-204.abo.wanadoo.fr (EHLO bonsai2.local) [83.204.196.129]
  by mail.gmx.net (mp057) with SMTP; 14 Jun 2010 19:05:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e9OdLO1kedFHPpbVPH0tM1ouMDO593XJq0vslYW
	2sOE4pz/dOW2Fm
X-X-Sender: gene099@bonsai2
In-Reply-To: <AANLkTimSFwn1yykyEOTRdHHBYTFUEhxqj2AinjRv9ECC@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149129>

Hi,

On Mon, 14 Jun 2010, Jay Soffian wrote:

> Thanks, this was caught last week and patch posted by Thomas:
> 
> http://marc.info/?l=git&m=127619546001346&w=2

Great. So it was caught. Why was it not even in 'next', so I wasted my 
time finding the bug?

Anyway, it is in 4msysgit.git's 'devel' branch. So its fixed now.

Frustrated,
Dscho
