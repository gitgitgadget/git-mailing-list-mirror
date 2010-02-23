From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [msysGit] [PATCH] submodules: ensure clean environment when
 operating  in a submodule
Date: Tue, 23 Feb 2010 22:47:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002232246560.3980@intel-tinevez-2-302>
References: <20100218203726.GD12660@book.hvoigt.net> <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com> <alpine.DEB.1.00.1002230103160.3609@intel-tinevez-2-302> <20100223210751.GA10932@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:47:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2bK-0004cO-QJ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab0BWVr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:47:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:43422 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752140Ab0BWVrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:47:25 -0500
Received: (qmail invoked by alias); 23 Feb 2010 21:47:22 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 23 Feb 2010 22:47:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19M4g1cUWFMwnJj2OvT1QiCY7RJ6Rge9Z/Xl9SXkk
	ZeJrKsf6kpWcJt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100223210751.GA10932@book.hvoigt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140844>

Hi,

On Tue, 23 Feb 2010, Heiko Voigt wrote:

> On Tue, Feb 23, 2010 at 01:04:00AM +0100, Johannes Schindelin wrote:
> 
> > On Mon, 22 Feb 2010, Giuseppe Bilotta wrote:
> > 
> > > git-submodule takes care of clearing GIT_DIR whenever it operates on 
> > > a submodule index or configuration, but forgot to unset 
> > > GIT_WORK_TREE before operating on the submodule worktree, which 
> > > would lead to failures when GIT_WORK_TREE was set.
> > > 
> > > This only happened in very unusual contexts such as operating on the 
> > > main worktree from outside of it, but since "git-gui: set GIT_DIR 
> > > and GIT_WORK_TREE after setup" (a9fa11fe5bd5978bb) such failures 
> > > could also be provoked by invoking an external tool such as "git 
> > > submodule update" from the Git GUI in a standard setup.
> > 
> > Heiko, would you say that this patch is an elegant solution to the 
> > problem you reported? If so, would you please pull it to 
> > 4msysgit.git's devel?
> 
> I would like to leave the patch cooking a little more.

Yes, that matches my feeling.

Thanks,
Dscho
