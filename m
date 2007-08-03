From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 12:43:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031240450.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 13:43:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGvZJ-0006wQ-FV
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 13:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760718AbXHCLnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 07:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758937AbXHCLnm
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 07:43:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:34490 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759811AbXHCLnl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 07:43:41 -0400
Received: (qmail invoked by alias); 03 Aug 2007 11:43:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 03 Aug 2007 13:43:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1879oxSu0I7Xrb3SJGnXHuZwEAlXPEcGDMTAI5K0U
	ZPCHyrYLBYLBoL
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54708>

Hi,

On Fri, 3 Aug 2007, Dmitry Kakurin wrote:

> Johannes, please add me as a user to this Google project and I'll
> upload the files.

Done.

> The changes that I've made:
> * removed .git in /git directory to save space
> * installed gdb
> * applied my Vista fix
> * made self-extracting .rar archive
> 
> Tatal size is 19+4 MB.

With Vista fix you mean both adding the USE_MINGW_ACCESS define and 
copying cc1.exe to /bin?

And have you tried a 7-zip LZMA self extracting file?  I guess it is 
smaller: for the moment I have two files there, totalling 30.2M.  15M of 
which is the virtually uncompressible pack file in .git/.  Which leaves...

Ciao,
Dscho
