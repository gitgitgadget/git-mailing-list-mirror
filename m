From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-mv submodule failure
Date: Sat, 20 Oct 2007 22:24:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710202223590.25221@racer.site>
References: <46dff0320710192301p3e1d88d5l3b662b72b051d920@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Yin Ping <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 04:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQue-0002xO-ND
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 04:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbXJUCv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 22:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbXJUCv0
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 22:51:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:37143 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750788AbXJUCvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 22:51:25 -0400
Received: (qmail invoked by alias); 20 Oct 2007 21:24:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 20 Oct 2007 23:24:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zMytyQewzDwMSoFZ8a/TPredPvB5L3Lbr1fw1I1
	xJbX/t1SxK6ggW
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320710192301p3e1d88d5l3b662b72b051d920@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61867>

Hi,

On Sat, 20 Oct 2007, Yin Ping wrote:

> project
>   .git
>   file1
>   submoudle
>      .git
>       file2
> 
> $ cd project
> $ git-mv submodule submodule1
> fatal: source directory is empty, source=submodule, destination=submodule1
> 
> However, the following is ok and rename is automatically detected
> $ cd project
> $ mv submodule submodule1
> $ git-add submodule1
> $ git-commit -a
> 
> which gives in vim:
> # Please enter the commit message for your changes.
> # (Comment lines starting with '#' will not be included)
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #   renamed:    submodule -> submodule1
> #

But of course .gitmodules is unaffected.  But it should be changed, too.

Ciao,
Dscho
