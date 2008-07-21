From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
 returns st_size 0
Date: Mon, 21 Jul 2008 19:20:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807211917440.8986@racer>
References: <20080721173511.GB5387@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL013-0004ve-7U
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYGUSUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbYGUSUp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:20:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:45546 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750849AbYGUSUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:20:45 -0400
Received: (qmail invoked by alias); 21 Jul 2008 18:20:43 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp056) with SMTP; 21 Jul 2008 20:20:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Lk/1R1gFLO17Ta2NOe6rcYiSz+Lta8/566ttbso
	z3Xijv2+uOxYo3
X-X-Sender: gene099@racer
In-Reply-To: <20080721173511.GB5387@steel.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89379>

Hi,

On Mon, 21 Jul 2008, Alex Riesen wrote:

> For example - Cygwin.

Please enhance: your oneline is too long, and your commit message body too 
short.

> Can MSys folks please try it? I noticed it when the test
> t2103-update-index-ignore-missing.sh (the 5th case) started failing.

Since M$' documentation says "This member does not have a meaning for 
directories." about the member nFileSizeLow of WIN32_FILE_ATTRIBUTE_DATA 
which we use to implement a sane "lstat()", I think this bug hits MinGW 
(not MSys) as well.

Ciao,
Dscho
