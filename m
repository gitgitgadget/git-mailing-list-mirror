From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Sun, 9 Aug 2009 22:38:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908092238290.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 22:38:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaFA3-0001oH-Jv
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 22:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbZHIUi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 16:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbZHIUiZ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 16:38:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:37515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753113AbZHIUiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 16:38:25 -0400
Received: (qmail invoked by alias); 09 Aug 2009 20:38:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 09 Aug 2009 22:38:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yMkUjVHsygsrGJIOioiauIuKu72WECYmtYVDkvd
	jjtFsntW1G/+4z
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125379>

Hi,

On Sun, 9 Aug 2009, Daniel Barkalow wrote:

> If this is set, the url is not required, and the transport always uses
> a helper named "git-remote-<value>".
> 
> It is a separate configuration option in order to allow a sensible
> configuration for foreign systems which either have no meaningful urls
> for repositories or which require urls that do not specify the system
> used by the repository at that location. However, this only affects
> how the name of the helper is determined, not anything about the
> interaction with the helper, and the contruction is such that, if the
> foreign scm does happen to use a co-named url method, a url with that
> method may be used directly.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---

Oh well, just try it often enough.  I give up.

Ciao,
Dscho
