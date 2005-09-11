From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Mon, 12 Sep 2005 01:18:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509120115500.10414@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509111043430.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 12 01:19:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEb5s-0001at-UT
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 01:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVIKXSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 19:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVIKXSi
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 19:18:38 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51413 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751054AbVIKXSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 19:18:37 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 73612136814; Mon, 12 Sep 2005 01:18:36 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 549C9B2D18; Mon, 12 Sep 2005 01:18:36 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2C32958FC0; Mon, 12 Sep 2005 01:18:36 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 85EE2136814; Mon, 12 Sep 2005 01:18:35 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509111043430.3242@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8340>

Hi,

On Sun, 11 Sep 2005, Linus Torvalds wrote:

> I personally think autoconf is the devils tool, and have had much more 
> luck with
> 
>  - creating "compat" libraries that implement functions that some 
>    configurations don't have.
> 
>    Sometimes this involves renaming the function, in order to avoid 
>    clashes with broken implementations of same.

That was the original idea of autoconf...

>  - just ignoring the really broken systems (old HP-UX etc is terminally 
>    diseased, and simply not worth worrying about)

... which is sometimes no option.

> autoconf generates an unreadable mess that can't be fixed. Doing it by 
> hand at least means you can fix it.

A real pity! autoconf showed great promise in the first days. But then 
they started using m4 and other crud crept in.

All that said, autoconf still makes it easy to make a program or library 
portable. However, for git it would be overkill.

Ciao,
Dscho
