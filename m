From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sun, 24 Dec 2006 01:58:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612240156430.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
 <20061223073428.GL9837@spearce.org> <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org>
 <458D84BA.5040301@byu.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 01:58:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyHhM-00053K-Jk
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 01:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbWLXA6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 19:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbWLXA6f
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 19:58:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:33648 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753982AbWLXA6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 19:58:34 -0500
Received: (qmail invoked by alias); 24 Dec 2006 00:58:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 24 Dec 2006 01:58:33 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Blake <ebb9@byu.net>
In-Reply-To: <458D84BA.5040301@byu.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35334>

Hi,

On Sat, 23 Dec 2006, Eric Blake wrote:

> Indeed, on cygwin, using the 1.4.4.3 Makefile setting where NO_MMAP is 
> commented out, I have not seemed to have any mmap problems.

Strictly speaking, it is not commented out. It is not set. And it has been 
pointed out in another mail as well as in another thread that the problems 
without NO_MMAP arise on FAT32 when committing.

Which proves again that "works for me" often is not good enough.

Ciao,
Dscho
