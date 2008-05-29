From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Listing authors of each file in branch HEAD since given
 revision
Date: Thu, 29 May 2008 13:47:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291344400.13507@racer.site.net>
References: <c6c947f60805290143r731b4a80v8d8297124899be22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 14:49:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1hZT-0007Ik-LE
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 14:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbYE2Msj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbYE2Msj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 08:48:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:51158 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751949AbYE2Msj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 08:48:39 -0400
Received: (qmail invoked by alias); 29 May 2008 12:48:37 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp013) with SMTP; 29 May 2008 14:48:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jqatuCMxjXUR6ogIxHNnhBjcsODtRICttZPDbDf
	lpiqQQrw96VFsR
X-X-Sender: gene099@racer.site.net
In-Reply-To: <c6c947f60805290143r731b4a80v8d8297124899be22@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83194>

Hi,

On Thu, 29 May 2008, Alexander Gladysh wrote:

> For each file in the head of my current branch I need to get a list of 
> all people who altered it since given revision. If file was not changed, 
> it should be not listed.
> 
> Something like:
> 
>   my/file1.ext user1 user2 user3
>   my/file2.ext user1

You will be able to do something like this easily from the output of

git log --pretty=format:%an --name-only HEAD

Probably just a Perl script which reads the author name, and then attaches 
that author name to all following file names until an empty lines occurs, 
recursively.

Hth,
Dscho
