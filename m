From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 03:05:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605080303410.13588@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <Pine.LNX.4.64.0605071718440.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 08 03:06:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcuCL-0002nb-3P
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWEHBGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWEHBGB
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:06:01 -0400
Received: from mail.gmx.de ([213.165.64.20]:34466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932239AbWEHBGA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 21:06:00 -0400
Received: (qmail invoked by alias); 08 May 2006 01:05:59 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp035) with SMTP; 08 May 2006 03:05:59 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605071718440.3718@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19739>

Hi,

On Sun, 7 May 2006, Linus Torvalds wrote:

> [...]
> 
> and if your branch names are purely alphabetical and lower-case, you can 
> now write
> 
> 	[branch.origin]
> 		remote = true
> 		url = git://git.kernel.org/...
> 		fetch = master
> 
> 	[branch.master]
> 		pull = origin
> 
> and it will be parsed _exactly_ the same as
> 
> 	["origin"]
> 		remote = true
> 		url = git://git.kernel.org/...
> 		fetch = master
> 
> 	["master"]
> 		pull = origin
> 
> while the [branch.origin] syntax allows old versions of git to happily 
> ignore it. So that would be a kind of cheesy work-around: the new 
> double-quoted format is only _required_ for any branch-names that have 
> special characters in it.

Eek.

The ["blablabla"] syntax fails the is-it-obvious-what-this-does test. What 
*is* wrong with the " for " syntax? IIRC it was even proposed by you, and 
it happens to be backward compatible.

Ciao,
Dscho
