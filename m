From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Tue, 5 Feb 2008 00:51:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050049420.8543@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <47A78104.9050909@nrlssc.navy.mil>
 <alpine.LSU.1.00.0802042128170.8543@racer.site> <47A78CF9.6040001@nrlssc.navy.mil> <alpine.LSU.1.00.0802042218280.8543@racer.site> <47A79541.6070900@nrlssc.navy.mil> <47A79820.50405@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 05 01:52:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMC2z-0003Mt-Is
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450AbYBEAvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757438AbYBEAvx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:51:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:44323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755425AbYBEAvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:51:52 -0500
Received: (qmail invoked by alias); 05 Feb 2008 00:51:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.71]) [86.138.198.40]
  by mail.gmx.net (mp028) with SMTP; 05 Feb 2008 01:51:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+z1R0Gvbmz8ZiHKlGJWmrvWuIqJQbMIOppQBtRao
	Ti8ta5QD2/Sb+c
X-X-Sender: gene099@racer.site
In-Reply-To: <47A79820.50405@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72603>

Hi,

On Mon, 4 Feb 2008, Brandon Casey wrote:

> By the way, none of the repositories has to "own" the .git directory. 
> This is made much easier by Lars's new changes. All of the repos could 
> contain a .git symlink file which points to some other directory.

First, the repository _is_ the .git directory.  Second, we already had 
GIT_DIR and --git-dir, which made it as easy...

Ciao,
Dscho
 
