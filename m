From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] submodules: ensure clean environment when
 operating  in a submodule
Date: Tue, 23 Feb 2010 01:04:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002230103160.3609@intel-tinevez-2-302>
References: <20100218203726.GD12660@book.hvoigt.net> <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjiG4-0006Ji-Tc
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab0BWAEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:04:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:35797 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751710Ab0BWAEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:04:06 -0500
Received: (qmail invoked by alias); 23 Feb 2010 00:04:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 23 Feb 2010 01:04:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KmVo5xIoKOaMK8tfVQuDkhBQFRnjK7TNgx8fvBh
	tPCaLjDgIZ6EkX
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.60999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140743>

Hi,

On Mon, 22 Feb 2010, Giuseppe Bilotta wrote:

> git-submodule takes care of clearing GIT_DIR whenever it operates
> on a submodule index or configuration, but forgot to unset GIT_WORK_TREE
> before operating on the submodule worktree, which would lead to failures
> when GIT_WORK_TREE was set.
> 
> This only happened in very unusual contexts such as operating on the
> main worktree from outside of it, but since "git-gui: set GIT_DIR and
> GIT_WORK_TREE after setup" (a9fa11fe5bd5978bb) such failures could also
> be provoked by invoking an external tool such as "git submodule update"
> from the Git GUI in a standard setup.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---

Heiko, would you say that this patch is an elegant solution to the problem 
you reported? If so, would you please pull it to 4msysgit.git's devel?

Thanks,
Dscho
