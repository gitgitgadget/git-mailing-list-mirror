From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] WinGit: include html pages from official git.git's html
 branch
Date: Sat, 29 Sep 2007 21:50:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709292149280.28395@racer.site>
References: <A835C8E8-8EC5-43B7-9252-8709214DE7AD@zib.de>
 <11910819531200-git-send-email-prohaska@zib.de> <11910819542185-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 22:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbjIQ-0002ut-Mt
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 22:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbXI2UwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 16:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbXI2UwK
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 16:52:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:38824 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753606AbXI2UwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 16:52:09 -0400
Received: (qmail invoked by alias); 29 Sep 2007 20:52:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 29 Sep 2007 22:52:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+I6Al7zf+INLSzoENexyGMA5RuoWMIQxh/9bQzMz
	GrCWbQWxEEbrQs
X-X-Sender: gene099@racer.site
In-Reply-To: <11910819542185-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59488>

Hi,

On Sat, 29 Sep 2007, Steffen Prohaska wrote:

> It is assumed that a matching version of the html documentation
> is available as the HEAD of /doc/git/html/.git. If not an error
> will be reported.
> 
> This patch doesn't include a mechanism to fetch the html pages
> to /doc/git/html/.git. You should manually clone them. Maybe
> this could handled as a submodule of msysgit?

I'd rather handle it as in git.git, as another branch, and not check it 
out in /git/html/, but rather use "git read-tree 
--prefix=/tmp/WinGit/share/git/html origin/html", or some such.

Ciao,
Dscho
