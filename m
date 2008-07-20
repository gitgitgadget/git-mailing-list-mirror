From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git cvsimport and deleted files
Date: Sun, 20 Jul 2008 14:49:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201448020.3305@eeepc-johanness>
References: <18563.10979.379533.580413@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKYMp-0004Et-OH
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbYGTMtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbYGTMtI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:49:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:42200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754462AbYGTMtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:49:07 -0400
Received: (qmail invoked by alias); 20 Jul 2008 12:49:05 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp002) with SMTP; 20 Jul 2008 14:49:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/k9fhQ1NXkSc/N20fiO8bkawxzeNzrq0nlD4Dm6q
	1CtLkmmmey4K8t
X-X-Sender: user@eeepc-johanness
In-Reply-To: <18563.10979.379533.580413@cargo.ozlabs.ibm.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89196>

Hi,

On Sun, 20 Jul 2008, Paul Mackerras wrote:

> I just tried importing the CVS repository for a long-running project
> (ppp) into git using git cvsimport.  It looks like git cvsimport
> doesn't notice when files have been deleted, so files that used to be
> present and were subsequently deleted are present in the git tree for
> the most recent commit.

I never had that problem.  See 
http://repo.or.cz/w/libvncserver.git?a=commit;h=8dead0759febaa7176507e1bde13ebd9d2a30720
for a commit that was imported with cvsimport.

So your issue must lie somewhere else.

BTW do you have the repository locally?  Then you should import with 
cvs2svn or parsecvs instead.  These programs are both faster and more 
accurate than cvsimport.  And AFAIK you can use cvsimport on the generated 
repositories to update them incrementally.

Ciao,
Dscho
