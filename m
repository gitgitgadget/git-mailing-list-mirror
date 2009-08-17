From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/11] Add  O_BINARY flag to open flag at mingw.c
Date: Mon, 17 Aug 2009 18:58:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171856290.4991@intel-tinevez-2-302>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5Xi-0000aB-Nz
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbZHQQ6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757284AbZHQQ6i
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:58:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:53120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755677AbZHQQ6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:58:37 -0400
Received: (qmail invoked by alias); 17 Aug 2009 16:58:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 17 Aug 2009 18:58:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TyQomLCgTVXP7W0f3N9rgX29/Xeb0g8o2xaXPGP
	wkWZyWk9JlLKi5
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126231>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> Windows will convert CR\LF and union code at text mode.
> Git doesn't like this. Add O_BINARY flag to open function
> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>

How about this instead?

	mingw.c: Use the O_BINARY flag to open files

	On Windows, non-text files must be opened using the O_BINARY flag. 
	MinGW does this for us automatically, but Microsoft Visual C++
	does not.

	Also, Johannes said that this would be a nice cleanup.

BTW what about fopen()?

Patch is obviously good.

Ciao,
Dscho
