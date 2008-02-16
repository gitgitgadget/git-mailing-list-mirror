From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: warning: no common commits - slow pull
Date: Sat, 16 Feb 2008 21:22:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802162115030.30505@racer.site>
References: <200802102007.38838.lenb@kernel.org> <7v4pcgcimw.fsf@gitster.siamese.dyndns.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 22:23:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQUVT-0001cp-5W
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 22:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbYBPVWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 16:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756798AbYBPVWy
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 16:22:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:38078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756773AbYBPVWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 16:22:53 -0500
Received: (qmail invoked by alias); 16 Feb 2008 21:22:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 16 Feb 2008 22:22:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xlm8PRj5xlpd5QOWPwwo1eEiBIRDXj27xx/pWr9
	+dqlR2lPOybWG+
X-X-Sender: gene099@racer.site
In-Reply-To: <200802151643.30232.lenb@kernel.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74080>

Hi,

On Fri, 15 Feb 2008, Len Brown wrote:

> [lenb@d975xbx2 linus (master)]$ git pull
> remote: Counting objects: 649, done.
> remote: Compressing objects: 100% (106/106), done.
> remote: Total 513 (delta 417), reused 503 (delta 407)
> Receiving objects: 100% (513/513), 116.67 KiB, done.
> Resolving deltas: 100% (417/417), completed with 103 local objects.
> warning: no common commits
> remote: Counting objects: 710725, done.
> remote: Compressing objects: 100% (125738/125738), done.
> remote: Total 710725 (delta 589584), reused 704450 (delta 584029)
> Receiving objects: 100% (710725/710725), 172.71 MiB | 1073 KiB/s, done.
> Resolving deltas: 100% (589584/589584), done.
> >From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>  * [new tag]         v2.6.25-rc2 -> v2.6.25-rc2

Now, this is funny.  Apparently, everything worked fine for the master 
branch (I suppose it is the master branch, anyway), but went wrong for 
fetching the _tag_.

> [lenb@d975xbx2 linus (master)]$ git --version
> git version 1.5.4.1.122.gaa8d

I do not have that git version, but something is fishy there, so I guess 
it depends on your particular version.

Ciao,
Dscho
