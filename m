From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Mon, 12 Sep 2005 01:22:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509120119120.10594@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509111100260.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 12 01:24:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEbA7-0003U5-BE
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 01:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVIKXW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 19:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVIKXW6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 19:22:58 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59605 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751038AbVIKXW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 19:22:58 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 536231383A9; Mon, 12 Sep 2005 01:22:57 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3733188C0A; Mon, 12 Sep 2005 01:22:57 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 21F2687D66; Mon, 12 Sep 2005 01:22:57 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E78D61383A9; Mon, 12 Sep 2005 01:22:56 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509111100260.3242@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8341>

Hi,

On Sun, 11 Sep 2005, Linus Torvalds wrote:

> On Sun, 11 Sep 2005, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > I have three fixes in my personal tree without which git refuses to 
> > > compile:
> > >
> > > - daemon.c needs a define or typedef for socklen_t.
> > 
> > I still keep that patch around (the patch was end of July), but
> > have not touched it only because I did not hear from you asking
> > about its inclusion.
> 
> Side note: one simple solution for "socklen_t" is to just replace it with 
> "int".
> 
> Any operating system where socklen_t is anything else than "int" is 
> terminally broken. The people who introduced that typedef were confused, 
> and I actually had to argue with them that it was fundamentally wrong: 
> there is no other valid type than "int" that makes sense for it.

Linus, we all know that you are always right. Only that in this case you 
are just a little bit less right than usual. The introduction of this 
typedef was a sane thing to do, for the same reason it is a sane thing to 
use sensible variable names: documentation. It is _important_ that a 
program be easy to read for others. As a further candy, you can grep and 
even sed for socklen_t. Try that with every socklen_t substituted by int.

Ciao,
Dscho
