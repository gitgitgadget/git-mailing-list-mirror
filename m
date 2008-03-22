From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/5] rebase with preserve merges should not show merged
 commits
Date: Sat, 22 Mar 2008 15:46:28 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803221545100.4124@racer.site>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de> <1206194907-3340-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1510030358-1206197190=:4124"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 15:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd503-0002Hq-2A
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 15:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbYCVOq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 10:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbYCVOq3
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 10:46:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:60435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750826AbYCVOq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 10:46:29 -0400
Received: (qmail invoked by alias); 22 Mar 2008 14:46:26 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp005) with SMTP; 22 Mar 2008 15:46:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dLuFQCUAdSqvf2F051LXGw1RWjeqImj+KLrGgd1
	Q6z995g85ftt5k
X-X-Sender: gene099@racer.site
In-Reply-To: <1206194907-3340-1-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77814>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1510030358-1206197190=:4124
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 22 Mar 2008, Jörg Sommer wrote:

> The current version of git-rebase--interactive shows the user the 
> commits coming from a merge.
> 
> M---A---B
>  \       \
>   o---o---+---o branch
> 
> Rebasing branch on M with preserve merges gives the commits A and B. But 
> if you mark them for editing or remove them the rebase fails. You must 
> keep them as they are. It's useless to bother the user with these 
> commits and might lead to mistakes.

It is not useless.  It's just that you seemed to have found buggy 
behaviour.  I am _totally_ opposed to your patch without even reading more 
than the commit message.

Ciao,
Dscho
--8323584-1510030358-1206197190=:4124--
