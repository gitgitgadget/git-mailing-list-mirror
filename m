From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Wed, 17 Aug 2005 23:36:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508172333180.17758@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
 <7vek8t7bva.fsf@assigned-by-dhcp.cox.net> <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
 <430375B3.3050307@pobox.com> <Pine.LNX.4.58.0508171253190.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 23:36:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5VZw-00049W-Vf
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 23:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVHQVgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVHQVgE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 17:36:04 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59272 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751299AbVHQVgC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 17:36:02 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 389ADE25A7; Wed, 17 Aug 2005 23:36:01 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 15558B0927; Wed, 17 Aug 2005 23:36:01 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DD6E8AD7EC; Wed, 17 Aug 2005 23:36:00 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 752ADE25A7; Wed, 17 Aug 2005 23:36:00 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508171253190.3553@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 17 Aug 2005, Linus Torvalds wrote:

> On Wed, 17 Aug 2005, Jeff Garzik wrote:
> > 
> > 2) Teach it to understand MIME, and not treat the MIME headers like part 
> > of the message.
> 
> [...]
> 
> Ergo: if somebody sends you mime-encoded patches, hit them with a baseball 
> bat (politely) and teach them not to do that. "Fixing" the tools really 
> will just make things worse if it means that you apply raw emails without 
> having edited them.

I'd say that QP and the MIME/alternate formats are not really the fault of 
the sender, but rather the mailer. So there might be value in supporting 
at least these, to make the life of maintainers easier.

Ciao,
Dscho
