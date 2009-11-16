From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Mon, 16 Nov 2009 13:35:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911161333470.4985@pacific.mpi-cbg.de>
References: <cover.1258309432.git.trast@student.ethz.ch> <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Nov 16 13:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA0mx-0000Nr-0w
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 13:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbZKPMb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 07:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbZKPMb0
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 07:31:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:41412 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752591AbZKPMb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 07:31:26 -0500
Received: (qmail invoked by alias); 16 Nov 2009 12:31:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 16 Nov 2009 13:31:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HzPkWNPmHXALyorOk4Db37zj7NMO1p2XA2HJd7v
	LwMAjz7I8fU4Ar
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133007>

Hi,

On Sun, 15 Nov 2009, Thomas Rast wrote:

> Using the "ours" strategy with rebase just discards all changes, turning 
> <branch> into <upstream> (or <newbase> if given).  This is unlikely to 
> be what the user wants, so simply refuse to do it.

"Unlikely" or "impossible"?

Besides, I find it rather arbitrary that the "ours" strategy is refused, 
but none of the user-provided merge strategies.  IOW disallowing "ours" 
may very well foster unreasonable expectations.

Ciao,
Dscho
