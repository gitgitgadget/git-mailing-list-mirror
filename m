From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Thu, 19 Mar 2009 11:57:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFvU-0001Cd-5D
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbZCSKzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbZCSKzK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:55:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:43983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751836AbZCSKzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:55:08 -0400
Received: (qmail invoked by alias); 19 Mar 2009 10:55:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 19 Mar 2009 11:55:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BpxwcvJgBt6XQgOkuXC40JkasrBgBSvo7EIGRVa
	Wlf1JBb0vr97Gs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113754>

Hi,

On Thu, 19 Mar 2009, Alex Riesen wrote:

> So that Cygwin port can continue work around its supporting
> library and get access to its faked file attributes.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---

[patch not inlined: therefore you'll have to guess what I am referring to]

It seems quite wrong to define something for other platforms when only 
Cygwin is affected.

I'd rather just disable WIN32_STAT for Cygwin, because otherwise, we will 
keep running into issues.

Ciao,
Dscho
