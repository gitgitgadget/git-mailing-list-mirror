From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Mon, 12 Sep 2005 02:21:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509120216030.11512@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509111100260.3242@g5.osdl.org>
 <Pine.LNX.4.63.0509120119120.10594@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509111631500.3242@g5.osdl.org> <Pine.LNX.4.58.0509111642110.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 12 02:24:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEc5T-00020x-GT
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 02:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVILAVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 20:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVILAVn
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 20:21:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:49367 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751101AbVILAVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 20:21:42 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D52BD136958; Mon, 12 Sep 2005 02:21:41 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B71B787E82; Mon, 12 Sep 2005 02:21:41 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 961CC87D66; Mon, 12 Sep 2005 02:21:41 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 261C5136958; Mon, 12 Sep 2005 02:21:41 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509111642110.3242@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8349>

Hi,

On Sun, 11 Sep 2005, Linus Torvalds wrote:

> On Sun, 11 Sep 2005, Linus Torvalds wrote:
> > 
> > And the really sad part is that before the standards bodies started
> > messing around with it, things really _did_ "just work". There was no 
> > question at all about what kind of type to use.
> 
> Btw, here's the result of the "documentation":
> 
> [lots of ugly code]
>
> isn't that nice? Before the "documentation", you could just use
> 
> 	int accept(int, struct sockaddr *, int *);
> 
> and it would work. EVERYWHERE. No autoconf crap required.
> 
> So don't talk to me about documentation. It's pure and unadulterated crap.

Okay. I have to admit that what you presented is a good argument.

However, the code I usually have to deal with is comparable to what you 
read on www.thedailywtf.com, and even a "socklen_t l;" with that type of 
code is more helpful than a simple "int l;", which might even be reused as 
something completely different.

That said, in a well designed and clean project, such as git, such types 
of documentation should not be necessary.

Ciao,
Dscho
