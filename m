From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git add --interactive: Autoselect single patch file
Date: Sat, 22 Mar 2008 15:51:29 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803221549570.4124@racer.site>
References: <1206148960-29563-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1129246514-1206197491=:4124"
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 15:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd54v-0003qy-Hl
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 15:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbYCVOva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 10:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbYCVOva
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 10:51:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:59309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbYCVOv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 10:51:29 -0400
Received: (qmail invoked by alias); 22 Mar 2008 14:51:28 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp018) with SMTP; 22 Mar 2008 15:51:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xduBPj91x3sP+JbrkGgdZwcO9OUShSy6+z2mLI3
	b00eWk3a4UatpD
X-X-Sender: gene099@racer.site
In-Reply-To: <1206148960-29563-1-git-send-email-joerg@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77815>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1129246514-1206197491=:4124
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 22 Mar 2008, Jörg Sommer wrote:

> If there's only one file to patch, select it automaticly and don't 
> bother the user. In the case he didn't want do patching, he can say 'd' 
> at the patch prompt.

It also triggers when you specified a single path:

	$ git add -i that-file.c

I like it.

However, if I already specify (a) file(s), could add -i not go to the 
[p]atch option right away?

Ciao,
Dscho
--8323584-1129246514-1206197491=:4124--
