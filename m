From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git-remote
Date: Fri, 5 Jan 2007 14:53:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701051448560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
 <8aa486160701050459p4da586cdk2c2ddaabda5b4ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1671339583-1168005198=:22628"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 14:53:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2pVh-0000NY-Gl
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 14:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbXAENxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 08:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbXAENxV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 08:53:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:35543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161093AbXAENxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 08:53:20 -0500
Received: (qmail invoked by alias); 05 Jan 2007 13:53:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 05 Jan 2007 14:53:18 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <8aa486160701050459p4da586cdk2c2ddaabda5b4ca7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36002>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1671339583-1168005198=:22628
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 5 Jan 2007, Santi Béjar wrote:

> * In "git remote add <name> <remote>": git could use the remote url to 
> deduce a <name>, like what git-clone does.

That does not make any sense. For example, I track 
"git://git.kernel.org/.../git.git" and "192.168.0.128:gits/git.git". 
Something very similar applies to the host name: if you track multiple 
Linux repos, chances are that most of them are on git.kernel.org.

I guess _if_ you have more than one upstream you are tracking (which is 
not the most common case, but hey, git-remote is for exactly that case) it 
is not uncommon to have similar urls.

IMHO Junio's proposal is as good as it gets.

Ciao,
Dscho

---1148973799-1671339583-1168005198=:22628--
