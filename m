From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 15:21:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231518310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <200701222127.09601.johannes.sixt@telecom.at>
 <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701231322.32987.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jan 23 15:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9MX9-0000sw-R7
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 15:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbXAWOV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 09:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932950AbXAWOV5
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 09:21:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:37797 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932899AbXAWOV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 09:21:56 -0500
Received: (qmail invoked by alias); 23 Jan 2007 14:21:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 23 Jan 2007 15:21:55 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701231322.32987.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37523>

Hi,

On Tue, 23 Jan 2007, Andy Parkins wrote:

> On Tuesday 2007 January 23 11:32, Johannes Schindelin wrote:
> 
> > Maybe we have to go the other way round, just as POSIX git does: instead
> > of spawning the pager, we should _beginthread() the actual work, and
> > execl() the pager.
> 
> What about just forgetting paged output under Windows?  It's been a 
> while, but the only decent one that I ever found was LIST.COM, and 
> that's probably vanished now.

Uhm. You do understand that we use MinGW to port to, not _plain_ Windows? 
So we do have a "less".

> I haven't used Windows in a while, are pipes still as awful as they 
> were?  That is to say they cheated and redirected output to a temporary 
> file then redirected that file to the input of the second process.

That was not Windows. That was DOS.

> I can well imagine that in Windows I would find the paged output more 
> painful than useful.

Not if you are used to it.

If you have to open a window to write into, with scrollbars and all, you 
either have to wait for the revision walker to finish, or you update it 
constantly, which is a huge performance hit on Windows (and you have to 
jump through hoops to avoid flicker).

With less, on the other hand, you just exit the pager, or let it search 
through stdin. It is so much more convenient.

Ciao,
Dscho
