From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 21:47:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601102122001.30609@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601102010100.27199@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601101151090.4939@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 21:47:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQOy-0005e7-4p
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 21:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWAJUrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 15:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbWAJUrV
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 15:47:21 -0500
Received: from mail.gmx.de ([213.165.64.21]:60848 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932622AbWAJUrJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 15:47:09 -0500
Received: (qmail invoked by alias); 10 Jan 2006 20:47:08 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp034) with SMTP; 10 Jan 2006 21:47:08 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601101151090.4939@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14454>

Hi,

On Tue, 10 Jan 2006, Linus Torvalds wrote:

> So having multiple bad commits is _never_ interesting.

Okay, I got it. A bug is supposed to be inherited by *all* its 
descendants. Good.

I have to keep in mind that a commit is not actually a patch set, but can 
be two or more (in case of a merge). So, a bug can be present in a 
development line for a long, long time, but be visible only after a merge. 
Since that commit can be compared to at least two trees, one of these 
diffs must show the bug.

Thanks,
Dscho
