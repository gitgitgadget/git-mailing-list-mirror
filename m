From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Branch renaming not updating the configuration correctly.
Date: Mon, 28 Jul 2008 14:49:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807281445340.8986@racer>
References: <g6ki09$81c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-159937321-1217252969=:8986"
Cc: git@vger.kernel.org
To: =?ISO-8859-2?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Mon Jul 28 15:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNT7P-0001Hk-Tb
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 15:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbYG1Ntb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbYG1Ntb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 09:49:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:41596 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750823AbYG1Nta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 09:49:30 -0400
Received: (qmail invoked by alias); 28 Jul 2008 13:49:29 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp032) with SMTP; 28 Jul 2008 15:49:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hiLJ3HDQhYCLTuANJsYnlvL8oICz588anV0+ZaO
	6RdywTQrIfOAUM
X-X-Sender: gene099@racer
In-Reply-To: <g6ki09$81c$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90459>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-159937321-1217252969=:8986
Content-Type: TEXT/PLAIN; charset=windows-1250
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Jul 2008, Jurko Gospodnetiæ wrote:

> -- .git/config: --
> [branch "aaa"]
> 	remote = .
> 	merge = bbb
> ------------------
> 
>   > git branch -m aaa patched
>   > git branch -m bbb original
> 
> -- .git/config: --
> [branch "patched"]
> 	remote = .
> 	merge = bbb
> ------------------
> 
> And as you can see above, the branch.patched.merge configuration setting 
> did not get updated and still holds the old branch name 'bbb'.

I deem this not an "important" bug.

We usually do not set up tracking information for local branches, and I 
still do not know valid common scenarios for that workflow.

But hey, if it really bothers you, and you can come up with a 
non-intrusive patch (i.e. a patch that does not punish all users that do 
_not_ set up locally-tracking branches), I am sure it will be welcomed.

Ciao,
Dscho

--8323329-159937321-1217252969=:8986--
