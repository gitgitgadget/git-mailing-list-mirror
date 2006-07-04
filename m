From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Tue, 4 Jul 2006 09:53:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607040951390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060701232958.GC2513@lsrfire.ath.cx> <7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmfqqxlh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607032309190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607031552410.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 09:54:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxfjJ-0005bE-Gv
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 09:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWGDHxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 03:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWGDHxk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 03:53:40 -0400
Received: from mail.gmx.de ([213.165.64.21]:59079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750796AbWGDHxj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 03:53:39 -0400
Received: (qmail invoked by alias); 04 Jul 2006 07:53:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 04 Jul 2006 09:53:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607031552410.12404@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23266>

Hi,

On Mon, 3 Jul 2006, Linus Torvalds wrote:

> On Mon, 3 Jul 2006, Johannes Schindelin wrote:
> > 
> > Traversing is actually wrong. Clearing the marks does not mean to clear 
> > them on commits we did not even mark!
> 
> If we didn't mark them, then clearing them would be a no-op, so nobody 
> really cares.

My point being: if we try to clear commits we could not have possibly 
marked, because they were not yet parsed, this is wrong. Basically, I 
wanted to make the same point as you:

> This is why it is _wrong_ to care about the "parsed" bit when clearing the 
> flags.

I will have another look at the users of clear_commit_marks() tomorrow.

Ciao,
Dscho
