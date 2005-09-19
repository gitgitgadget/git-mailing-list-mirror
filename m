From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What to expect after GIT 0.99.7
Date: Mon, 19 Sep 2005 11:56:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509191152260.2519@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
 <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 11:57:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHINi-0000Nd-Ub
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 11:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVISJ4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVISJ4H
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 05:56:07 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48833 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932377AbVISJ4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 05:56:05 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 42A1213C3FF; Mon, 19 Sep 2005 11:56:02 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6FFE4B2FAC; Mon, 19 Sep 2005 11:56:02 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4F574B2F60; Mon, 19 Sep 2005 11:56:02 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 845EC13C3FF; Mon, 19 Sep 2005 11:56:01 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8849>

Hi,

On Sun, 18 Sep 2005, Linus Torvalds wrote:

> On Sun, 18 Sep 2005, Junio C Hamano wrote:
> > 
> > * Accept patches for more portability.
> > 
> >   * strcasestr() in mailinfo.  We may need compat/strcasestr.c;
> >     this is bugging OpenBSD folks.
> 
> Maybe something stupid like this?
>
> [...]

I like it. Git does not need a complicated Boyer-Moore algorithm, because 
that code path is not time critical.

However, I would like it a bit more, if it returned (const char*). After 
all, we do not need to comply with wrong interface definitions.

Ciao,
Dscho
