From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to
 date with -f
Date: Thu, 12 Feb 2009 21:28:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902122126460.10279@pacific.mpi-cbg.de>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiAw-00039Z-Rw
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633AbZBLU1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 15:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758620AbZBLU1S
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:27:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:54462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756941AbZBLU1R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 15:27:17 -0500
Received: (qmail invoked by alias); 12 Feb 2009 20:27:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 12 Feb 2009 21:27:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18h7n9W6fUhPrdiScUU5WXVhAH6UxdXVeORr1PEsY
	UUf20zmbUzVZof
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109640>

Hi,

On Thu, 12 Feb 2009, Sverre Rabbelier wrote:

> The result would be that all commits in origin/master..master have any
> whitespace errors fixed, but it seems a bit clumsy.

FWIW I typically use 'git rebase --whitespace=fix $(git merge-base 
origin/master master)' for that, but that only works when there is a 
single merge base.

Ciao,
Dscho
