From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC][PATCH] for_each_ref() returning heads in wrong order
Date: Sat, 23 Sep 2006 19:20:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609231919510.25853@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060923160712.5890.73139.stgit@machine.or.cz>
 <20060923164759.GP8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 19:21:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRBBQ-000056-R7
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 19:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWIWRUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 13:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWIWRUp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 13:20:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:39339 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751331AbWIWRUp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 13:20:45 -0400
Received: (qmail invoked by alias); 23 Sep 2006 17:20:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 23 Sep 2006 19:20:43 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923164759.GP8259@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27604>

Hi,

On Sat, 23 Sep 2006, Petr Baudis wrote:

> Dear diary, on Sat, Sep 23, 2006 at 06:36:21PM CEST, I got a letter
> where Petr Baudis <pasky@suse.cz> said that...
> > Using the #next branch I've now hit a problem with git-fetch-pack
> > master choosing refs/bases/master (I geuss created by StGIT) instead
> > of refs/heads/master. The old upload-pack returned the refs in the order
> > heads-tags-everything_else but the new one just goes for whatever order
> > readdir() returns them in (modulo merging with packed refs). I actually
> > can't see the difference that caused this right now, though.

Why don't you just specify (or match) "heads/refs/master", so that 
git-fetch-pack cannot choose anything wrong to begin with?

Ciao,
Dscho
