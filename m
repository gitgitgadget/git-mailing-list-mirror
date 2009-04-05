From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Sun, 5 Apr 2009 13:50:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904051350350.10279@pacific.mpi-cbg.de>
References: <20090401180627.GA14716@localhost> <1238892420-721-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Michael Johnson <redbeard@mdjohnson.us>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 05 13:49:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqQrM-0000Yz-4l
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 13:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbZDELsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 07:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZDELsY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 07:48:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:41601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752479AbZDELsX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 07:48:23 -0400
Received: (qmail invoked by alias); 05 Apr 2009 11:48:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 05 Apr 2009 13:48:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WuWhmM1cWYdgieN1NoXQpO4NQXNacCsPMFkZU0i
	89CBBGAdnY67hK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1238892420-721-1-git-send-email-drizzd@aon.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115657>

Hi,

On Sun, 5 Apr 2009, Clemens Buchacher wrote:

> The segmentation fault is caused by a null pointer dereference which 
> happens during recursive merge with a submodule conflict between two 
> merge bases. This is fixed by the following patches.
> 
> However, there are other problems with merging submodules. For example, 
> git diff aborts with "fatal: read error 'sub'" for conflicting 
> submodules. I have also added a test for this.
> 
> Dscho has already started working on related issues. I have therefore 
> skipped t7404, which is already used in Dscho's work.

Thanks for working on this,
Dscho
