From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Eliminate redirection to stdout and stderr when quiet
 option  is available
Date: Thu, 14 May 2009 09:35:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905140934560.27348@pacific.mpi-cbg.de>
References: <6f5a4e780905140013g75d85558tfaa3c85430f8a8a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Dan Loewenherz <daniel.loewenherz@yale.edu>
X-From: git-owner@vger.kernel.org Thu May 14 09:36:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4VUP-0007G7-T9
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZENHfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbZENHfi
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:35:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:41775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752460AbZENHfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 03:35:38 -0400
Received: (qmail invoked by alias); 14 May 2009 07:35:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 14 May 2009 09:35:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uGGUP/G6usIKvBuxdmhK2z5gn3t8X7L3QkPUsHL
	H1OS1YzNKhJ2oJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <6f5a4e780905140013g75d85558tfaa3c85430f8a8a3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119162>

Hi,

On Thu, 14 May 2009, Dan Loewenherz wrote:

> This follows an earlier commit (7bd93c1) that eliminates the usage of
> `>dev/null 2>&1` and friends when a `--quiet` option is available.

I like this patch, but I think that

	git rev-parse -q HEAD

_does_ output a commit name...

Ciao,
Dscho
