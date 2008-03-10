From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFE] git rebase doesn't say it failed
Date: Mon, 10 Mar 2008 12:10:08 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101207120.3975@racer.site>
References: <429AC7A2-511E-496F-9C1C-4627604EBBFB@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 12:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYfuT-00041g-FF
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 12:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYCJLKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 07:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbYCJLKG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 07:10:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:58277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751250AbYCJLKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 07:10:05 -0400
Received: (qmail invoked by alias); 10 Mar 2008 11:10:03 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 10 Mar 2008 12:10:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4VSQEpob4rcEYUsshghmcrqJ5EYcWQhb1xXfS0I
	4iDrOhYl24qPcE
X-X-Sender: gene099@racer.site
In-Reply-To: <429AC7A2-511E-496F-9C1C-4627604EBBFB@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76717>

Hi,

On Sun, 9 Mar 2008, Christian Holtje wrote:

> Hello!
> 
> What happened:
> I tried to do a rebase and got a message about files "needs update".
> However, it didn't say it did a rebase nor did it say that it failed.

It told you that a file is dirty.  Git kinda expects you to know that it 
will not start a rebase on a dirty working directory.

So there _was_ an (implicit) message saying that it failed.

> Git was unable to rebase due to the files above.  Please commit them or move
> them out of the way.
> Hint: See "git reset --help" for a suggestion about saving work in progress.

The same comment I gave last week applies here: people complained that Git 
was too chatty.  I tend to agree, since the important information was lost 
in the huge amount of text.  Now you say we should make it chatty again?

Hth,
Dscho
