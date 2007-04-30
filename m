From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: problem using git on cygwin
Date: Mon, 30 Apr 2007 13:46:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301343020.29859@racer.site>
References: <ace3f33d0704292325t6ab16075rbdeac40a437920e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 13:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiULU-0000gi-Dy
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 13:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031104AbXD3LrE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 07:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031102AbXD3LrD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 07:47:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:39515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031093AbXD3LrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 07:47:00 -0400
Received: (qmail invoked by alias); 30 Apr 2007 11:46:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 30 Apr 2007 13:46:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FsQ4P7sIFadkpSYoXki/3y+sUQ6mDRZPiKyWOY5
	gLCV8S534qZDEY
X-X-Sender: gene099@racer.site
In-Reply-To: <ace3f33d0704292325t6ab16075rbdeac40a437920e8@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45862>

Hi,

On Mon, 30 Apr 2007, srinivas naga vutukuri wrote:

> $ git add project/test.c
> error: bad index file sha1 signature
> fatal: index file corrupt

I could imagine that you do not have "binary mode" default for opening 
files.

However, if you do, maybe your .git/index went corrupt?

As a workaround, you could try "git read-tree HEAD" and then "git add" 
again, but make sure you have a backup of .git/index, since it could be a 
bug in Git(cygwin) and if so, I'd like to fix it.

Ciao,
Dscho
