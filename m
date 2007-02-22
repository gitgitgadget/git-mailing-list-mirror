From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 20:16:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222015040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xeqllxk.fsf@assigned-by-dhcp.cox.net> <7v4ppellev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221719030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6sif1ox.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 20:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKJQm-0005fk-0J
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 20:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbXBVTQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbXBVTQh
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 14:16:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:53492 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751780AbXBVTQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 14:16:36 -0500
Received: (qmail invoked by alias); 22 Feb 2007 19:16:34 -0000
X-Provags-ID: V01U2FsdGVkX18TI31VmUgTS8lKnK1Xn/a3c+DwB4tB0TfgTtUAjJ
	yD9g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vr6sif1ox.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40370>

Hi,

On Thu, 22 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Thinking about this deeper, I have to say I find my decision to use 
> > "--stdin" rather silly, given that I know the exact number of revisions, 
> > and their SHA1s.
> 
> The only worry I would have is if that exact number is too large
> that you cannot pass them sensibly in argv[].

I thought there is only a limitation in bash?

Well, anyway, I think that it makes sense writing just a little loop to 
find if we have the revs or not, to be able to warn about them properly.

I'll do that.

Ciao,
Dscho
