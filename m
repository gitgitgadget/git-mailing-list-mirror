From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Mon, 3 Jul 2006 23:08:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607032308120.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060701232958.GC2513@lsrfire.ath.cx> <7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607030957420.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 23:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxVf8-0003LJ-No
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWGCVIz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWGCVIz
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:08:55 -0400
Received: from mail.gmx.de ([213.165.64.21]:60551 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932126AbWGCVIz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 17:08:55 -0400
Received: (qmail invoked by alias); 03 Jul 2006 21:08:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 03 Jul 2006 23:08:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607030957420.12404@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23211>

Hi,

On Mon, 3 Jul 2006, Linus Torvalds wrote:

> 	/* Have we already cleared this? */
> 	if (!(mask & object->flags))
> 		return;
> 	object->flags &= ~mask;

I thought we already did this, and did not even check. My bad.

Ciao,
Dscho
