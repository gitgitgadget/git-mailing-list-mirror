From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Racy git: avoid having to be always too careful
Date: Wed, 9 Aug 2006 00:30:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608090030080.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
 <7virl7e8ed.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608081659320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6zrw352.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 00:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAa64-0008Bl-Fa
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 00:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWHHWap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWHHWap
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 18:30:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:38020 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965053AbWHHWao (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 18:30:44 -0400
Received: (qmail invoked by alias); 08 Aug 2006 22:30:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 09 Aug 2006 00:30:42 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6zrw352.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25093>

Hi,

On Tue, 8 Aug 2006, Junio C Hamano wrote:

> Another possibility is to tweak the heuristics -- currently we
> say 20 paths or 1/4 of whole paths is too many and would cause
> too much runtime hit but that was done without any measurement.
> We could raise the threashold which would solve the case for the
> testsuite whose trees are all small.

Okay, how about 100 paths? And make _this_ a config variable?

Ciao,
Dscho
