From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Warning: cvsexportcommit considered dangerous
Date: Sun, 4 Nov 2007 23:46:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711042345260.4362@racer.site>
References: <Pine.LNX.4.64.0711041638270.4362@racer.site>
 <623F4AFA-FE43-4046-9D3F-435396BBE17D@zib.de> <Pine.LNX.4.64.0711042133330.4362@racer.site>
 <200711050005.28561.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Bennee <kernel-hacker@bennee.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IopC0-0006Rc-SB
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbXKDXrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 18:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbXKDXre
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:47:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:56828 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753318AbXKDXre (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:47:34 -0500
Received: (qmail invoked by alias); 04 Nov 2007 23:47:32 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp031) with SMTP; 05 Nov 2007 00:47:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+03GJaA4i0AFpsfdpf6yhyQGKJrRjGpbI0fenoTu
	RWmM5ia+GDp4R5
X-X-Sender: gene099@racer.site
In-Reply-To: <200711050005.28561.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63460>

Hi,

On Mon, 5 Nov 2007, Robin Rosenberg wrote:

> BTW, wouldn't this err on the right side anyway, i.e. if an existing 
> file was not up to date and was wrongly thought to not exist or a new 
> file was thought to be up-to-date, I would get an error and would not be 
> able to commit. I've never seen it though and I always have a clean CVS 
> checkout so the potential bug seems unlikely to me.

The problem is that it can err.  For example when I have new files, it 
says that the files were already added by someone else.  And then it 
refuses to do anything.

Ciao,
Dscho
