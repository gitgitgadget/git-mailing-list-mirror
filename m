From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-graft-ripple, a tool for permanently grafting
 history into a tree.
Date: Wed, 23 Nov 2005 16:40:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511231638080.8993@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11326926501602-git-send-email-ryan@michonline.com>
 <Pine.LNX.4.64.0511221652530.13959@g5.osdl.org> <20051123135150.GA16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 16:43:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eewjf-0007iZ-Jv
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 16:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVKWPkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 10:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVKWPkT
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 10:40:19 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54441 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751049AbVKWPkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 10:40:17 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A184813FA2F; Wed, 23 Nov 2005 16:40:16 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 871299F3DA; Wed, 23 Nov 2005 16:40:16 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6C6249F3D2; Wed, 23 Nov 2005 16:40:16 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E1EE013FA2F; Wed, 23 Nov 2005 16:40:15 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20051123135150.GA16995@mythryan2.michonline.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12635>

Hi,

On Wed, 23 Nov 2005, Ryan Anderson wrote:

> For some reason, my gut says that this goes too far.  I'm having a hard
> time pinning down a way to explain that.

I can pin down what my gut says:

- the old commits still exist, so the links are not invalid
- the commit message is signed off as is
- the process to find the correct new SHA1 is not straight-forward, i.e.
  one would need to introduce a recursion where now suffices a simple
  linear loop.

Ciao,
Dscho
