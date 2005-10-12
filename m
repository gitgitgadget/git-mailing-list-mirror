From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 23:15:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510122314450.9599@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
 <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
 <87vf02qy79.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510121355280.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Eggert <eggert@CS.UCLA.EDU>, Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:19:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPnwX-0003Cm-5M
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 23:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVJLVPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 17:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVJLVPR
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 17:15:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59284 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964819AbVJLVPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 17:15:15 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 58F6D13EEF3; Wed, 12 Oct 2005 23:15:14 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3FE119ECB5; Wed, 12 Oct 2005 23:15:14 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2AF99929A2; Wed, 12 Oct 2005 23:15:14 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 152E013EEF3; Wed, 12 Oct 2005 23:15:13 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510121355280.15297@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10050>

Hi,

On Wed, 12 Oct 2005, Linus Torvalds wrote:

> Yes, if people use "cat" to view patches, it can be dangerous. But that's 
> _their_ problem.

No, that is the cat's problem. Sorry, couldn't resist.

Ciao,
Dscho
