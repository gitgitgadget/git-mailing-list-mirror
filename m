From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Thu, 21 Sep 2006 11:10:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609211108140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmcudt3t.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609210208350.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyeld9c2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 11:10:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQKa8-0000vJ-Ir
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 11:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWIUJKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 05:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWIUJKg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 05:10:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:48534 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751078AbWIUJKf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 05:10:35 -0400
Received: (qmail invoked by alias); 21 Sep 2006 09:10:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 21 Sep 2006 11:10:33 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyeld9c2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27469>

Hi,

On Wed, 20 Sep 2006, Junio C Hamano wrote:

> I think the change to t/Makefile from 9c3796fc needs to be
> rethought.

I looked into 9c3796fc, and the change to t/Makefile is UTTER CRAP! What 
IDIOT has made that change? Oh wait, was me...

What about removing that creepy change to t/Makefile, and move your hack 
into test-lib.sh? It _should_ be safe, as _nothing_ in $HOME should affect 
the tests anyway.

Thoughts?

Ciao,
Dscho
