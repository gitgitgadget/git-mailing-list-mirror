From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 03:27:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605080327490.13794@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv>  <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
  <Pine.LNX.4.64.0605071718440.3718@g5.osdl.org> 
 <Pine.LNX.4.63.0605080303410.13588@wbgn013.biozentrum.uni-wuerzburg.de>
 <1147051300.17371.32.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 03:28:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcuXe-0005El-WC
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWEHB2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWEHB2E
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:28:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:21948 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932247AbWEHB2D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 21:28:03 -0400
Received: (qmail invoked by alias); 08 May 2006 01:28:01 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp018) with SMTP; 08 May 2006 03:28:01 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1147051300.17371.32.camel@dv>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19744>

Hi,

On Sun, 7 May 2006, Pavel Roskin wrote:

> On Mon, 2006-05-08 at 03:05 +0200, Johannes Schindelin wrote:
> > The ["blablabla"] syntax fails the is-it-obvious-what-this-does test. What 
> > *is* wrong with the " for " syntax? IIRC it was even proposed by you, and 
> > it happens to be backward compatible.
> 
> [branchdata]
> description = "netdev" for "Network device development"
> 
> and this
> 
> [branchdata]
> description = "Network device development" for "netdev"

The latter was how I recall the syntax proposed for proxies.

> Now, how can I get a description for the "netdev" branch by one
> git-repo-config command, without pipes?

	git-repo-config --get branchdata.description ' for netdev$'

Hth,
Dscho
