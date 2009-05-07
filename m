From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Segfault during merge
Date: Thu, 7 May 2009 11:48:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dave O <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 11:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M20Cy-0000Wq-CQ
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 11:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbZEGJr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 05:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbZEGJrz
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 05:47:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:40282 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753130AbZEGJrz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 05:47:55 -0400
Received: (qmail invoked by alias); 07 May 2009 09:47:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 07 May 2009 11:47:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+L/E8bfP2LjP0eUJWB7dGGgmVW8ptEerzpo/6uvW
	oRpxn4esReX/fx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118458>

Hi,

On Thu, 7 May 2009, Dave O wrote:

> Hi, I've encountered a particular merge that causes a segfault, and was
> able to successfully bisect git to commit 36e3b5e.

As you already found the commit, you could have Cc:ed me already.  It is 
pure luck that I did not miss your bug report.

> However, I'm unable to come up with a simple repro that doesn't involve 
> the source tree that I found it on, which unfortunately I'm not able to 
> share.

Sigh.

> I've debugged this a bit, and it seems to happen only when there's
> sufficient file creations and deletions to surpass rename_limit in
> diffcore_rename, and a rename/delete conflict is encountered.

Maybe you can set merge.renameLimit really small, and then reproduce?

Ciao,
Dscho
