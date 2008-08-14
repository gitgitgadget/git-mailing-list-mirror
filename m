From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] git-daemon: make the signal handler almost a no-op
Date: Thu, 14 Aug 2008 15:41:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808141539210.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl> <20080813084331.30845.74788.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Aug 14 15:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTd1W-0000zP-DQ
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 15:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbYHNNgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 09:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754349AbYHNNgv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 09:36:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:32808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752980AbYHNNgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 09:36:50 -0400
Received: (qmail invoked by alias); 14 Aug 2008 13:36:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 14 Aug 2008 15:36:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tu7t6j9Utc90pmDItLJ8N1hAzBKGpv4KlmlF20D
	9iEjpswaiDyNJS
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080813084331.30845.74788.stgit@aristoteles.cuci.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92357>

Hi,

On Wed, 13 Aug 2008, Stephen R. van den Berg wrote:

> by exploiting the fact that systemcalls get interrupted by signals; and 
> even they aren't, all zombies will be collected before the next 
> accept(). Fix another error() -> logerror() call.

I find this commit message more than cryptic.  So much so that I would 
have to study the patch in detail to _understand_ what it does.

Not having the time, I refuse,
Dscho

P.S.: Oh, and I might have been a little appalled by the language of your 
commit messages.
