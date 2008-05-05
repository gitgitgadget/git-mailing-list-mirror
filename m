From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Pay attention to GIT_DIR when searching the git
 directory
Date: Mon, 5 May 2008 14:39:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051437040.30431@racer>
References: <1209946178-29398-1-git-send-email-joerg@alea.gnuu.de> <alpine.DEB.1.00.0805051234260.30431@racer> <20080505125302.GA11523@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-994315661-1209994787=:30431"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon May 05 15:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt0vo-0001kJ-OC
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 15:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYEENjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 09:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYEENjw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 09:39:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:33055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751601AbYEENjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 09:39:51 -0400
Received: (qmail invoked by alias); 05 May 2008 13:39:49 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp005) with SMTP; 05 May 2008 15:39:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tF2ISCFRt26KQMT2689lKrGibV3Fru1O/umIPL7
	fR+ScDoOL/tqr/
X-X-Sender: gene099@racer
In-Reply-To: <20080505125302.GA11523@alea.gnuu.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81280>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-994315661-1209994787=:30431
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 5 May 2008, Jörg Sommer wrote:

> Johannes Schindelin schrieb am Mon 05. May, 12:36 (+0100):
>
> > Please keep in mind that the commit log is meant to demonstrate the 
> > _intention_ of the patches.
> 
> The intention is that the variable GIT_DIR is respected when searching 
> for the git dir.

AFAICT the core of git respects GIT_DIR very much.  Reading your oneline, 
indeed, the whole commit message, scared me a bit, because I thought that 
there was a bug in core git.

Your commit message completely misses out on the fact that it fixes a bug 
in a _hook_, and a _contributed_ at that.

So I would have known _exactly_ what you did if your oneline had read

	contrib/hooks/setgitperms: respect GIT_DIR

Don't you agree?

Ciao,
Dscho

--8323329-994315661-1209994787=:30431--
