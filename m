From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not allow git-init-db to be called twice in the same
 directory
Date: Tue, 27 Dec 2005 15:01:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512271457200.17086@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512270053030.14928@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqz3ibhn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 15:01:50 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErFOa-0001tK-Kx
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 15:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVL0OBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 09:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVL0OBl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 09:01:41 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32723 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932309AbVL0OBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 09:01:41 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 44DAB1415B2; Tue, 27 Dec 2005 15:01:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 38F2D3430;
	Tue, 27 Dec 2005 15:01:40 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 1CF5387A;
	Tue, 27 Dec 2005 15:01:40 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0787E1415B6; Tue, 27 Dec 2005 15:01:40 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqz3ibhn.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14075>

Hi,

On Mon, 26 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > t5300 is also adapted, since it relies heavily on init-db not complaining 
> > when $GIT_DIR already exists.
> 
> I think it tries not to overwrite things that are already there
> and is meant to be safe to run in an already populated
> repository; e.g. you should be able to use it to pick up newly
> added templates.

Ah, that is a use case I missed. I don't work too much with templates 
(only on the shared repositories' machine)...

> Is there a particular reason running the current init-db twice
> is undesirable?

In my case, yes. When I do that, it means that I did not correctly 
change directories. I fscked up my private git repository twice that way.

I like your point, though.

Ciao,
Dscho
