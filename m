From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Library?
Date: Mon, 28 Apr 2008 20:10:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804282009310.19187@eeepc-johanness>
References: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Patrick Altman <paltman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:12:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYmG-0004XD-D5
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934870AbYD1TKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934915AbYD1TKs
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:10:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:59348 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933730AbYD1TKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:10:47 -0400
Received: (qmail invoked by alias); 28 Apr 2008 19:10:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp025) with SMTP; 28 Apr 2008 21:10:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yuLR/7hTylHSZ/YOdodtMXCVgAXt6mVO2Ilm2RX
	n1hxXq799CYEsH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80589>

Hi,

On Mon, 28 Apr 2008, Patrick Altman wrote:

> I want to write a Mac OSX UI for git.
> 
> Is there a documented/undocumented API for interacting with git in process?
> Or would I be better off "shelling out" to the git command line?

There was a mail thread yesterday on exactly the same subject.  Bottom 
line: the recommended way is to fork()&&exec(), because I am sure you do 
not want to put in the work to make libgit.a reentrant.

Ciao,
Dscho
